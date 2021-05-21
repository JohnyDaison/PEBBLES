event_inherited();

self.step_count += 1;

// COUNT TIME ON ENEMY SIDE
if(!gamemode_obj.is_coop && gamemode_obj.player_count == 2)
{
    var enemy_side = false;
    if(my_player.number == 1)
    {
        if(x > room_width/2 + 16)
            enemy_side = true;
    }
    else if(my_player.number == 2)
    {
        if(x < room_width/2 - 16)
            enemy_side = true;
    }
    
    if(enemy_side)
    {
        increase_stat(my_player, "time_on_opponents_half", 1, false);
    }
}

if(!self.levels_inited)
{
    self.max_doublejumps = my_player.levels[? "air_jump"];
    self.slot_maxnumber = my_player.levels[? "guy_orbit"];
    
    self.levels_inited = true;
}

// PREPARE ORBS
if(!self.orbs_ready)
{
    var col,ii,list, orb;
    for(col = g_black; col <= g_blue; col++)
    {
        if(col == g_yellow)
        {
            continue;
        }
        
        if(col == g_black)
        {
            belt_size[? col] = my_player.levels[? "black_belt_size"];
        }
        else
        {
            belt_size[? col] = my_player.levels[? "colors_belt_size"];
        }

        
        orb_belts[? col] = ds_list_create();
        orbs_in_use[? col] = ds_list_create();
        var in_use_list = orbs_in_use[? col];
        
        if((col == g_black && !mod_get_state("black_color")) || gamemode_obj.no_orbs_start)
        {
            ii = 0;
        }
        else
        {
            ii = my_player.levels[? "orbs" + string(col)];
        }
                
        for(; ii > 0; ii--)
        {
            orb = instance_create(x,y,color_orb_obj);
            orb.my_color = col;
            orb.tint_updated = false;
            orb.holographic = holographic;
                
            orb_transfer(orb, orb, "free", id, "belt");
            orb.newly_got_steps = 0;
        }
    }
    
    self.orbs_ready = true;
}

// PREPARE INVENTORY
if(!self.inventory_ready)
{
    inventory_size = my_player.levels[? "inventory"];
    for(var i=1; i<= inventory_size; i++)
    {
        if(inv_reserved[?i] != noone && !instance_exists(inventory[?i]))
        {
            var item = instance_create(x,y, inv_reserved[?i]);
            item.stack_size = 0;
            item.reserved = true;
            
            add_to_inventory(item);
            
        }
    }
    
    with(inventory_overlay)
    {
        if(my_player == other.my_player)
        {
            inv_size = -1;
        }
    }
    
    self.inventory_ready = true;
}

// END OF MATCH
if(gamemode_obj.limit_reached)
{
    self.frozen_in_time = true;
}

// NEW COLOR RESET
if((!is_npc && !self.auto_chosen_orbs) || current_slot == slot_maxnumber)
{
    ds_list_clear(new_colors);
}
self.auto_chosen_orbs = false;

// DEGRADE SPELL IF SLOT STOLEN
/*
if(self.slots_absorbed > charge_ball.orb_count && charge_ball.orb_count > 0)
{
    self.slots_absorbed = charge_ball.orb_count;
}
*/

// GO BLACK IF YOU HAVE NO SLOTS
/*
if(my_color != g_black && slot_number == 0 && mod_get_state("black_color"))
{
    my_color = g_black;
    self.slots_absorbed = 0;
    self.slots_triggered = false;
    self.current_slot = 0;
    color_updated = false;
    tint_updated = false;
    abi_triggered = false;
}
*/

// HANDLE CONTROLS

// CONTROL METHODS
if(!self.controls_updated && !is_npc)
{
    switch(self.control_set)
    {
        case no_control:
        {
            self.control_method = cpu_control;
            control_obj = noone;
            break;      
        }
        
        case cpu_control_set:
        {
            self.control_method = cpu_control;
            control_obj = noone;
            break;      
        }
        
        case keyboard1:
        {
            self.control_method = keyboard;
            control_obj = keyboard1_obj.id;
            ds_map_copy(self.keys,keyboard1_obj.binds);
            break;      
        }
        case keyboard2:
        {
            self.control_method = keyboard;
            control_obj = keyboard2_obj.id;
            ds_map_copy(self.keys,keyboard2_obj.binds);
            break;              
        }
        /*
        case joypad1:
        {
            self.control_method = joystick;
            control_obj = joystick1_obj.id;
            ds_map_copy(self.joys,joystick1_obj.binds);
            break;
        }
        case joypad2:
        {
            self.control_method = joystick;
            control_obj = joystick2_obj.id;
            ds_map_copy(self.joys,joystick2_obj.binds);
            break;
        }
        */
        case gamepad:
        {
            self.control_method = gamepad;
            with(gamepad_input_obj)
            {
                if(index == other.control_index)
                {
                    other.control_obj = id;
                    camera = other.my_player.my_camera;
                }
            }
            break;
        }
    }
    self.controls_updated = true;
}

// CONTROLS CHECKS
if(instance_exists(self.my_player) && my_player.number > 0 && !is_npc)
{
    // AIMING
    var xx = controlcheck(self.control_method, axis, aim_x);
    var yy = controlcheck(self.control_method, axis, aim_y);
    
    self.desired_aim_dir = point_direction(0,0, xx,yy);
    self.desired_aim_dist = point_distance(0,0, xx,yy);
    
    // SNAP AIM TO MAIN DIRECTIONS 
    if(self.desired_aim_dir < hor_aim_fix || (360-self.desired_aim_dir) < hor_aim_fix)
    {
        self.desired_aim_dir = 0;
    }
    else if(abs(90-self.desired_aim_dir) < ver_aim_fix)
    {
        self.desired_aim_dir = 90;
    }
    else if(abs(180-self.desired_aim_dir) < hor_aim_fix)
    {
        self.desired_aim_dir = 180;
    }
    else if(abs(270-self.desired_aim_dir) < ver_aim_fix)
    {
        self.desired_aim_dir = 270;
    }
    
    // LOOKING
    self.looking_up = false;
    self.looking_down = false;
    if(controlcheck(self.control_method, held, up))
    {
        self.looking_up = true;
    }
    if(controlcheck(self.control_method, held, down))
    {
        self.looking_down = true;
    }
    
    // RUNNING
    self.wanna_run = false;
    self.hor_dir_held = false;
    if(controlcheck(self.control_method, held, left))
    {
        self.wanna_run = true;
        self.hor_dir_held = true;        
        set_guy_facing(false);
    }
    if(controlcheck(self.control_method, held, right))
    {
        self.wanna_run = true;
        self.hor_dir_held = true;
        set_guy_facing(true);
    }
    
    // LOOK/RUN TOGGLE
    var look_held = controlcheck(self.control_method, held, look);
    
    if (singleton_obj.toggleable_aim_mode) {
        if (look_hold_start == -1 && look_held) {
            look_toggled_on = !look_on;
            look_hold_start = current_time;
            if (look_toggled_on) {
                look_on = true;
            }
        }
    
        if (look_hold_start != -1 && !look_held) {
            if (!look_toggled_on || (current_time - look_hold_start) >= look_hold_min_duration) {
                look_on = false;
                look_toggled_on = false;
            }
            look_hold_start = -1;
        }
    } else {
        look_on = look_held;
    }
    
    if(look_on || self.hold_mode)
    {   
        self.wanna_look = true;
        if(self.look_start == -1)
            self.look_start = step_count;
    }
    else
    {
        self.wanna_look = false;
        self.look_start = -1;
    }
    
    if(self.wanna_look && instance_exists(charge_ball))
    {
        self.wanna_run = false;
    }
    
    // JUMPING
    if(controlcheck(self.control_method,held,jump))
    {
        self.wanna_jump = true;    
    }
    if(controlcheck(self.control_method,free,jump))
    {
        self.wanna_jump = false;
    }
    
    // CASTING
    if(controlcheck(self.control_method,held,cast))
    {
        self.wanna_cast = true;
    }
    
    if(controlcheck(self.control_method,free,cast))
    {
        self.wanna_cast = false;
    }
    
    // CHANNELING
    if(controlcheck(self.control_method, held, channel))
    {
        self.wanna_channel = true;
    }
    
    if(controlcheck(self.control_method, free, channel))
    {
        self.wanna_channel = false;
    }
    
    
    // USE ITEMS
    for(i=1;i<=inventory_size;i++)
    {
        self.wanna_use[?i] = false;
        if(controlcheck(self.control_method, pressed, inventory_1 + i-1))
        {
            self.wanna_use[?i] = true;
        }
        self.stop_holding[?i] = false;
        if(controlcheck(self.control_method, released, inventory_1 + i-1))
        {
            self.stop_holding[?i] = true;
        }
    }
    
    // ALTFIRE
    if(controlcheck(self.control_method,pressed,altfire))
    {
        self.fire_cannon = !self.fire_cannon;
    }
    
    // ABI
    self.wanna_abi = false;
    if(controlcheck(self.control_method,pressed,abi))
    {
        self.wanna_abi = true;
    }
    
    // COLORS
    if(controlcheck(self.control_method,pressed,r))
    {
        ds_list_add(new_colors, g_red);
    }
    
    if(controlcheck(self.control_method,pressed,g))
    {
        ds_list_add(new_colors, g_green);
    }
    
    if(controlcheck(self.control_method,pressed,b))
    {
        ds_list_add(new_colors, g_blue);
    }
}

// SPEAKING
if(object_index == player_guy)
{
    if(speaking)
    {
        locked = true;   
    }
}

label_alpha = label_normal_alpha;
if(object_index == basic_bot)
{
    /*
    if(speaking)
    {
        label_alpha = label_speaking_alpha;
    }
    else if(has_spoken)
    {
        label_alpha = label_normal_alpha;
    }
    */
    
    if(seated || instance_exists(speech_popup_obj))
    {
        label_alpha = label_speaking_alpha;
    }

}

// RESET HAVE_JUMPED
if(!self.wanna_jump)
{
    self.have_jumped = false;
}

// HANDLE CONFUSION EFFECT
if(status_left[? "confusion"] > 0)
{
    if(self.hor_dir_held) //  && !(is_npc && is_general_npc) && npc_counter_confusion)
    {
        set_guy_facing(!self.facing_right);
    }
}

// HANDLE WALL-HOLD
if(self.holding_wall || self.climbing_up)
{
    self.locked = true;
}

