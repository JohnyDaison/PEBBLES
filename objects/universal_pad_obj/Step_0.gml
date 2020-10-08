visible = true;
gravity_direction = 270;
gravity = 0;
friction = 0;
speed = min(speed,max_speed);

// FALLING
if(airborne)
{
    gravity = 0.12;
    friction = 0.06;
    
    // FALL OUT OF BOUNDS
    if(y > room_height+32)
    {
        instance_destroy();
        exit;
    }
    
    // LANDING
    if(place_meeting(x+hspeed,y+vspeed, terrain_obj))
    {
        if(abs(speed) >= 1)
        {
            my_move_bounce(terrain_obj);
            // DAMPING
            vspeed *= 0.25;
            hspeed *= 0.6;
            
            // ONLY MAKE A SOUND IF THERE IS SOMEONE NEAR ENOUGH TO HEAR IT
            nearest_guy = instance_nearest(x,y,player_guy);
            if(nearest_guy != noone)
            {
                if(point_distance(x,y,nearest_guy.x,nearest_guy.y) < DB.sound_cutoff_dist)
                {  
                    my_sound_play(hit_ground_sound, true);
                    // TODO: Add structure_bounce_sound
                }
            }
        }
        else
        {
            y -= 1;
            speed = 0;
            gravity = 0;
            //center_y = y-hover_offset;
            airborne = false;
        }
    }
}
else
{
    if(!place_meeting(x,y+2,terrain_obj))
    {
        airborne = true;
    }
}

// ENERGY UPDATE
if(!self.active)
{
    cur_power += recharge_speed[? pad_color];
    cur_power = min(cur_power, max_power);
}

if(cur_power >= ready_power[? pad_color])
{
    self.ready = true;
}
else
{
    self.ready = false;
}

if(cur_power <= deactivate_power[? pad_color])
{
    self.active = false;
}

bright_tint = DB.colormap[? pad_color];
if(pad_color == g_octarine)
{
    bright_tint = singleton_obj.octarine_tint;
}
tint = merge_colour(dark_tint, bright_tint, cur_power/max_power);

if(pad_color <= g_black)
{
    self.ready = false;
    self.active = false;
    self.cur_power = 0;
}

if(burst_anim_sprite != noone)
{
    burst_anim_index += burst_anim_speed;
}

var collision_count = 0;
ds_list_clear(meeting_guys_list);

with(guy_obj)
{
    //COLLISION DETECTION
    if(vspeed >= 0)
    {
        var full_speed_meeting = place_meeting(x+hspeed,   y+vspeed +1,  other);
        var half_speed_meeting = place_meeting(x+hspeed/2, y+vspeed/2 +1,  other);
        var speed_coef = 0;
        if(full_speed_meeting)
        {
            speed_coef = 1;
        }
        if(half_speed_meeting)
        {
            speed_coef = 0.5;
        }
            
        if(full_speed_meeting || half_speed_meeting)
        {
            //show_debug_message('place_meeting passed');
            collision_count += 1;
                
            if(!other.active)
            {
                //show_debug_message(string(airborne) + ' ' + string(vspeed));
            }
            
            ds_list_add(other.meeting_guys_list, id);
            
            //show_debug_message("meeting guy " + string(id));
        }
    }
}

var guy_count = ds_list_size(blinked_guys_list), guy_i;
    
for(guy_i = guy_count-1; guy_i >= 0; guy_i--)
{
    var that_guy = blinked_guys_list[| guy_i];
    if(ds_list_find_index(meeting_guys_list, that_guy) == -1)
    {
        ds_list_delete(blinked_guys_list, guy_i);
    }
}
    