// RESET ATTACKER AFTER TIME
if(last_attacker_map[? "player"] != noone && !lost_control && (singleton_obj.step_count - last_attacker_map[? "step"]) > att_forget_delay && status_left[? "burn"] == 0)
{
    last_attacker_reset();
}

// HANDLE ABILITY SCRIPTS
if(!self.frozen_in_time || self.flashing_back)
{
    //show_debug_message("abi_cooldown: "+string(abi_cooldown));
    //show_debug_message("abi_script_delay: "+string(abi_script_delay));  
    
    // during Rewind process only Rewind script
    var max_color = g_white;
    if(self.flashing_back)
    {
        max_color = g_black;   
    }
    
    // tick cooldowns, process scripts
    for(var i = g_black; i <= max_color; i++)
    {  
        abi_cooldown[?i] = max(0,abi_cooldown[?i]-1);
        
        if((step_count - abi_last_script[?i]) >= abi_script_delay[?i]
        && abi_script[?i] != empty_script)
        {  
            script_execute(abi_script[?i]);
            abi_last_script[?i] = step_count;
        }
    }
}


// HANDLE OVERRIDES AND CLEANUP
// (Are you sure the overrides are a good idea?)

// ACTION
/*
if(self.wanna_act)
{
    //self.wanna_run = false;
    self.wanna_cast = false;
    self.wanna_abi = false;
    self.wanna_channel = false;
    //self.wanna_look = false;
}
*/

// FORCED CHANNELING
if(self.forced_channel)
{
    self.wanna_channel = true;
    self.wanna_abi = false;
    self.wanna_cast = false;
}

// ABILITY
if(self.wanna_abi)
{
    self.wanna_cast = false;
    self.wanna_channel = false;
}

// CHANNELING
if(self.wanna_channel)
{
    self.wanna_cast = false;
    self.wanna_run = false;
    self.wanna_jump = false;
}

// CHANNELING CLEANUP
if(self.channeling) 
{
    //show_debug_message("END wanna_channel : " + string(wanna_channel) + " , full_my_color : " + string(full_my_color));
    if(!self.wanna_channel || self.interrupt_channel || lost_control)
    {
        // STOP SOUND
        my_sound_stop(my_channel_sound);
        soundtime = 0;
        
        // RESET   
        if(channel_orig_color != -1)
        {
            if(!mod_get_state("black_color")) //  || ds_list_size(orbs_in_use[? g_black]) == 0
            {
                set_my_color(channel_orig_color);
                guy_orbs_return(id);
            }
            else
            {
                set_my_color(g_black);
                slots_absorbed = 0;
                
                guy_orbs_return(id);
                chargeball_orbs_return(charge_ball);

                ds_list_clear(new_colors);
                //ds_list_add(new_colors, g_black);
                
                // CLEAR CHARGE BALL
                
            }
            
            if(instance_exists(charge_ball) && mod_get_state("black_color") && ds_list_size(orbs_in_use[? g_black]) > 0)
            {
                ds_list_add(new_colors, g_black);
                auto_chosen_orbs = true;
                // color_updated = false; - this bad
                charge_ball.my_color = my_color;
                charge_ball.tint_updated = false;
            }
            channel_orig_color = -1;
        }
        
        increase_stat(my_player, "channeling_time", channel_duration, false);
        
        channeling = false;
        channel_duration = 0;
        channeling_last_full_count = 0;
        //regen_coef = 1;
    }
    self.interrupt_channel = false;
}

// BLACK COLOR CHANGE IN LOST_CONTROL
if(self.wanna_channel && lost_control && my_color != g_black && mod_get_state("black_color"))
{
    set_my_color(g_black);
    slots_absorbed = 0;
}

// RESET WALL SLIDING
wall_sliding = false;