// ACTIVE STEP
if(self.ready || self.active)
{
    var guy_count = ds_list_size(meeting_guys_list), guy_i;
    
    for(guy_i = 0; guy_i < guy_count; guy_i++)
    { 
        var that_guy = meeting_guys_list[| guy_i];
    
        var y_diff = that_guy.bbox_bottom + that_guy.vspeed*speed_coef - (y+vspeed);
        var x_diff = that_guy.x + that_guy.hspeed*speed_coef - x;

        if(y_diff < 1 && abs(x_diff) <= sprite_width/2)
        {
            //show_debug_message("diffs: " + string(y_diff) + ' ' + string(x_diff));
                        
            // IMPACT PREVENTION
            i = instance_nearest(x, y, impact_obj);
            if(instance_exists(i))
            {
                with(i)
                {
                    if(my_guy == that_guy)
                    {
                        instance_destroy();
                    }
                }
            }

            // POWER BEHAVIOR
            if(!that_guy.wanna_run)  
            {
                // EFFECTS
                if(self.active)
                {
                    switch(pad_color)
                    {
                        case g_red:
                            // ORB RECHARGE TO BASE LEVEL
                            var energy_boost = orb_boost_coef * (cur_power/max_power);
                            var total_energy = 0;
                            var i,ii, diff;
                                        
                            for(i = g_black; i <= g_blue; i++)
                            {
                                if(i == g_yellow) continue;
                                            
                                var list = that_guy.orbs_in_use[? i];
                                            
                                if(!is_undefined(list) && ds_exists(list, ds_type_list))
                                {
                                    var count = ds_list_size(list);
                                    for(ii=0; ii < count; ii++)
                                    {
                                        orb = list[|ii];
                                        if(!is_undefined(orb) && instance_exists(orb))
                                        {
                                            diff = clamp(orb.base_energy - orb.energy, 0, energy_boost);
                                            //min(orb.energy + energy_boost, orb.base_energy)
                                            orb.energy += diff;
                                            total_energy += diff;
                                        }
                                    }
                                }
                            }
                                        
                            // POWER COST
                            cur_power -= total_energy * orb_boost_cost;
                            self.active = (total_energy > 0);
                                        
                            popup_string = "CHARGE!";
                                        
                            break;
                                    
                        case g_green:
                            // HEAL
                            var health_boost = health_regen_coef * (cur_power/max_power);
                            var diff;
                                        
                            diff = clamp(that_guy.damage - that_guy.min_damage, 0, health_boost);
                            that_guy.damage -= diff;
                                        
                            // POWER COST
                            cur_power -= diff*health_regen_cost;
                            self.active = (diff > 0);
                                        
                            popup_string = "HEAL!";
                                    
                            break;
                                        
                        case g_blue:
                            // COOLDOWNS
                            var cooldown_regen = cooldown_regen_coef*(cur_power/max_power);
                            var total_regen = 0;
                            var col, diff;
                                        
                            for(col=g_black; col<= g_white; col++)
                            {
                                diff = clamp(that_guy.abi_cooldown[? col]/that_guy.abi_cooldown_length[? col], 0, cooldown_regen);
                                that_guy.abi_cooldown[? col] -= diff*that_guy.abi_cooldown_length[? col];
                                total_regen += diff;
                            }
                                        
                            // POWER COST
                            cur_power -= total_regen*cooldown_regen_cost;
                            self.active = (total_regen > 0);
                                        
                            popup_string = "COOLDOWN!";
                                    
                            break;
                                        
                        case g_purple:
                            // SHIELD
                            var shield_boost = shield_boost_coef*(cur_power/max_power);
                            var diff = 0;
                                        
                            if(instance_exists(that_guy.my_shield))
                            {
                                var shield = that_guy.my_shield;
                                var target = min(shield.max_charge*3, shield.collapse_threshold);
                                diff = clamp(target - shield.charge, 0, shield_boost);
                                shield.charge += diff;
                            }
                                        
                            // POWER COST
                            cur_power -= diff*shield_boost_cost;
                            self.active = (diff > 0);
                                        
                            popup_string = "SHIELD!";
                                    
                            break;

                        case g_azure:
                            // JUMP
                            var jump_power = (cur_power/max_power) * jump_power_coef;
                                        
                            with(that_guy)
                            {
                                motion_add(90, jump_power);   
                            }
                            that_guy.y -= jump_power;
                                        
                            my_sound_play(guy_bounce_sound, true);
                                        
                            // POWER COST
                            self.cur_power = 0;
                            self.ready = false;
                            self.active = false;
                                        
                            popup_string = "JUMP!";
                                        
                            break;
                                        
                        case g_white:
                            // BASE TP
                            with(that_guy)
                            {
                                abi_base_teleport();
                            }
                                        
                            // POWER COST
                            self.cur_power = 0;
                            self.ready = false;
                            self.active = false;
                                        
                            popup_string = "RETURN!";
                                        
                            break;
                    }
                                
                    if(!text_popped && (!ready || burst_anim_sprite == universal_pad_burst_loop_spr))
                    {
                        create_text_popup(popup_string, pad_color, id, 0, -that_guy.sprite_height, true);
                        text_popped = true;
                                    
                        if(ds_list_find_index(blinked_guys_list, that_guy) == -1)
                        {
                            with(overhead_overlay)
                            {
                                if(my_guy == that_guy)
                                {
                                    if (other.pad_color == g_red)
                                    {
                                        chborbit_blink_time = chborbit_blink_rate*2;
                                        belts_blink_time = belt_blink_rate*2;
                                    }
                                    
                                    if (other.pad_color == g_blue)
                                    {
                                        abilities_blink_time = abilities_blink_rate*2;
                                    }
                                }
                            }
                            
                            with(healthbar_overlay)
                            {
                                if(my_guy == that_guy)
                                {
                                    if (other.pad_color == g_green)
                                    {
                                        own_hp_blink_time = own_hp_blink_rate*2;
                                    }
                                }
                            }
                                        
                            ds_list_add(blinked_guys_list, that_guy);
                        }
                    }
                                
                    if(pad_color > g_black)
                    {
                        if(burst_anim_sprite == noone)
                        {
                            burst_anim_sprite = universal_pad_burst_start_spr;
                            burst_anim_length = sprite_get_number(burst_anim_sprite);
                            burst_anim_index = 0;
                        }
                        else if(burst_anim_index+burst_anim_speed >= burst_anim_length)
                        {
                            burst_anim_sprite = universal_pad_burst_loop_spr;
                            burst_anim_length = sprite_get_number(burst_anim_sprite);
                            burst_anim_index = 0;
                        }
                                    
                        my_sound_play_colored(energy_pulse_sound, pad_color);
                    }
                }
                            
                // TRIGGERS
                if(self.ready)
                {
                    switch(pad_color)
                    {
                        case g_red:
                        case g_green:
                        case g_blue:
                        case g_purple:
                        case g_white:
                            self.active = true;
                                    
                            break;    
                                
                        case g_azure:
                            // JUMP
                            that_guy.x = x;
                            that_guy.y = y+vspeed -that_guy.sprite_height +that_guy.sprite_yoffset +1;
                            that_guy.speed = 0;
                            that_guy.gravity = 0;
                            that_guy.have_jumped = true;
                                        
                            self.active = true;
                            break;
                                    
                    }
                }
            }
        }
    }
}

if(collision_count == 0)
{
    self.active = false;
    text_popped = false;
}

gives_light = false;
if(burst_anim_sprite != noone)
{
    if(burst_anim_index+burst_anim_speed >= burst_anim_length)
    {
        if(burst_anim_sprite != universal_pad_burst_end_spr)
        {
            burst_anim_sprite = universal_pad_burst_end_spr;
            burst_anim_length = sprite_get_number(burst_anim_sprite);
            burst_anim_index = 0;
        }
        else
        {
            burst_anim_sprite = noone;
        }
    }
 
    if(burst_anim_sprite != noone)
    {
        var light_ratio;
    
        switch(burst_anim_sprite)
        {
            case universal_pad_burst_loop_spr:
                light_ratio = 1;
                break;
            case universal_pad_burst_start_spr:
                light_ratio = burst_anim_index/burst_anim_length;
                break;
            case universal_pad_burst_end_spr:
                light_ratio = 1-(burst_anim_index/burst_anim_length);
                break;
        }
    
        gives_light = true;
        ambient_light = 0.4 * light_ratio + 0.2;
        direct_light = 0.4 * light_ratio + 0.2;
    }
}

if(last_pad_color != pad_color)
{
    burst_tint = merge_color(DB.colormap[? pad_color], c_white, 0.25);
}

last_pad_color = pad_color;