// MAIN STEP
if(!self.frozen_in_time)
{
    speed = min(speed,max_speed);
    var charge_ball_firing = (instance_exists(charge_ball) && charge_ball.firing);
    
    // HEALTH DEATH
    if(damage >= hp && !dead && mod_get_state("hp_death"))
    {    
        die_from_damage();

        // PLACE OUTSIDE ROOM HACK
        x = room_width + 1024;
        y = room_height + 1024;
        xprevious = x;
        yprevious = y;
        last_x = x;
        last_y = y;
        
        my_console_log("GUY " + string(name) + " HP DEATH - PLACED AT " + string(x) + "," + string(y));
    }

    // DEATH DETECTION
    if(( x < 0 || x > (room_width)
     || y > room_height) && !dead)
    {        
        die_from_falling();
    }
       
    // HANDLE BEAM FREEZE
    
    if(self.casting_beam)
    {
        self.wanna_look = true;
        if(self.look_start == -1)
            self.look_start = step_count;
        //self.hor_dir_held = true;
        self.locked = true;
        set_guy_facing(my_beam.facing_right);
    }
    
    // HANDLE IMPACT FREEZE
    
    if(self.after_impact)
    {
        self.locked = true;
    }
    
    // HANDLE FROZEN EFFECT
    if(self.status_left[? "frozen"] > 0)
    {
        self.locked = true;
        self.casting = false;
        self.charging = false;
        self.holding_wall = false;
        self.interrupt_channel = true;
        self.jumping_charge = 0;
    }
    
    // HANDLE GRAVITY AND FRICTION
    var downspeed;
    if(!self.climbing_up)
    {
        if(vspeed > 0 || (airborne && vspeed == 0))
        {
            self.jumping_peaked = true;
            downspeed = vspeed;
        } 
        else
        {
            downspeed = 0;
        }
        
        if(!airborne)
        {
            self.jumping_peaked = false;
        }
        
        touching_ground = false;
        var touching_terrain = noone;
        var touching_entity = noone;
        var meeting_entity = noone;
        
        touching_terrain = instance_place(x,y+downspeed+1,terrain_obj);
        if(instance_exists(touching_terrain))
        {
            touching_ground = true;
        }
        
        if(seated && !touching_ground)
        {
            touching_ground = true;
        }
        if(!touching_ground)
        {
            var structure = instance_place(x,y+downspeed+1, structure_obj);
            var structure2 = collision_point(x,bbox_bottom+downspeed+1, structure_obj, false, false);
            
            if(instance_exists(structure2) && (!structure2.holographic || self.holographic)
            && (!instance_exists(structure) || structure2.bbox_top > structure.bbox_top))
            {
                structure = structure2;
            }
            
            if(instance_exists(structure) && (!structure.holographic || self.holographic))
            {   
                meeting_entity = structure;
                
                if(structure.walkable && y < structure.bbox_top && vspeed >= 0 && bbox_bottom <= structure.bbox_bottom
                && iff_check("structure_not_enemy", id, structure))
                {
                    touching_ground = true;
                    touching_entity = structure;
                }
            }
        }
        
        if(!touching_ground)
        {
            var mob = instance_place(x,y+downspeed+1,mob_obj);
            if(instance_exists(mob) && (mob.holographic == self.holographic))
            {   
                meeting_entity = mob;
                if(mob.walkable && y < mob.bbox_top)
                {
                    touching_ground = true;
                    touching_entity = mob;
                }
            }
        }
        
        if(!touching_ground)
        {
            var field = instance_place(x,y+downspeed+1,gate_field_obj);
            if(instance_exists(field))
            { 
                meeting_entity = field;
                if(field.horizontal && vspeed >= 0 && y < field.bbox_top)
                {  
                    touching_ground = true;
                    touching_entity = field;
                }
            }
        }
        
        if(meeting_entity == noone
        || !(meeting_entity.walkable && iff_check("structure_not_enemy", id, meeting_entity)))
        {
            self.jumping_down = false;
        }
        
        if(self.airborne == false && !touching_ground) // && !self.stuck
        {
            //show_debug_message("enabling gravity for guy "+string(my_player.number));
            self.airborne = true;
            if(self.wanna_jump)
            {
                self.have_jumped = true;
            }
            self.jumping_charge = 0;
            self.after_impact = false;
            if(vspeed == 0 && !(instance_exists(my_spawner) && my_spawner.activated))
                vspeed = self.gravity_coef;
        }
        if(self.airborne == true && touching_ground) // && !self.stuck
        {
            if(instance_exists(touching_terrain))
            {
                //var feet_wall = instance_nearest(x-sign(hspeed)-16,bbox_bottom+downspeed-16,terrain_obj);
                move_contact_object(0, downspeed + 1, touching_terrain);
            }
            else if(instance_exists(touching_entity))
            {
                move_contact_object(0, downspeed + 1, touching_entity);
            }
            //move_contact_solid(270, downspeed+1);
            
            var handled = false;
            var bounced = false;
            var bounce_coef = 0;
            
            var status_bounce = self.status_left[? "bounce"] > 0;
            var wall_bounce = my_color != g_azure && instance_exists(touching_terrain) && touching_terrain.my_color == g_azure;
            
            self.holding_wall = false;
            
            if(vspeed > 2 && !handled) 
            { 
                if(status_bounce || wall_bounce)
                {
                    if(wall_bounce)
                    {
                        bounce_coef += 0.75;
                    }
                    if(status_bounce)
                    {
                        bounce_coef += sqrt(self.status_left[? "bounce"] / DB.status_effects[?"bounce"].max_charge);
                    }
                    
                    vspeed = -vspeed*min(1, bounce_coef);
                    handled = true;
                    bounced = true;
                    my_sound_play(guy_bounce_sound);
                }
                else if(self.lost_control && vspeed < impact_speed)
                {
                    vspeed = -vspeed*0.5;
                    handled = true;
                    self.airborne = false;
                    my_sound_play(land_sound);
                } 

            }
       
            if(!handled)
            {
                //show_debug_message("disabling gravity for guy "+string(my_player.number));
                self.airborne = false;
                self.have_dived = false;
                self.is_jumping = false;
                self.is_doublejumping = false;
                self.doublejump_count = 0;
                self.is_walljumping = false;
                self.have_walljumped = false;
                //self.walljump_charge = self.walljump_max_charge;
                
                if(touching_entity == noone
                || (touching_entity.object_index != jump_pad_obj
                && touching_entity.object_index != universal_pad_obj
                && touching_entity.object_index != gate_field_obj))
                {
                    if(vspeed >= impact_speed && gamemode_obj.mode != "volleyball")
                    {
                        if(instance_exists(touching_entity) && touching_entity.object_index == slime_mob_obj)
                        {
                            if(vspeed > touching_entity.splat_speed && abs(hspeed) < vspeed)
                            {
                                touching_entity.damage += vspeed - touching_entity.splat_speed;
                                with(touching_entity)
                                {
                                    last_attacker_update(other.id, "body", "damage");
                                }
                            }
                        }
                        
                        i = instance_create(x,y+24, impact_obj);
                        i.my_guy = id;
                        i.my_source = guy_obj;
                        i.my_player = my_player;
                        i.impact_force = speed/max_speed;
                        i.holographic = holographic;
                        my_sound_play(impact_sound);
                        viewshake(my_player.my_camera, 270, 12);
                        hspeed = 0;
                        
                        ubershielded = is_shielded(id, "uber");
                        
                        if(!ubershielded)
                        {
                            if(!self.lost_control)
                            {
                                self.after_impact = true;
                                self.locked = true;
                            }   
                            self.charging = false;
                        }
                        
                    }
                    else
                    {
                        if(instance_exists(touching_entity) && touching_entity.object_index == slime_mob_obj)
                        {
                            if(vspeed > touching_entity.splat_speed && abs(hspeed) < vspeed)
                            {
                                touching_entity.damage += vspeed - touching_entity.splat_speed; 
                                with(touching_entity)
                                {
                                    last_attacker_update(other.id, "body", "damage");
                                }
                            }
                        }
                        else if(abs(hspeed) > running_maxspeed || abs(vspeed) > jumping_burstpower)
                        {
                            my_sound_play(land_sound);
                        }
                        else if(!self.quiet_run && !self.holographic)
                        {
                            if(last_step_sound == 2)
                            {
                                my_sound_play(step1_sound);
                                last_step_sound = 1;
                            }
                            else
                            {
                                my_sound_play(step2_sound);
                                last_step_sound = 2;
                            }
                        }
                    }
                }
                
                gravity = 0;
                vspeed = 0;
                
                if(is_npc)
                {
                    self.have_jumped = false;
                }
                self.jumping_peaked = false;
            }
        }
    }
    
    if(self.airborne && !charge_ball_firing && !self.air_dashing) // && !self.stuck
    {
        gravity = self.gravity_coef;
    }
    
    if(self.airborne)
    {
        running = 0.5;
    }
    else
    {
        running = 1;
    }
    
    friction = max(orig_friction, 1.5 * gravity_coef * speed/max_speed);
    
    if(self.air_dashing)
    {
        friction = 0;
    }
    
    if(!airborne)
    {
        friction *= 1.5; 

        if(has_haste && status_left[? "slow"] == 0)
        {
            friction *= self.running_haste_mod; 
        }
        
        if(sliding)
        {
            friction *= 0.1;
            running *= 0.5;
            if(!(wanna_run && facing == sign(hspeed)) && abs(hspeed) > skid_speed)
            {
                set_guy_facing(!sign(hspeed));
            }
            
            i = instance_create(x,y+24,jump_burst_obj);
            i.min_dir = (direction +180) mod 360 - 3;
            i.max_dir = i.min_dir + 3;
            i.particle_count = 2;
        }    
    }
    
    // LAST STANDING POSITION
    if(!airborne && !lost_control)
    {
        last_standing_x = x;
        last_standing_y = y;
    }
    

    // HANDLE WALL JUMP

    if(self.holding_wall)
    {
        var xx = (x div 32)*32;
        var above_y = ((y div 32) -1)*32;
        var head_y = ((bbox_top+2) div 32)*32;
        var facing_block = instance_position(xx+facing*32, head_y, terrain_obj);
        
        if(my_color != g_blue && instance_exists(facing_block) && facing_block.my_color == g_blue && facing_block.energy > facing_block.behaviour_threshold)
        {
            wall_sliding = true;   
        }
        
        if(place_meeting(x+facing,y,terrain_obj) && instance_exists(facing_block) && !wall_sliding
        && !position_meeting(xx,above_y,terrain_obj) && !position_meeting(xx+facing*32,above_y,terrain_obj))
        {
            gravity = 0;
            walljump_begin_step = step_count;
        }
        else
        {
            if((step_count - walljump_begin_step) < walljump_grace)
            {
                gravity = 0;
            }
            else
            {
                gravity = gravity_coef*0.2;
            }
        }
    }
    if(self.climbing_up)
    {
        gravity = 0;
        friction = 0;
    }
    
    // HANDLE STATES
    
    if(status_left[? "frozen"] == 0)
    {
        if(self.facing_right)
        {
            facing = 1; 
        }
        else
        {
            facing = -1;
        }
    }
    
    if(self.has_haste)
    {
        running *= running_haste_mod;
    }
    
    if(status_left[? "slow"] > 0)
    {
        running *= self.running_slow_mod;
    }

    if(self.charging)
    {
        running *= 0.8;
    }
    
    if(self.casting)
    {
        running /= 3;
    }
    
    if(self.skidding)
    {
        running *= 0.4;
    }
    
    if(sprite_index == my_skin[? "guy_gettingdown"] || sprite_index == my_skin[? "guy_gettingup"] || sprite_index == my_skin[? "guy_crouch"])
    {
        running *= 0.66;
    }
    
    if(self.seated || self.locked)
    {
        running = 0;
    }
    
    // here was unstuck
    
    
    // HANDLE RUNNING
    
    if(self.wanna_run && !self.lost_control && !self.casting && !self.stuck) // && !self.charging
    {        
        // STATUS MODIFIERS
        if(status_left[? "slow"] > 0)
        {
            cur_max = self.slowed_maxspeed;
        }
        else
        {
            cur_max = self.running_maxspeed;
        }
        
        if(has_haste)
        {
            cur_max *= running_haste_mod;
        }
        
        // TERRAIN CHECK
        var facing_terrain = place_meeting(x+facing,y+vspeed, terrain_obj);
        
        // FIELD CHECK
        var facing_field = false;
        var inst = instance_place(x+facing,y+vspeed, filter_field_obj);
        
        if(inst != noone && inst.my_color != my_color && sign(hspeed) == facing)
        {
            with(inst)
            {
                if(collision_rectangle(x1-facing, y1-other.vspeed,
                                       x2-facing, y2-other.vspeed, other.id, false, true))
                {
                    facing_field = true;
                }
            }
        }
        
        if(!facing_field)
        {
            facing_field = place_meeting(x+facing,y+vspeed, gate_field_obj);
        }
        
        // SPEED UP
        if(!airborne && abs(hspeed) < cur_max && !facing_terrain && !facing_field)
        {
            hspeed += facing*self.running_power*running;
            if(abs(hspeed) > cur_max)
            {
                hspeed = facing*cur_max;
            }
        }
        
        // STOP VIBRATING
        if(abs(hspeed) < 1)
        {
            if(facing_terrain || facing_field)
            {
                hspeed = 0;
            }
        }
    }
    
    // STEPS
    if(!airborne && abs(hspeed) > 0 && !self.skidding && !self.charging  && !self.lost_control && !self.stuck && !self.quiet_run && !self.holographic)
    {   
        temp = step_frequency/(2+abs(1.5*hspeed));
        if(step_count-last_step >= temp/2)
        {
            if(instance_exists(meeting_entity) && meeting_entity.object_index == gate_field_obj)
            {
                my_sound_play_colored(wall_hum_sound, meeting_entity.my_color);
            }
            else
            {
            
                if(last_step_sound == 2)
                {
                    my_sound_play(step1_sound);
                    last_step_sound = 1;
                }
                else
                {
                    my_sound_play(step2_sound);
                    last_step_sound = 2;
                }
            }
            
            last_step = step_count;
        }
    }
    
    if(!airborne && abs(hspeed) == 0)
    {
        last_step = step_count;
    }
    
    // HANDLE JUMPING    
    if(!self.lost_control && !self.casting_beam && !self.locked && !self.stuck)
    {
        // JUMP DOWN        
        if(touching_entity != noone && touching_entity.walkable && self.looking_down
        && self.wanna_jump && !self.airborne && !self.have_jumped && !self.have_dived)
        {
            self.jumping_down = true;
            self.last_jumped_off = touching_entity.id;
            vspeed = self.jumping_burstpower/2;
            self.have_jumped = true;
            //self.have_dived = true;
            increase_stat(my_player, "jumps", 1, false);
        }
        
        // CHARGE
        if(self.wanna_jump && !self.airborne && !self.have_jumped && !self.have_dived)
        {
            
            jumping_max_charge = jumping_normal_charge;
            jumping_charge_speed = jumping_normal_charge_speed;
            
            var charged_jump_level = get_level(id, "charged_jump");
            if(charged_jump_level >= 1)
            {
                var jump_ratio = sqrt(charged_jump_level / 2);
                jumping_max_charge *= jump_ratio;
            }
            
            if(status_left[? "slow"] > 0)
            {
                jumping_max_charge *= jumping_slow_mod;
                jumping_charge_speed *= jumping_slow_mod;
            }
            
            if(status_left[? "bounce"] > 0)
            {
                jumping_max_charge *= jumping_bounce_mod;
            }
            
            if(has_haste)
            {
                jumping_charge_speed *= jumping_haste_mod;
            }

            if(self.jumping_charge == 0)
            {
                if(has_level(id, "charged_jump", 1))
                {
                    self.jumping_charge = jumping_charged_base_charge; 
                    my_sound_play(jump_charge_sound);
                }
                else
                {
                    self.jumping_charge = jumping_normal_base_charge;
                    self.wanna_jump = false; // trigger TAKE-OFF
                }
                
            }
            else
            {
                self.jumping_charge += jumping_charge_speed*(2-jumping_charge/jumping_max_charge);
            }
            
            if(self.jumping_charge > jumping_max_charge)
            {
                self.jumping_charge = jumping_max_charge;
            }
            
            
        }
        
        // TAKE-OFF
        if(!self.wanna_jump && !self.airborne && !self.locked && self.jumping_charge > 0)
        {          
            var cur_max_dist = 24*(jumping_max_charge/jumping_normal_charge);
            var cur_ratio = jumping_charge/jumping_max_charge;
            var cur_dist = cur_max_dist*(1-cur_ratio);
            var debug_str = "";
            
            i = instance_create(x-cur_dist,y+24,jump_burst_obj);
            i.min_dir = 180;
            i.max_dir = 180;
            i.charge_ratio = cur_ratio;
            i = instance_create(x+cur_dist,y+24,jump_burst_obj);
            i.min_dir = 0;
            i.max_dir = 0;
            i.charge_ratio = cur_ratio;
            
            // debug jump impulse
            debug_str += string(hspeed) + "|" + string(jumping_charge) + "|";
            
            if(sprite_index == my_skin[? "guy_crouch"])
            {
                self.jumping_charge *= 1.2;
            }
            if(self.sliding)
            {
                self.jumping_charge *= 0.8;
            }
            vspeed -= self.jumping_charge;
            
            hboost = facing*7*self.running_power*running;
            if(self.sliding)
            {
                hboost *= 0.5;
            }
            
            if(self.wanna_run
            && abs(hspeed+hboost) <= running_maxspeed 
            && !place_meeting(x+hspeed+hboost+facing, y, terrain_obj)
            && !place_meeting(x+hspeed+hboost+facing, y, gate_field_obj))
            {
                hspeed += hboost;
            }
            else
            {
                hboost = 0;   
            }
            
            // debug jump impulse
            debug_str += string(jumping_charge) + "|" + string(hboost);
            //create_text_popup(debug_str, g_white, id);
            
            my_sound_stop(jump_charge_sound);
            if(has_level(id, "charged_jump", 1))
            {
                my_sound_play(jump_sound);
            }
            else
            {
                my_sound_play(guy_bounce_sound);   
            }
            
            self.is_jumping = true;
            self.have_jumped = true;
            self.jumping_charge = 0;    
            increase_stat(my_player, "jumps", 1, false); 
        }
        
        // GLIDE/AIRBREAK
        if(self.airborne)
        {
            hboost = facing*self.running_power*running;
            
            if(self.wanna_run && !place_meeting(x+hspeed+hboost+facing,y,terrain_obj)
            && abs(hspeed+hboost) <= self.running_maxspeed)
            {
                hspeed += hboost;
            }
        }
        
        // HANDLE SEMI-AUTO CORNER HOLD
        if(self.airborne && self.wanna_run && self.wanna_jump && vspeed > 0
        && !self.have_dived && !self.holding_wall && !self.charging && !self.casting)
        {
            var xx = (x div 32)*32;
            var above_y = ((y div 32) -1)*32;
            var facing_block = instance_position(xx+facing*32, bbox_top, terrain_obj);
            
            if(my_color != g_blue && instance_exists(facing_block) && facing_block.my_color == g_blue && facing_block.energy > facing_block.behaviour_threshold)
            {
                wall_sliding = true;   
            }
            
            if(place_meeting(x+facing,y, terrain_obj)
            && !position_meeting(xx,above_y, terrain_obj)
            && instance_exists(facing_block) && !wall_sliding
            && !position_meeting(xx+facing*32,above_y, terrain_obj)) //1,49
            {
                self.holding_wall = true;
                walljump_begin_step = step_count;
                walljump_facing = facing;
                self.have_jumped = true;
                speed = 0;
                my_sound_play(step1_sound);
            }
        }
    
        // HANDLE SPECIAL JUMPS
        if(self.wanna_jump)
        {   
            // DIVE JUMP
            if(has_level(id, "dive_jump", 1))
            {
                if(self.airborne && self.looking_down && !self.have_jumped && !self.have_dived
                && doublejump_count < max_doublejumps && abs(vspeed) < dive_threshold)
                {
                    self.holding_wall = false;
                    self.locked = false;                
                    var dive_boost = self.jumping_divepower;
                    if(status_left[? "slow"] > 0)
                    {
                        dive_boost *= jumping_slow_mod;
                    }
                    vspeed += dive_boost;
                    //hspeed /= 2;
                    if(vspeed < 0)
                    {
                        vspeed = 0;
                    }
                
                    i = instance_create(x, y, jump_burst_obj);
                    i.min_dir = 45;
                    i.max_dir = 135;
                    i.particle_count = 30;
                    
                    i = instance_create(x, y, dive_wave_obj);
                    i.active = true;
                    i.my_guy = id;
                
                    self.have_dived = true;
                    //doublejump_count++;
                    doublejump_count = max_doublejumps;
                    my_sound_play(swoop_sound);
                    increase_stat(my_player, "jumps", 1, false);
                }
            }
            
            //BEGIN WALL JUMP
            if(has_level(id, "wall_hold", 1))
            {
                if(self.airborne && !self.looking_down && !self.have_jumped && !self.charging && !self.casting && !charge_ball_firing && self.wanna_run && !self.holding_wall && !self.sliding && !self.wall_sliding) // && self.walljump_charge > 0)
                {
                    if(place_meeting(x+facing,y,terrain_obj) && place_meeting(x+facing,y-40,terrain_obj))
                    {
                        self.holding_wall = true;
                        walljump_begin_step = step_count;
                        walljump_facing = facing;
                        self.have_jumped = true;
                        speed = 0;
                        my_sound_play(step1_sound);
                    }
                    else
                    {
                        // NOTE: If you are lucky and pull off the one-tick wall jump, 
                        // there is no code stopping you from doing that against a blue wall
                        if(place_meeting(x+hspeed-2*facing,y,terrain_obj) && place_meeting(x+hspeed-2*facing,y-40,terrain_obj))
                        {
                            self.holding_wall = true;
                            walljump_begin_step = step_count;
                            walljump_facing = -facing;
                            self.have_jumped = false;
                            move_contact_object(hspeed,vspeed,terrain_obj);
                            speed = 0;
                            my_sound_play(step1_sound);
                        }
                    }
                }
            }
            
            // AIR FLIP/DOUBLE JUMP
            if(airborne && !have_jumped && !is_doublejumping && doublejump_count < max_doublejumps
            /*&& !have_dived*/ && !looking_down && !holding_wall && vspeed > -jumping_burstpower)
            {
                vboost = jumping_burstpower;
                
                hboost = facing*running_power*5;
                
                if(status_left[? "slow"] > 0)
                {
                    vboost *= jumping_slow_mod;
                    hboost *= jumping_slow_mod;
                }
                
                if(wanna_run && !place_meeting(x+hspeed+hboost+facing,y,terrain_obj) && abs(hspeed+hboost) <= running_maxspeed) // 
                {
                    hspeed += hboost;
                }
                vspeed *= 0.5; // this is kinda cheaty 
                vspeed -= vboost;
                
                i = instance_create(x,y+24,jump_burst_obj);
                i.min_dir = 225;
                i.max_dir = 315;
                i.particle_count = 30;
                
                //hspeed /= 2;
                have_jumped = true;
                is_doublejumping = true;
                doublejump_start_step = step_count;
                doublejump_count++;
                //doublejump_facing = facing;
                my_sound_play(swoop_sound);
                increase_stat(my_player, "jumps", 1, false);
            }
            
            if(is_doublejumping && (step_count - doublejump_start_step)*flip_anim_speed >= 6)
            {
                is_doublejumping = false;
            }
        }
    }
    
    // WALLHOLD CANCEL
    if(self.holding_wall)
    {
        if((step_count - walljump_begin_step) > walljump_wait
        || !place_meeting(x+walljump_facing,y,terrain_obj)
        || (self.looking_down && self.wanna_jump))
        || self.charging
        {
            self.holding_wall = false;
            self.have_jumped = true;    
        }
    }
    
    // EXECUTE WALLJUMP
    if(self.holding_wall && self.wanna_jump && !self.lost_control && !self.have_jumped) // && self.walljump_charge > 0
    {
        var climb_blocked = place_meeting(x,y-24,terrain_obj) || place_meeting(x+facing*16,y-56,terrain_obj);
        // AWAY FROM WALL
        if(!place_meeting(x+facing,y,terrain_obj) && self.wanna_run)
        {
            if(has_level(id, "wall_jump", 1))
            {
                if(status_left[? "slow"] > 0)
                {
                    vboost = self.jumping_burstpower*0.8;
                    hboost = self.slowed_maxspeed*1.5;
                }
                else
                {
                    vboost = self.jumping_burstpower*1.5;
                    hboost = self.running_maxspeed*1.5;
                }
    
                hspeed = facing * hboost;
                vspeed = -vboost;
                
                i = instance_create(x,y+24,jump_burst_obj);
                i.min_dir = 225;
                i.max_dir = 315;
                i.particle_count = 30;
                
                i = instance_create(x-facing*7,y+9,jump_burst_obj);
                i.min_dir = 90+facing*90;
                i.max_dir = 90+facing*90;
    
                self.is_walljumping = true;
            }
        }
        // UP THE WALL
        else if(climb_blocked || !self.wanna_run)
        {
            if(has_level(id, "wall_climb", 1))
            {
                if(status_left[? "slow"] > 0)
                {
                    vboost = self.jumping_burstpower*0.8;
                }
                else
                {
                    vboost = self.jumping_burstpower*1.1;
                }
                
                if(!place_meeting(x,y-vboost,terrain_obj))
                {
                    i = instance_create(x,y+24,jump_burst_obj);
                    i.min_dir = 225;
                    i.max_dir = 315;
                    i.particle_count = 30;
                    
                    vspeed = -vboost;                    
                    self.is_walljumping = true;
                }
            }
        }
        // JUST CLIMBING UP A LEDGE HERE
        else if(self.wanna_run && !climb_blocked)
        {
            self.is_walljumping = false;
            self.climbing_up = true;
            increase_stat(my_player, "jumps", 1, false);
        }

        self.holding_wall = false;

        //self.walljump_charge -= 1;
        if(is_walljumping)
        {
            my_sound_play(swoop_sound);
            locked = false;
            self.have_jumped = true;
            self.is_walljumping = false;
            increase_stat(my_player, "jumps", 1, false);
        }
    }
        
    // HANDLE SLOT FILLING
    
    /*
    show_debug_message("new_colors: " + string(ds_list_size(new_colors)));
    show_debug_message("current_slot: "+string(current_slot));
    show_debug_message("slots_triggered: "+string(slots_triggered));
    */
    
    if(!self.slots_triggered && !self.casting && !charge_ball_firing && !self.lost_control)
    {
        var i, chbi, count = ds_list_size(new_colors);
        
        if(count > 0)
        {
            for(i=count-1; i>=0; i--)
            {
                var filled = false;
                var new_color = new_colors[|i];
                var first_orb = color_slots[|0];
                var first_color = -1;
                if(!is_undefined(first_orb) && instance_exists(first_orb))
                {
                    first_color = first_orb.my_color;
                }
            
                if(first_color != g_black && self.current_slot < self.slot_maxnumber)
                {            
                    if(self.current_slot == 0)
                    {
                        self.color_charge[? g_black] = 0;
                        self.color_charge[? g_red] = 0;
                        self.color_charge[? g_green] = 0;
                        self.color_charge[? g_blue] = 0;
                        self.potential_charge[? g_black] = 0;
                        self.potential_charge[? g_red] = 0;
                        self.potential_charge[? g_green] = 0;
                        self.potential_charge[? g_blue] = 0;
                    }
    
                    belt = orb_belts[? new_color];
                    if(!is_undefined(belt) && ds_exists(belt, ds_type_list))
                    {
                        slot = belt[|0];
                        if(!is_undefined(slot) && instance_exists(slot))
                        {
                            // BELT TO ORBIT
                            orb_transfer(slot, id, "belt", id, "orbit");
                            filled = true;
                        }
                        else
                        {
                            // CHARGEBALL TO ORBIT
                            slot = noone;
                            if(instance_exists(charge_ball))
                            {
                                for(chbi = charge_ball.orb_count-1; chbi >= 0; chbi--)
                                {
                                    slot = charge_ball.orbs[| chbi];
                                    if(instance_exists(slot) && slot.my_color == new_color)
                                    {
                                        orb_transfer(slot, charge_ball.id, "orbit", id, "orbit");
                                        filled = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    
                    if(filled)
                    {
                        if(new_color == g_black)
                        {
                            auto_cast = true;
                            if(DB.console_mode == "debug") // DB.console_mode == "test" ||
                            {
                                speech_instant("AUTO CAST DARK");
                            }
                        }
                        
                        self.potential_charge[? new_color] += 1;
                    }
                }
                
                ds_list_delete(new_colors, i);
            }
            /*
            self.potential_color = g_red*sign(potential_charge[? g_red])+
                                       g_green*sign(potential_charge[? g_green])+
                                       g_blue*sign(potential_charge[? g_blue]);
            self.potential_abi_name = ds_map_find_value(DB.abimap,self.potential_color);
            */
            
            //show_debug_message("slots " + string(potential_color) + "->");
            if(!channeling)
            {
                self.potential_color = g_red*sign(potential_charge[? g_red])+
                                            g_green*sign(potential_charge[? g_green])+
                                            g_blue*sign(potential_charge[? g_blue]);
                self.potential_abi_name = DB.abi_name_map[? self.potential_color];
            }
            //show_debug_message("slots " + string(potential_color)); 
        }        
        
    }
    
    // HANDLE COLOR ABSORBING
    //show_debug_message("slots_triggered: " + string(slots_triggered));
    
    if((self.current_slot > 0 || (self.current_slot == 0 && my_color == g_black)) && !self.color_updated)
    //if(!self.slots_triggered && !self.color_updated)
    {
        var next_color;
        //INIT
        var color_found = false;
        if(color_charge[? g_black] > 0)
        {
            next_color = g_black;
        }
        else
        {
            next_color = g_red*sign(color_charge[? g_red])+
                         g_green*sign(color_charge[? g_green])+
                         g_blue*sign(color_charge[? g_blue]);
        }
        
        // ABILITY
        if(self.abi_triggered && ((self.abi_slots_absorbed == self.current_slot) 
            || (self.abi_slots_absorbed > 0 && next_color == g_black)))
        {
            self.my_abi_color = next_color;
            //show_debug_message("absorbed abi color");
            color_found = true;
            //show_debug_message("color: "+string(next_color));
        }
        
        // ABSORB
        if(!self.abi_triggered && ((self.slots_absorbed == self.current_slot) 
            || (self.slots_absorbed > 0 && next_color == g_black))) // 
        {
            set_my_color(next_color);
            
            if(next_color == g_black)
            {
                self.slots_absorbed = 0;
            }
            
            color_found = true;
            //show_debug_message("absorbed cast color");
            //show_debug_message("color: "+string(next_color));
        }
        
        // UPDATE POTENTIAL COLOR
        if(color_found)
        {   
            //show_debug_message("color_found " + string(potential_color) + "->" + string(my_color));
            self.potential_color = my_color;
            self.potential_abi_name = DB.abi_name_map[? self.potential_color];
        }
        
        // RESET
        if(color_found || self.lost_control)
        {
            self.color_updated = true;
            self.current_slot = 0;
            self.slots_triggered = false;
            //show_debug_message("slots reset");
        }
    }
    
    // INVENTORY HANDLING
    for(i=1; i <= inventory_size; i++)
    {
        if(!self.lost_control && wanna_use[?i])
        {
            use_inv_item(i);    
            break;
        }
        
        if((self.lost_control || stop_holding[?i]) && instance_exists(held_item[?i]))
        {
            stop_holding_item(i);
            break;
        }
    }
    
    // SELF-DESTRUCT
    /*
    if(self.lost_control && !self.dead)
    {
        if(self.my_abi_color == -1 && (step_count - lost_control_step) > deathwish_warmup_time && !self.got_up)
        {
            self.potential_color = my_color;
            self.potential_abi_name = ds_map_find_value(DB.abimap,-1);
            self.ready_to_die = true;
            
            if(wanna_abi)
            {
                abi_selfdestruct();
            }
        }
        else
        {
            self.ready_to_die = false;
        }
    }
    */
    
    
    // HANDLE ABILITIES
    
    // TELEPORT MULTI-USE TIME WINDOW END
    var teleport_level = get_level(id, "teleport"), teleport_color = g_blue;
    if(abi_cooldown_length[? teleport_color] == 1)
    {
        if(teleport_uses_left < teleport_level
        && (step_count - teleport_first_use_step) > 60*teleport_level)
        {
            abi_cooldown_length[? teleport_color] = DB.abi_cooldowns[? teleport_color];
            abi_cooldown[? teleport_color] = abi_cooldown_length[? teleport_color];
            teleport_uses_left = teleport_level;
        }
    }
    
    // PERFORM ABILITY
    if(self.my_abi_color >= g_black)
    {
        if(self.status_left[? "frozen"] == 0 && (!self.lost_control || self.my_abi_color == g_black))
        {
            self.my_abi_tint = ds_map_find_value(DB.colormap,my_abi_color);
            
            // this string_lower call is bad for performance
            if(mod_get_state("abilities") && has_level(id, DB.abimap[? my_abi_color], 1))
            {
                effect_create_above(ef_firework,x,y,32,self.my_abi_tint);
                
                if(abi_cooldown[? my_abi_color] == 0)
                {
                    show_debug_message("abi color: "+string(my_abi_color));
                    
                    self.abi_script[? my_abi_color] = empty_script;
                    var success = script_execute(abilities[? my_abi_color]);
                    abi_cooldown[? my_abi_color] = abi_cooldown_length[? my_abi_color];
                    abi_last_used[? my_abi_color] = step_count;
                    abi_last_script[? my_abi_color] = step_count;
                    
                    if(success) {
                        increase_stat(my_player,"abilities",1,noone);
                        increase_stat(my_player,"abilities" + string(my_abi_color),1,noone);
                        increase_stat(my_player,"abilitystreak",1,noone);
                        increase_stat(my_player,"combo",1,noone);
                    
                        var params = create_params_map();
                        params[? "who"] = id;
                        params[? "abi_color"] = my_abi_color;
            
                        broadcast_event("ability_use", id, params);
                    }
                }
                else
                {
                     //if(self.my_abi_color != g_black)
                        my_sound_play(failed_sound);
                }
            }
        }
        self.my_abi_color = -1;
        self.slots_triggered = false;
        
        if(instance_exists(charge_ball))
        {
            chargeball_orbs_draw(charge_ball);
        }
    }
    
    // DEBUG
    /*
    if(my_player.number==1)
    {
        show_debug_message("WC: "+string(wanna_cast)+" HC: "+string(have_casted)+" WM: "+string(wanna_abi));
        show_debug_message("CA: "+string(slots_absorbed)+" CS: "+string(current_slot)+" CU: "+string(color_updated));
    }
    */
    
    //show_debug_message("color_updated: " + string(color_updated));
    //show_debug_message("casting: " + string(casting));
    
    /*
    if(!self.casting && self.color_updated
        && ((self.wanna_cast && !self.have_casted) || self.wanna_abi))
    {
        var a = 1;   
    }
    else
    {
        if(self.wanna_cast)
        {
            var a = 0;
        }
    }
    */
    
    // HANDLE SPELL AND ABI START
    var charge_ball_empty = true;
    if(instance_exists(charge_ball))
    {
        charge_ball_empty = charge_ball.energy == 0;
    }
    
    if(!self.casting && self.color_updated
        && ( ((self.wanna_cast || self.auto_cast) && charge_ball_empty && !self.charging && !self.have_casted) 
            || self.wanna_abi ) )
    {      
        //show_debug_message("slot trigger condition");
        
        // HANDLE ORB TRIGGERING
        
        if(!self.slots_triggered && self.current_slot > 0)
        {
            //show_debug_message("triggering slots");
            self.slots_triggered = true;
            first_slot = self.color_slots[|0];
            if(!is_undefined(first_slot) && instance_exists(first_slot))
            {
                self.active_slots = min(self.current_slot,self.slot_maxnumber);
            }
            else
            {
                self.active_slots = 0;
                self.slot_number = 0;
                self.current_slot = 0;
            }
            //show_debug_message("active_slots: "+string(self.active_slots));
            
            // IF ANY OF THE ORBS IS NOT READY, CANCEL THE TRIGGER
            for(i=0; i<self.active_slots; i+=1)
            {
                slot = self.color_slots[|i];
                if(!is_undefined(slot) && instance_exists(slot)) {
                    if(!(slot.color_added || slot.color_held))
                    {
                        self.slots_triggered = false;
                    }
                }
            }
            
            if(wanna_abi)
            {
                if(!mod_get_state("abilities") || !has_level(id, DB.abimap[? potential_color], 1))
                {
                    self.slots_triggered = false;
                }
            }
            
            //show_debug_message("did slots trigger: "+string(self.slots_triggered));
            
            // CONSUME ORBS AND DECIDE ABI
            if(self.slots_triggered)
            {
                self.potential_abi_name = "";
                
                for(i=0; i<self.active_slots; i+=1)
                {
                    slot = self.color_slots[| i];
                    if(is_undefined(slot))
                    {
                        my_console_log("UNDEFINED SLOT " + string(i));   
                    }
                    slot.color_consumed = true;
                    slot.color_added = false;
                    self.color_updated = false;
                }
                
                if(self.wanna_abi)
                {
                    self.abi_triggered = true;
                    self.abi_slots_absorbed = 0;
                }
                else
                {
                    self.abi_triggered = false;
                    /*
                    if(my_color == g_black)
                    {
                        self.ball_chargerate = 1;
                        self.ball_overcharge = 0;  
                    }
                    */
                    self.slots_absorbed = 0;
                }

                self.auto_cast = false;
                //show_debug_message("slots triggered");
            } 
        }    
        
        
        if(!self.lost_control && !self.slots_triggered && self.current_slot == 0 && !self.locked && !self.seated)
        {
            // START CHARGING
            if(self.wanna_cast && !self.have_casted && !self.wanna_abi && !self.charging)
            {
                if(instance_exists(charge_ball))
                {
                    if(!charge_ball.firing && charge_ball.orb_count > 0)
                    {
                        self.charging = true;
                        self.charge_start = self.step_count;
                    }
                }
            }
            
            // TRIGGER ABILITY
            if(self.wanna_abi)
            {
                self.my_abi_color = self.my_color;
            }
        }
        
        // FLASHBACK(REWIND) EXCEPTION
        if(self.wanna_abi && self.my_color == g_black && self.my_abi_color == -1 && !dead)
        {
            self.my_abi_color = self.my_color;
        }
    }
    
    // HANDLE AIMING
    
    if(!self.lost_control)
    {
        /*
        xx = 0;
        yy = 0;
        if(self.hor_dir_held) {
            xx = self.facing;
        }
        if(self.looking_up)
        {
            yy = -1;
        }
        else if(self.looking_down)
        {
            yy = 1;
        }
        */
        
        self.aim_dir = desired_aim_dir;
        self.aim_dist = desired_aim_dist * self.aim_base_dist;
        
        if(status_left[? "confusion"] > 0)
        {
            aim_dir = 90 - angle_difference(aim_dir, 90);
        }
    }

    // HANDLE CASTING
    
    if(self.charging && !self.wanna_cast && !self.lost_control)
    {
        if(!self.seated)
        {
            trigger(self.charge_ball);
        }
        else
        {
            charging = false;
        }
    }
    
    // HANDLE CHANNELING
    //show_debug_message("START wanna_channel : " + string(wanna_channel) + " , full_my_color : " + string(full_my_color));
    if(wanna_channel && has_level(id, "channeling", 1) && !charging && !casting && !lost_control && self.status_left[? "frozen"] == 0) // && (!airborne || channeling)
    {
        // CHANNELING BEGIN
        if(!channeling)
        {
            channel_start_step = step_count;
            channel_orig_color = my_color;
            channel_tint = DB.colormap[?my_color];
            set_my_color(g_white - my_color);
            self.potential_abi_name = "";
            channeling = true;
            channel_duration = 0;
            channeling_full = false;
            holding_wall = false;
            climbing_up = false;
            hspeed *= 0.5;
            
            with(overhead_overlay)
            {
                if(my_guy == other.id)
                {
                    chborbit_blink_time = chborbit_blink_rate*2;
                    belts_blink_time = belt_blink_rate*2;
                }
            }
            
            // WALL DRAIN INIT
            for(var ii=0; ii<slot_number; ii++)
            {
                var orb = color_slots[| ii];
                orb.read_terrain = true;
                orb.alarm[6] = 1;
            }
        }
        
        // RESET AFTER ADDING SLOT
        if(channeling_last_full_count < slot_number && channeling_full)
        {
            channeling_full = false;
            soundtime = 0;
        }
        
        // SOUND
        if(soundtime == 0)
        {
            my_channel_sound = my_sound_play(channel_sound);
            soundtime++;
        }
        
        // ENERGY BOOST
        var total_e_boost = min(channel_maxboost, channel_duration*channel_coef);
        var e_boost = 0, col, list, count;
        var full_orbs_count = 0;
        
        if(slot_number > 0)
        {
            e_boost = total_e_boost / slot_number;
        }
        
        // TOTAL EXTRA ENERGY
        total_orb_extra_energy = 0;
        for (col = g_red; col <= g_blue; col++)
        {
            if(col == g_yellow)
            {
                continue;
            }
                
            list = orbs_in_use[? col];
            if(!is_undefined(list) && ds_exists(list, ds_type_list))
            {
                var count = ds_list_size(list);
                for(i=0; i < count; i++)
                {
                    orb = list[| i];
                    var extra_energy = max(0, orb.energy - orb.base_energy);
                    //my_console_log("ORB: " + string(col) + " EXTRA: " + string(extra_energy));
                    total_orb_extra_energy += extra_energy;
                }
            }
        }
        
        // COUNT FULL ORBS
        if(total_orb_extra_energy >= self.max_channeled_energy)
        {
            full_orbs_count = slot_number;
            //my_console_log("TOTAL TOO HIGH");
        }
        else
        {
            // ADD BASIC BOOST
            for(i = 0; i < slot_number; i++)
            {
                var orb = color_slots[| i];
                orb.energy = min(orb.energy + e_boost, orb.max_energy);
                if(orb.energy >= orb.max_energy)
                {
                    full_orbs_count++;
                    //my_console_log("ORB TOO HIGH");
                }       
            }
        }
        
        // debug
        /*
        if(slot_number > 0)
        {
            my_console_log("total_orb_extra_energy: " + string(total_orb_extra_energy) + "/" + string(max_channeled_energy));   
        }
        */
        
        // FULL ORBS SOUND
        if(slot_number > 0 && full_orbs_count >= 1) //full_orbs_count == slot_number
        {
            my_sound_play(channeling_full_sound);
            channeling_full = true;
            channeling_last_full_count = slot_number;
        }
        
      
        // FULL ORBS EXPLOSION
        if(channeling_full)
        {
            //self.damage += self.channel_hp_cost*total_e_boost;
            channeling = false;
            my_sound_stop(my_channel_sound);
            
            if(!self.safe_channeling)
            {
                status_left[? "frozen"] += 30;
                spec_effect_to_guy(total_e_boost,"damage");
                var log_str = "Channeling failure";
                
                for(i = 0; i < slot_number; i++)
                {
                    var orb = color_slots[| i];
                    orb.energy = min(orb.energy, orb.base_energy);  
                    log_str += " " + string(orb.my_color);
                }
    
                i = instance_create(x,y,slot_explosion_obj);
                i.shrapnel_charge = 0.2;
                i.my_color = g_octarine;
                i.my_player = my_player;
                i.my_guy = id;
                i.my_source = guy_obj;
                i.holographic = holographic;
            
                lost_control = true;
                front_hit = true;
                hspeed -= total_e_boost;
                vspeed -= total_e_boost;
                
                my_console_log(log_str);
            } 
        }
        
        // NORMAL BEHAVIORS
        if(channeling)
        {
            // AUTO CHOOSE ORBS
            if(self.auto_choose_channel_orbs)
            {
                var minEnergyOrb = noone, belt, orb, chbi;
            
                if(slot_number < slot_maxnumber && channel_start_step < step_count && (step_count-channel_start_step) mod auto_choose_channel_orbs_delay == 0)
                {
                    if(slot_number == 0)
                    {
                        for (col = g_red; col <= g_blue; col++)
                        {
                            if(col == g_yellow)
                                continue;
                    
                            // Look at which orb will be picked for that color
                            // this copies heavily from HANDLE SLOT FILLING
                            belt = orb_belts[? col];
                            if(!is_undefined(belt) && ds_exists(belt, ds_type_list))
                            {
                                orb = belt[|0];
                                if(!is_undefined(orb) && instance_exists(orb))
                                {
                                    if(orb.energy >= (orb.max_energy - 3*channel_maxboost))
                                    {
                                        my_console_log("Auto choose avoided color c:" + string(col));
                                        continue;
                                    }
                                }
                                else
                                {
                                    orb = noone;
                                    if(instance_exists(charge_ball))
                                    {
                                        for(chbi = charge_ball.orb_count-1; chbi >= 0; chbi--)
                                        {
                                            orb = charge_ball.orbs[| chbi];
                                            if(instance_exists(orb) && orb.my_color == col)
                                            {
                                                if(orb.energy >= (orb.max_energy - 3*channel_maxboost))
                                                {
                                                    my_console_log("Auto choose avoided color c:" + string(col));
                                                    continue;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                    
                    
                            list = orbs_in_use[? col];
                            if(!is_undefined(list) && ds_exists(list, ds_type_list))
                            {
                                var count = ds_list_size(list);
                                for(i=0; i < count; i++)
                                {
                                    orb = list[| i];
                                    if(minEnergyOrb == noone || orb.energy < minEnergyOrb.energy)
                                    {
                                        minEnergyOrb = orb;
                                    }
                                }
                            }
                        }
                
                        if(instance_exists(minEnergyOrb))
                        {
                            ds_list_add(new_colors, minEnergyOrb.my_color);
                            //my_console_log("Auto choose added color c:" + string(minEnergyOrb.my_color));
                            self.auto_chosen_orbs = true;
                        }
                    }
                    else
                    {
                        var lastOrb = color_slots[| slot_number - 1];
                        
                        ds_list_add(new_colors, lastOrb.my_color);
                        //my_console_log("Auto choose added color c:" + string(lastOrb.my_color));
                        self.auto_chosen_orbs = true;
                    }
                }        
            }
        
            // ATTRACT SPARKS
            with(spark_obj)
            {
                if(!done_for)
                {
                    var dist = point_distance(x, y, other.x, other.y);
                
                    if(dist < other.channel_range)
                    {
                        var ratio = 1 - dist/other.channel_range;
                    
                        if(!airborne && speed == 0)
                        {
                            var ter = instance_nearest(x-16, y-16, terrain_obj);
                        
                            if(instance_exists(ter)) 
                            {
                                vspeed = sign(x-ter.x) * ratio * jump_power;
                                hspeed = 0;
                            }
                        }
                        motion_add(point_direction(x, y, other.x, other.y), ratio * other.channel_force);
                    }
                }
            }   
            
            
            // HOVERING
            var hover_phase = 2*(abs((channel_duration mod (2*hover_cycle_length)) - hover_cycle_length) / hover_cycle_length - 0.5);
        
            var hover_base = instance_nearest(x-16, y+hover_yoffset + hover_range*hover_phase, terrain_obj);
        
            // FIND HOVER BASE
            if(instance_exists(hover_base))
            {
                if(!place_meeting(x, y + hover_altitude + hover_range*hover_phase +1, hover_base))
                {
                    hover_base = instance_nearest(x, y+hover_yoffset + hover_range*hover_phase, structure_obj);
                    if(instance_exists(hover_base))
                    {
                        if(!place_meeting(x, y + hover_altitude + hover_range*hover_phase +1, hover_base) ||
                            !(hover_base.walkable && iff_check("structure_not_enemy", id, hover_base)))
                        {
                            hover_base = noone;
                        }
                    }           
                }
            
            }
        
            // APPLY HOVER
            if(instance_exists(hover_base))
            {
                var diff = (hover_base.y - hover_altitude - hover_range*hover_phase - y);
                vspeed = min(abs(diff/2), hover_speed)*sign(diff);
                if(!place_meeting(x, y + vspeed - 1, hover_base))
                {
                    gravity = 0;
                }
                else
                {
                    vspeed = 0;
                    gravity = gravity_coef;
                }
            }
            
            channel_duration++;
            //regen_coef = 1 + (step_count - channel_start_step)*channel_coef;
        }
    }
    
    // STATUS EFFECTS LIMITS
    
    clamp_status_effects();
    
    
    // HANDLE STATUS EFFECTS
    
    update_status_effects();
    
    // HANDLE CHANNELING EFFECT
    if(visible)
    {
        if(self.channeling)
        {
            if(!instance_exists(channel_effect))
            {
                channel_effect = instance_create(x,y,pixel_sucker_obj);
                channel_effect.my_guy = id;
            }
            else
            {             
                channel_effect.alarm[0] = 2;
                channel_effect.alarm[1] = 0;
                channel_effect.active = true;
            }
        }
    }
    
    // FOR TUTORIAL
    if(self.casting)
    {
        self.has_casted_ever = true;
    }
    
    // HANDLE LOST CONTROL
    
    if(self.lost_control)
    {            
        //self.fire_cannon = false;
        if(!self.hit_handled)
        {
            //show_debug_message("hit unhandled");
            self.lost_control_step = self.step_count;
            self.slots_triggered = false;
            self.potential_abi_name = "";
            
            guy_orbs_return(id);
            
            if(instance_exists(charge_ball))
            {
                chargeball_orbs_draw(charge_ball);
            }

            self.casting = false;
            self.charging = false;
            self.climbing_up = false;
            self.holding_wall = false;
 
            set_stat(my_player,"combo",0,noone);
        }
        if(self.hit_handled && !airborne && vspeed == 0 && !self.hit_ground && !self.stuck)
        {
            self.hit_ground = true;
            self.protected = true;
            alarm[2] = round(knockout_duration*(1 + damage/5) + recover_time);
            show_debug_message("Guy "+string(my_player.number)+" hit ground");
        }
        if(!airborne && abs(hspeed) < self.running_power && self.falling_down)
        {    
            self.at_rest = true;
            self.falling_down = false;
            alarm[1] = round(knockout_duration*(1 + damage/5));
            show_debug_message("Guy "+string(my_player.number)+" came to rest");
        }
        
        if(self.got_up == true)
        {
            self.wanna_cast = false;
            self.charging = false;
            self.casting = false;
            self.casting_hor = false;
            self.casting_beam = false;
            self.casting_up = false;
            self.casting_down = false;
            self.casting_shield = false;
            self.have_casted = false;
            self.wanna_abi = false;
            self.abi_triggered = false;
            self.lost_control = false;
            self.front_hit = false;
            self.back_hit = false;
            self.hit_handled = false;
            self.hit_ground = false;        
            self.falling_down = false;
            self.after_impact = false;
            self.at_rest = false;
            self.recovered = false;
            self.getting_up = false;
            self.got_up = false;
            self.my_abi_color = -1;
            self.ready_to_die = false;
            if(status_left[? "burn"] == 0)
            {
                last_attacker_reset();
            }
            
            self.potential_color = my_color;
            self.potential_abi_name = DB.abi_name_map[? self.potential_color];
        }
      
    }
    
    
    //*****************************************************************************
    // CHOOSE SPRITE
    
    sprite_chosen = false;
    
    // DON'T ANIMATE WHILE FROZEN
    if(status_left[? "frozen"] > 0) {
        sprite_chosen = true;
        
        if(!was_frozen) {
            was_frozen = true;
            prefrost_image_speed = image_speed;
            image_speed = 0;
        }
    }
    else if(was_frozen)
    {
        image_speed = prefrost_image_speed;
        prefrost_image_speed = 0;
        
        was_frozen = false;
    }
    
    
    // LOST CONTROL SEQUENCE 
    
    if(self.lost_control)
    {
        // GETTING HIT
        
        if(!sprite_chosen)
        {
            if(self.front_hit && !self.hit_handled)
            {
                sprite_index = my_skin[? "guy_hurt"];
                image_index = 0;
                image_speed = 0;
                self.hit_handled = true;
                sprite_chosen = true; 
            }
            if(self.back_hit && !self.hit_handled)
            {
                sprite_index = my_skin[? "guy_hurt"];
                image_index = 1;
                image_speed = 0;
                self.hit_handled = true;
                sprite_chosen = true;
            }
            if(self.step_count-self.lost_control_step >= hurt_duration && self.hit_handled && !self.hit_ground)
            {
                sprite_index = my_skin[? "guy_flybackwards"];
                image_index = 0;
                image_speed = 0;
                sprite_chosen = true;
            }
        }
        
        // HITTING GROUND
        
        if(!sprite_chosen)
        {
            if(self.hit_ground && !self.falling_down && !self.at_rest)
            {
                if(self.front_hit && sprite_index != my_skin[? "guy_knockedback"])
                {
                    sprite_index = my_skin[? "guy_knockedback"];
                    mask_index = guy_dead;
                    //self.stuck = false;
                    image_index = 0;
                    image_speed = lc_anim_speed;
                    sprite_chosen = true;
                    self.falling_down = true;
                }
                if(self.back_hit && sprite_index != my_skin[? "guy_knockedforward"])
                {
                    sprite_index = my_skin[? "guy_knockedforward"];
                    mask_index = guy_dead;
                    //self.stuck = false;
                    image_index = 0;
                    image_speed = lc_anim_speed;
                    sprite_chosen = true;
                    self.falling_down = true;
                }
            }
            
            if((self.falling_down || self.at_rest) && !self.recovered)
            {
                if(image_index+image_speed >= image_number-1 && sprite_index != my_skin[? "guy_dead"])
                {
                    sprite_index = my_skin[? "guy_dead"];
                    image_speed = 0;
                    if(self.front_hit)
                        image_index = 0;
                    if(self.back_hit)
                        image_index = 1;
                }
                sprite_chosen = true;
            }
        }
        
        // RECOVERING
        
        if(!sprite_chosen)
        {
            if(self.recovered && !self.got_up && !self.getting_up)
            {
                if(sprite_index != my_skin[? "guy_gettingup"])
                {
                    sprite_index = my_skin[? "guy_gettingup"];
                    mask_index = guy_stand;
                    //self.stuck = false;
                    image_index = 0;
                    image_speed = lc_anim_speed;
                    sprite_chosen = true;
                    self.getting_up = true;
                    y -= 16;
                    last_y -= 16;
                }
            }
            
            if(self.getting_up)
            {       
                if(sprite_index != my_skin[? "guy_gettingup"] || image_speed == 0)
                {
                    sprite_index = my_skin[? "guy_gettingup"];
                    mask_index = guy_stand;
                    //self.stuck = false;
                    image_index = 0;
                    image_speed = lc_anim_speed;
                }
                
                if(image_index + image_speed >= image_number-1)
                {
                    self.got_up = true;
                    self.getting_up = false;
                    sprite_index = my_skin[? "guy_stand"];
                }
                sprite_chosen = true;
            }
        }
    }
    
    // IN-CONTROL STATES
    
    else
    {
        // IMPACT
        
        if(!self.airborne && self.after_impact && !sprite_chosen)
        {
            if(sprite_index != my_skin[? "guy_crouch"] && sprite_index != my_skin[? "guy_gettingup"])
            {
                sprite_index = my_skin[? "guy_crouch"];
                image_index = 0;
                image_speed = 0.03; 
            }
            
            if(sprite_index == my_skin[? "guy_crouch"] && image_index >= 1-image_speed)
            {
                sprite_index = my_skin[? "guy_gettingup"];
                image_index = 0;
                image_speed = lc_anim_speed;
            }
            
            if(sprite_index == my_skin[? "guy_gettingup"])
            {       
                if(image_index+image_speed >= image_number -1)
                {
                    sprite_index = my_skin[? "guy_stand"];
                    self.after_impact = false;
                }
            }
            sprite_chosen = true;
        }
        
        
                
        // CHARGING    

        if(self.charging && !sprite_chosen)
        {
            if(sprite_index != my_skin[? "guy_charging"])
            {
                sprite_index = my_skin[? "guy_charging"];
                image_index = 0; 
            }
            sprite_chosen = true;
        }

        // CASTING HORIZONTALLY
        
        if(self.casting && self.casting_hor && !sprite_chosen)
        {
            if(!self.casting_beam)
            {
                if(sprite_index != my_skin[? "guy_casting_forward"])
                {
                    sprite_index = my_skin[? "guy_casting_forward"];
                    image_index = 0;
                    image_speed = self.casting_anim_speed; 
                }
                if(image_index+image_speed >= image_number)
                {
                    self.casting = false;
                    self.have_casted = true;
                    alarm[0] = round(spell_cooldown);
                }
            }
            else
            {
                if(sprite_index != my_skin[? "guy_charging"])
                {
                    sprite_index = my_skin[? "guy_charging"];
                    image_index = 0; 
                }    
            }
            sprite_chosen = true;
        }
        
        // CASTING BLACK AOE
        
        if(self.casting && self.casting_ring && !sprite_chosen)
        {
            if(sprite_index != my_skin[? "guy_fall"])
            {
                sprite_index = my_skin[? "guy_fall"];
                image_index = 1;
                image_speed = 0; 
            }
            sprite_chosen = true;
        }
        
        // CASTING VERTICALLY
        
        if(self.casting && self.casting_up && !sprite_chosen)
        {
            if(sprite_index != my_skin[? "guy_casting_up"])
            {
                sprite_index = my_skin[? "guy_casting_up"];
                image_index = 0;
                image_speed = self.casting_anim_speed; 
            }

            if(image_index+image_speed >= image_number)
            {
                self.casting = false;
                self.have_casted = true;
                alarm[0] = round(spell_cooldown);
            }
            
            sprite_chosen = true;
        }
        if(self.casting && self.casting_down && !sprite_chosen)
        {
            if(sprite_index != my_skin[? "guy_casting_down"])
            {
                sprite_index = my_skin[? "guy_casting_down"];
                image_index = 0;
                image_speed = self.casting_anim_speed; 
            }
            
            if(image_index+image_speed >= image_number)
            {
                self.casting = false;
                self.have_casted = true;
                alarm[0] = round(spell_cooldown);
            }
            
            sprite_chosen = true;
        }
        

        // CASTING SHIELD
        
        if(self.casting_shield && my_shield != noone && !sprite_chosen)
        {
            if(self.casting)
            {
                //sprite_index = my_skin[? "guy_charging"];
                //image_index = 0;
                //image_speed = 0;
                self.casting = false;
                self.casting_shield = false;
                self.have_casted = true;
                alarm[0] = round(spell_cooldown); 
            }
            
            sprite_chosen = true;
        }
        
        // CHANNELING
        
        if(self.channeling && !sprite_chosen)
        {
            if(sprite_index != my_skin[? "guy_channeling"])
            {
                sprite_index = my_skin[? "guy_channeling"];
                image_index = 0;
                image_speed = self.channeling_anim_speed; 
            }
            facing = 1;

            sprite_chosen = true;
        }
        
        
        // WALL CLIMBING   
    
        if(self.climbing_up && !sprite_chosen)
        {
            if(sprite_index != my_skin[? "guy_wallclimbup"])
            {
                sprite_index = my_skin[? "guy_wallclimbup"];
                image_index = 0;
                image_speed = self.climbing_anim_speed;
                
                nearest_wall = instance_nearest(x+facing-16,y-16,terrain_obj);
                
                if(facing == 1)
                {
                    orig_climb_x = nearest_wall.x - 7*facing;
                }
                else
                {
                    orig_climb_x = nearest_wall.x + 31 - 7*facing;
                }
                orig_climb_y = nearest_wall.y + 24; 
            }
            
            x = orig_climb_x + facing*climb_sequence[# floor(image_index), 0];
            y = orig_climb_y + climb_sequence[# floor(image_index), 1];
            
            if(image_index + image_speed >= 5)
            {
                self.climbing_up = false;
            }
            
            sprite_chosen = true;
        }
        
        // FLIPPING / DOUBLE JUMP
        
        if(self.airborne && self.is_doublejumping && !sprite_chosen)
        {
            if(sprite_index != my_skin[? "guy_flip"]) //  && sprite_index != my_skin[? "guy_backflip"]
            {
                sprite_index = my_skin[? "guy_flip"];
                image_index = 0;
                image_speed = flip_anim_speed;
            }
            
            sprite_chosen = true;
            
            if(sprite_index == my_skin[? "guy_flip"] && image_index+image_speed >= 6)
            {
                sprite_chosen = false;
                self.is_doublejumping = false;
            }
            /*
            if(sprite_index == my_skin[? "guy_backflip"] && image_index+image_speed >= 9)
            {
                sprite_chosen = false;
            }
            */
        }
        
        // JUMPING AND FALLING
        
        if(self.airborne && !sprite_chosen)
        {
            if(!self.jumping_peaked)
            {
                if(sprite_index != my_skin[? "guy_jump"])
                {
                    sprite_index = my_skin[? "guy_jump"];
                    image_speed = 0;
                    image_index = round(random(1));
                }
                
                sprite_chosen = true;
            }
            else
            {
                if(self.holding_wall)
                {
                    if(!place_meeting(x+facing,y,terrain_obj))
                    {
                        if(sprite_index != my_skin[? "guy_walljumphold"])
                        {
                            sprite_index = my_skin[? "guy_walljumphold"];
                            image_speed = 0;
                            image_index = 0;
                        }
                    }
                    else
                    {
                        if(sprite_index != my_skin[? "guy_wallclimbhold"])
                        {
                            sprite_index = my_skin[? "guy_wallclimbhold"];
                            image_speed = 0;
                            image_index = 0;
                        }   
                    }    
                }
                else
                {    
                    if(sprite_index != my_skin[? "guy_fall"])
                    {  
                        sprite_index = my_skin[? "guy_fall"];
                        image_speed = 0;
                    }
                    
                    if(sprite_index == my_skin[? "guy_fall"])
                    {
                        if(vspeed > impact_speed)
                        {
                            image_index = 0;
                        }
                        else
                        {
                            image_index = 1;
                        }
                    }
                }         
                   
                sprite_chosen = true;
            }
        }
        
        // SKIDDING
        
        if(!self.airborne && ((abs(hspeed) > skid_speed && facing != sign(hspeed)) || self.skidding) && !sprite_chosen )
        {
            if(sprite_index != my_skin[? "guy_skid"])
            {
                sprite_index = my_skin[? "guy_skid"];
                image_index = 0;
                image_speed = 0;
                self.skidding = true; 
            }     
            sprite_chosen = true;
            if(abs(hspeed) < 0.5 || facing == sign(hspeed))
            {
                self.skidding = false;
                sprite_chosen = false;
            }
        }
        
        
        // PRE-JUMP CROUCHING
        
        if(!self.airborne && (self.jumping_charge > 0 || self.looking_down) && abs(hspeed) < 1.5 && !sprite_chosen)
        {
            if(hspeed == 0)
            {
                if(sprite_index != my_skin[? "guy_gettingdown"] && sprite_index != my_skin[? "guy_crouch"])   
                {
                    sprite_index = my_skin[? "guy_gettingdown"];
                    image_speed = crouch_anim_speed;
                }
                
                if(sprite_index == my_skin[? "guy_gettingdown"] && image_index + image_speed >= 3)
                {
                    sprite_index = my_skin[? "guy_crouch"];
                    image_speed = 0;
                    image_index = 0;
                }
                sprite_chosen = true;
            }
            else
            {
                if(sprite_index == my_skin[? "guy_crouch"] || sprite_index == my_skin[? "guy_gettingdown"])   
                {
                    if(sprite_index == my_skin[? "guy_gettingdown"])
                    {
                        new_index = 3 - image_index;
                    }
                    else
                    {
                        new_index = 0;
                    }
                    sprite_index = my_skin[? "guy_gettingup"];
                    image_speed = crouch_anim_speed;
                    image_index = new_index;
                    
                }
                
                if(sprite_index == my_skin[? "guy_gettingup"])
                {
                    if(image_index + image_speed >= 3)
                    {
                        sprite_chosen = false;
                    }
                    else
                    {
                        sprite_chosen = true;
                    }
                }       
            }    
        }
        
        // RUNNING
        
        if(!self.airborne && abs(hspeed) > self.max_walking_speed && !sprite_chosen)
        {
            if(sprite_index != my_skin[? "guy_run"])
            {
                sprite_index = my_skin[? "guy_run"];
            }
            image_speed = abs(hspeed)*self.running_anim_speed;
            
            sprite_chosen = true;
        }

        // WALKING
        
        if(!self.airborne && abs(hspeed) != 0 && !sprite_chosen)
        {
            if(sprite_index != my_skin[? "guy_walk"])
            {
                sprite_index = my_skin[? "guy_walk"];
            }
            else
            {
                if(image_index <= 0)
                    image_index = 1;
            }
            
            image_speed = abs(hspeed)*self.walking_anim_speed;
            
            sprite_chosen = true;
        }

        // STANDING
        
        if(!self.airborne && !sprite_chosen)
        {
            if(sprite_index != my_skin[? "guy_stand"] && !self.idle)
            {
                sprite_index = my_skin[? "guy_stand"];
                self.idle = true;
                self.idle_start = step_count;
                idle_anim_start = random(180)+120;
                idle_anim_end = idle_anim_start + random(120)+60;
            }
            
            if(self.protected || self.locked)
            {
                self.idle_start = step_count;    
            }
            
            if(self.idle && step_count-idle_start > idle_anim_start)
            {
                if(sprite_index != my_skin[? "guy_idle"])
                {
                    sprite_index = my_skin[? "guy_idle"];
                    image_index = 0;
                    image_speed = self.idle_anim_speed;
                }
                if(image_index <= self.idle_anim_speed)
                {
                    if(step_count-idle_start > idle_anim_end)
                    {
                        self.idle = false;
                    }
                }
            }
            
            sprite_chosen = true;
        }
        else
        {
            self.idle = false;
        }
    }
    
    if(last_mask != mask_index)
    {
        guy_width = sprite_get_bbox_right(mask_index) - sprite_get_bbox_left(mask_index);
        guy_height = sprite_get_bbox_bottom(mask_index) - sprite_get_bbox_top(mask_index);
    }
    last_mask = mask_index;
    
    if(locked)
    {
        self.charging = false;
        self.casting = false;
    }
    
    locked = false;
}
else
{
    speed = 0;
    gravity = 0;
    image_speed = 0;
}

// HANDLE FLASHBACK QUEUE

if(!self.flashing_back && !self.stuck && !flashback_disabled)
{
    ds_map_replace(state,"x",x);
    ds_map_replace(state,"y",y);
    ds_map_replace(state,"speed",speed);
    ds_map_replace(state,"direction",direction);
    ds_map_replace(state,"sprite_index",sprite_index);
    ds_map_replace(state,"image_index",image_index);
    ds_map_replace(state,"tint",tint);
    ds_map_replace(state,"facing",facing);
    ds_map_replace(state,"airborne",airborne);
    ds_map_replace(state,"my_color",my_color);
    ds_map_replace(state,"slots_absorbed",slots_absorbed);
    ds_map_replace(state,"damage",damage);
    ds_map_replace(state,"lost_control",lost_control);
    map_str = ds_map_write(state);
    
    ds_list_add(self.flashback_queue,map_str);
    if(ds_list_size(self.flashback_queue) > flashback_max_steps)
    {
        ds_list_delete(self.flashback_queue, 0);
    }
}

if(hum)
{
    if(my_player != gamemode_obj.environment)
    {
        my_sound_play_colored(wall_hum_sound, hum_color, true);
    }
    hum = false;
}

// ADJUST LABEL ALPHA WHEN NEAR ITEMS
//var nearest_item = instance_nearest(x,y, item_obj); 
var nearest_items = find_nearest_instances(id, item_obj, 128, "with_label_not_mine", true);
var result = nearest_items[| 0];
if(!is_undefined(result))
{
    //var nearest_item = result[? "id"];
    //var dist = point_distance(x,y, nearest_item.x, nearest_item.y);
    //my_console_log("LA 1: " + string(label_alpha) + ", dist: " + string(dist) + ", radius: " + string(nearest_item.radius));
    //label_alpha = clamp( dist / (nearest_item.radius +128), 0, label_alpha);
    label_alpha = label_speaking_alpha;
    //my_console_log("LA 2: " + string(label_alpha));
}
