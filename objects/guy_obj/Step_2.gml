// COMPUTE STUCK 
/*
if(push_success)
{
    if(speed > push_orig_speed)
    {
        speed = push_orig_speed;
    }
    push_success = false;
}
*/

if(instance_exists(chunkgrid_obj))
{
    // CHUNKED AWAY FIXES
    // CHARGEBALL 
    if(instance_exists(charge_ball) && charge_ball.object_index == data_holder_obj)
    {
        chunk_deregister(chunkgrid_obj, charge_ball);
        my_console_log("CHUNKED CHARGEBALL FIX");
    }

    // SHIELD
    if(instance_exists(my_shield) && my_shield.object_index == data_holder_obj)
    {
        chunk_deregister(chunkgrid_obj, my_shield);
        my_console_log("CHUNKED SHIELD FIX");
    }
    
    // ORBS
    if (orbs_ready) {
        var col, ii, list, orb, orb_count;
        for(col=g_dark; col<=g_blue; col++)
        {
            if(col == g_yellow)
            {
                continue;
            }
        
            list = orbs_in_use[? col];
            orb_count = ds_list_size(list);
        
            for(ii = 0; ii < orb_count; ii++)
            {
                orb = list[| ii];
                if(instance_exists(orb) && orb.object_index == data_holder_obj)
                {
                    orb.x = x;
                    orb.y = y;
                
                    chunk_deregister(chunkgrid_obj, orb);
                    my_console_log("CHUNKED ORB FIX");
                }
            }
        }
    }
    
    // ITEMS
    var item;
    for(ii = 1; ii <= inventory_size; ii++)
    {
        item = inventory[? ii];
        if(instance_exists(item) && item.object_index == data_holder_obj)
        {
            item.x = x;
            item.y = y;
            
            chunk_deregister(chunkgrid_obj, item);
            my_console_log("CHUNKED ITEM FIX");
        }
    }
}


var orig_x, orig_y, y_fix, back_steps, steps_made, col_detected, col_object;
var over_hlimit, over_vlimit, pre_damage, hor_impact, ver_impact, wall_dmg, i, ii, first_dir;
var ter_block, side_wall, vert_wall, head_free, near_head_ter;
var this_guy = id;

if(!self.climbing_up)
{
    orig_x = x;
    orig_y = y;
    back_steps = max(1,ceil(speed/10));
    steps_made = 0;
    col_detected = false;
    col_object = noone;
    if(!stuck)
    {
        back_hstep = (last_x-x)/back_steps;
        back_vstep = (last_y-y)/back_steps;
    }
    
    for(steps_made = back_steps-1; steps_made>=0 && !col_detected ;{};)
    {
        if(place_meeting(x+steps_made*back_hstep,y+steps_made*back_vstep,terrain_obj))
        {
            col_detected = true;
            col_object = terrain_obj;
        }
        else if(place_meeting(x+steps_made*back_hstep,y+steps_made*back_vstep,gate_field_obj))
        {
            col_detected = true;
            col_object = gate_field_obj;
        }
        /*
        else
        {
            var field = instance_place(x + steps_made*back_hstep, y + steps_made*back_vstep, filter_field_obj);
            
            if(instance_exists(field) && field.my_color != my_color) 
            {
                col_detected = true;
                col_object = filter_field_obj;
            }
        }
        */
        
        if(!col_detected)
        {
            steps_made -= 1;
        }
    }
    
    /*
    if(col_detected)
    {
        show_debug_message("steps_made "+string(steps_made));
    }
    */
    
    // HANDLE TERRAIN DESTRUCTION
    
    if(((col_detected && col_object == terrain_obj) || stuck) && status_left[? "bounce"] == 0)
    {
        // LIMITS
        over_hlimit = (abs(hspeed) > running_maxspeed*1.3);
        over_vlimit = (abs(vspeed) > jumping_burstpower*1.3);
       
        if(over_hlimit || over_vlimit || self.lost_control) 
        {
            pre_damage = damage;
            
            // TERRAIN LIST
            for(ii=0; ii<ter_list_length; ii+=1)
            {
                ter_block = ds_list_find_value(ter_list,ii);
                if(instance_exists(ter_block))
                {    
                    with(ter_block)
                    {
                        if(place_meeting(x,y, this_guy))
                        {
                            // HOR OR VER IMPACT
                            hor_impact = (over_hlimit && abs((y+16)-this_guy.y) < 16+this_guy.guy_height/2-abs(this_guy.vspeed));
                            ver_impact = (over_vlimit && abs((x+16)-this_guy.x) < 16+this_guy.guy_width/2-abs(this_guy.hspeed));
                            if(hor_impact || ver_impact)
                            {
                                // COLOR WALL
                                if(object_index == wall_obj)
                                {
                                    wall_dmg = this_guy.speed/this_guy.max_speed
                                    damage += wall_dmg;

                                    create_damage_popup(wall_dmg, g_dark, id);
                                    
                                    with(this_guy)
                                    {
                                        spec_effect_to_guy(0.05, "signal");
                                    }
                                    
                                    if(unstable)
                                    {
                                        falling = true;   
                                    }
                                }
                                
                                // FRONT-BACK HIT
                                if(this_guy.lost_control) //hor_impact && 
                                {
                                    if(sign(x-this_guy.x) != this_guy.facing)
                                    {
                                        this_guy.back_hit = true;
                                        this_guy.front_hit = false;
                                        //hit_handled = false;
                                    }
                                    else
                                    {
                                        this_guy.back_hit = false;
                                        this_guy.front_hit = true;
                                    }    
                                }
                                
                                // GUY DAMAGE
                                with(this_guy)
                                {
                                    damage += speed/(100);
                                    if(last_attacker_map[? "player"] == noone)
                                    {
                                        last_attacker_update(ter_block, "body", "damage");
                                    }
                                }
                            }                   
                        }
                    }
                }
            }
            
            // GUY DAMAGE POPUP
            diff = damage - pre_damage;
            create_damage_popup(diff, my_color, id, "wall");
            
            // STATS
            if (my_player.my_guy == id) {
                my_player.wall_dmg_total += diff;
            }
        }
    }
    
    // COMPUTE UNSTUCK
        
    if(col_detected)
    {           
        if(!self.stuck)
        {
            unstuck_h = 0;
            unstuck_v = 0;
            
            x = x+steps_made*back_hstep;
            y = y+steps_made*back_vstep;
            
            stuck_x = x;
            stuck_y = y;
            
            walking_up = false;
            unstuck_solved = false;
            
            if(wanna_run && !airborne && !skidding && vspeed == 0)
            {
                terr_ahead = instance_nearest( floor( (x+facing*16) /32)*32, bbox_bottom, terrain_obj);
                var diff = terr_ahead.y-1 -bbox_bottom;
                if(abs(diff) <= max_walkup_step && !place_meeting(x-hspeed-facing,y,terr_ahead) && place_meeting(x+facing,y,terr_ahead) && !place_meeting(x+facing,y+diff,terrain_obj))
                {
                    unstuck_h = 0;
                    unstuck_v = diff;
                    hspeed *= (1 - (0.45*abs(diff)/max_walkup_step));
                    walking_up = true;
                    unstuck_solved = true;
                }
            }
            
            var touch_field = instance_place(x,y,gate_field_obj);
            if(col_object == gate_field_obj && instance_exists(touch_field)
                /*&& (touch_field.my_player == gamemode_obj.environment || touch_field.my_player != my_player)*/)
            {
                if(touch_field.horizontal)    
                {
                    var dir = sign(touch_field.y - yprevious);
                    var diff = (touch_field.y - dir*touch_field.stop_dist) - (y+dir*25);
                        unstuck_v = diff;
                        vspeed = 0;
                        /*
                        unstuck_v = abs(vspeed) * diff/(touch_field.stop_dist+24);
                        if(abs(unstuck_v) < 1)
                        {
                            unstuck_v = sign(unstuck_v);
                        }
                        y += diff;
                        */
                        show_debug_message("unstuck case field 0.1"); 
                }
                else if(touch_field.vertical) 
                {
                    var dir = sign(touch_field.x - xprevious);
                    var diff = (touch_field.x - dir*touch_field.stop_dist) - (x+dir*9);
                        unstuck_h = diff;
                        hspeed = 0;
                        /*
                        unstuck_h = abs(hspeed) * diff/(touch_field.stop_dist+9);
                        if(abs(unstuck_h) < 1)
                        {
                            unstuck_h = sign(unstuck_h);
                        }
                        x += diff;
                        */
                        show_debug_message("unstuck case field 0.2"); 
                }
                
                if(unstuck_h == 0 && unstuck_v == 0 && !place_meeting(last_x,last_y,touch_field))
                {
                    unstuck_h = last_x - x;
                    unstuck_v = last_y - y;
                    show_debug_message("unstuck case field 404");
                }
            }
            
            if(col_object == terrain_obj && !unstuck_solved)
            {
                if(!place_meeting(x-hspeed/2,y-vspeed/2,terrain_obj))
                {
                    unstuck_h = -hspeed/2;
                    unstuck_v = -vspeed/2;
                    //show_debug_message("unstuck case 1.1"); 
                }
                
                if(!place_meeting(x-hspeed/2,y,terrain_obj))
                {
                    unstuck_h = -hspeed/2;
                    unstuck_v = -sign(vspeed);
                    //show_debug_message("unstuck case 2.1"); 
                }
                
                if(!place_meeting(x-hspeed/2,y+vspeed,terrain_obj) && abs(vspeed) > 1)
                {
                    unstuck_h = -hspeed/2;
                    unstuck_v = 0;
                    //show_debug_message("unstuck case 2.2"); 
                }
                        
                if(!place_meeting(x,y-vspeed/2,terrain_obj))
                {
                    unstuck_h = -sign(hspeed);
                    unstuck_v = -vspeed/2;
                    //show_debug_message("unstuck case 3.1"); 
                }
                
                if(!place_meeting(x+hspeed,y-vspeed/2,terrain_obj) && abs(hspeed) > 1)
                {
                    unstuck_h = 0;
                    unstuck_v = -vspeed/2;
                    //show_debug_message("unstuck case 3.2"); 
                }
                
                
                if(unstuck_h == 0 && unstuck_v == 0) 
                {
                    i = 0;
                    y_fix = -vspeed;
                    if (abs(y_fix) <= 1)
                        y_fix = sign(-vspeed);
                    if(y_fix == 0)
                        y_fix = -1;
                        
                    first_dir = sign(back_hstep);
                    if(first_dir == 0)
                    {
                        first_dir = -sign(hspeed);
                    }
                    if(first_dir == 0)
                    {
                        first_dir = round(random(1))*2 - 1;
                    }
                    
                    
                    while(place_meeting(x-i,y+vspeed,terrain_obj) && place_meeting(x+i,y+vspeed,terrain_obj)
                          && place_meeting(x-i,y+y_fix,terrain_obj) && place_meeting(x+i,y+y_fix,terrain_obj) && i <= max_speed)
                    {
                        i+=1;
                    }
                    
                    
                    /*
                    while(place_meeting(x+i,y+vspeed,terrain_obj) && place_meeting(x+i,y+y_fix,terrain_obj) && i <= max_speed)
                    {
                        i += step_dir;
                    }
                    */
                    if(!place_meeting(x-first_dir*i,y+y_fix,terrain_obj))
                    {
                        unstuck_h = -first_dir*i;
                        unstuck_v = y_fix;
                        //show_debug_message("unstuck case 5.1: "+string(-first_dir*i));
                    }
                    
                    if(!place_meeting(x+first_dir*i,y+y_fix,terrain_obj))
                    {
                        unstuck_h = first_dir*i;
                        unstuck_v = y_fix;
                        //show_debug_message("unstuck case 5.2: "+string(first_dir*i));
                    }
                    
                    if(!place_meeting(x-first_dir*i,y+vspeed,terrain_obj))
                    {
                        unstuck_h = -first_dir*i;
                        unstuck_v = 0;
                        //show_debug_message("unstuck case 6.1: "+string(-first_dir*i));
                    }
                    
                    if(!place_meeting(x+first_dir*i,y+vspeed,terrain_obj))
                    {
                        unstuck_h = first_dir*i;
                        unstuck_v = 0;
                        //show_debug_message("unstuck case 6.2: "+string(first_dir*i));
                    }
                }
        
                if(unstuck_h == 0 && unstuck_v == 0 && !place_meeting(last_x,last_y,terrain_obj))
                {
                    unstuck_h = last_x - x;
                    unstuck_v = last_y - y;
                    show_debug_message("unstuck case 404");
                }
            }
            
            //suffocation damage
            if(unstuck_h == 0 && unstuck_v == 0)
            {
                ter_block = instance_position(x,y-22,terrain_obj);
                
                if(ter_block)
                {
                    // GUY DAMAGE POPUP
                    diff = 0.01;
                    damage += diff;
                    create_damage_popup(diff, my_color, id, "suffocation");
                
                    last_attacker_update(ter_block, "body", "damage");
                
                    // STATS
                    if (my_player.my_guy == id) {
                        my_player.wall_dmg_total += diff;
                    }
                
                    self.jumping_charge = 0;
                }
            }
            
            //show_debug_message("got stuck");
            self.stuck = true;
            if(status_left[? "bounce"] > 0)
            {
                my_sound_play(guy_bounce_sound);
            }
            else
            {
                if(!holographic)
                {
                    if(instance_exists(touch_field))
                    {
                        my_sound_play_colored(wall_hum_sound, touch_field.my_color);
                    }
                    else
                    {
                        my_sound_play(hit_ground_sound);
                    }
                }
            }        
        }
        else
        {
            stuck = false;
            unstuck_h = 0;
            unstuck_v = 0;
        }
        /*
        else
        {
            if(!place_meeting(last_x,last_y,terrain_obj))
            {
                x = last_x;
                y = last_y;
                unstuck_h = 0;
                unstuck_v = 0;
    
                stuck = false;
                show_debug_message("unstuck case 4.04");
            }
        }
        */
        
        /*
        if(abs(unstuck_h) < 1 && abs(unstuck_v) < 1)
        {
            unstuck_h = sign(unstuck_h);
            unstuck_v = sign(unstuck_v);
        }
        */    
        //show_debug_message("unstuck_h: "+string(unstuck_h)+", unstuck_v: "+string(unstuck_v));
    
    }
    else
    {
        self.stuck = false;
        self.unstuck_h = 0;
        self.unstuck_v = 0;
        self.last_x = x;
        self.last_y = y;
    } 
}

// HANDLE TOUCHING WALL BEHAVIOURS AND STATUS EFFECT
self.sliding = false;
self.quiet_run = false;

if(self.warmed > 0)
    self.ball_chargerate -= self.warmed;
self.warmed = 0;

var always_sliding = mod_get_state("always_sliding");

if(always_sliding && place_meeting(x,y+1,solid_terrain_obj)) {
    if(speed > 0) {
        sliding = true;
    }
}

for(ii=0; ii<ter_list_length; ii+=1)
{
    ter_block = ds_list_find_value(ter_list,ii);
    if(instance_exists(ter_block))
    {
        if(ter_block.object_index == wall_obj)
        {        
            with(ter_block)
            {
                if(place_meeting(x,y-1,this_guy) || place_meeting(x,y+1,this_guy) || place_meeting(x-1,y,this_guy) || place_meeting(x+1,y,this_guy))
                {
                    if(energy > behaviour_threshold && this_guy.my_color == my_color)
                    {
                        // TODO: ORB REPLENISH
                    }
                    if(energy > behaviour_threshold && this_guy.my_color != my_color && !this_guy.protected)
                    {
                        // BEHAVIOURS
                        switch(my_color)
                        {
                            case g_red:
                                // Warmth
                                if(this_guy.status_left[? "frozen"] > 0 && this_guy.step_count mod 4 == 0)
                                {
                                    this_guy.status_left[? "frozen"] -= 1;
                                    effect_create_above(ef_smokeup, this_guy.x,this_guy.bbox_top,1, c_white);
                                }
                                this_guy.warmed += 0.2;
                                this_guy.ball_chargerate += 0.2;
                                this_guy.damage += this_guy.sear_tick_damage;
                                i = create_damage_popup(this_guy.sear_tick_damage, g_red, this_guy, "burn");
                                i.visible = false;
                                if(this_guy.step_count mod 10 == 0)
                                {
                                    effect_create_below(ef_star, this_guy.x,this_guy.bbox_bottom,1, DB.colormap[? my_color]);
                                }
                                break;
                            case g_green:
                                // Slowed slightly
                                if(this_guy.speed > 0 && !this_guy.skidding) {
                                    this_guy.speed *= 0.975;
                                    if(this_guy.last_step == this_guy.step_count)
                                    {
                                        effect_create_below(ef_firework, this_guy.x,this_guy.bbox_bottom,0, DB.colormap[? my_color]);
                                    }
                                }
                                break;
                            case g_blue:
                                // Ice floor sliding
                                if(this_guy.speed > 0) 
                                {
                                    this_guy.sliding = true;
                                }
                                if(this_guy.step_count mod 20 == 0)
                                {
                                    effect_create_above(ef_spark, this_guy.x-6+irandom(12),this_guy.bbox_bottom,2, c_white);
                                }    
                                break;
                            case g_yellow:
                                // Slight speed-up
                                if(this_guy.speed > 0 && !this_guy.skidding && this_guy.hor_dir_held) {
                                    this_guy.speed *= 1.02;
                                    if(this_guy.last_step == this_guy.step_count)
                                    {
                                        effect_create_below(ef_spark, this_guy.x,this_guy.bbox_bottom,1, DB.colormap[? my_color]);
                                    }
                                }
                                break;
                            case g_cyan:
                                // No footsteps and bouncy(in Step event)
                                this_guy.quiet_run = true;
                                break;
                            case g_magenta:
                                // ??
                                /*
                                if(this_guy.step_count mod 20 == 0)
                                    effect_create_above(ef_smoke, this_guy.x+this_guy.hspeed,this_guy.y+this_guy.vspeed+random(48)-24,1, DB.colormap[? my_color]);
                                */
                                break;
                            case g_white:
                                
                                break;
                        }
                    }
                    
                    // STATUS EFFECTS
                    if(energy > status_threshold)
                    {
                        with(this_guy)
                        {
                            spec_effect_to_guy(0.01, "signal");
                        }
                    }
                }
            }
        }
    }
}

// APPLY UNSTUCK

//show_debug_message("final unstuck h: "+string(self.unstuck_h));
//show_debug_message("final unstuck v: "+string(self.unstuck_v));
status_left[? "bounce"] = max(0, status_left[? "bounce"]);
var bounce_coef = 1;

if(self.unstuck_h != 0)
{
    if(status_left[? "bounce"] > 0)
    {
        bounce_modifier = abs(hspeed)*bounce_coef;
    }
    else
    {
        bounce_modifier = min(abs(hspeed),1);
    }
    
    if(self.lost_control || status_left[? "bounce"] > 0)
    {
        hspeed = sign(self.unstuck_h)*bounce_modifier;
    }
    else
    {
        hspeed = sign(self.unstuck_h)*self.running_power;
    }
    
    x += self.unstuck_h;
    
    
    if(abs(hspeed) < 1)
    {
        if(col_object == terrain_obj)
        {
            side_wall = instance_nearest(x-sign(hspeed)-16,y-16,terrain_obj);
            move_contact_object(-sign(hspeed),0,side_wall);
        }
        if(col_object == gate_field_obj)
        {
            move_contact_object(-sign(hspeed),0,touch_field);
        }
        //move_contact_solid(90*(sign(hspeed)+1),1);
        hspeed = 0;
    }
    
    //show_debug_message("final x: "+string(x));
    //self.unstuck_h = 0;
}
if(self.unstuck_v != 0)
{
    if(status_left[? "bounce"] > 0)
    {
        bounce_modifier = abs(vspeed)*bounce_coef;
    }
    else
    {
        bounce_modifier = min(abs(vspeed),1);
    }
    
    head_free = true;
    
    near_head_ter = instance_nearest(x-16,y-40,terrain_obj);
    
    x_dist = x-(near_head_ter.x+16);
    y_dist = y-(near_head_ter.y+16);
    
    if(abs(x_dist) < 25 && y_dist > 0 && y_dist < 40)
    {
        head_free = false;
    }
    
    // TODO: head_free for gate_field_obj
    
    if(lost_control || sign(vspeed) == 1 || status_left[? "bounce"] > 0)
    {
        vspeed = sign(self.unstuck_v)*bounce_modifier;
    }
    
    if(sign(vspeed) == -1 && !head_free && status_left[? "bounce"] == 0)
    {
        vspeed = 0;
    }
    
    y += self.unstuck_v;
    
    if(gravity_direction == 270)
    {
        y -= gravity;
    }
    
    
    if(abs(vspeed) < 1)
    {
        if(col_object == terrain_obj)
        {
            vert_wall = instance_nearest(x-16,y+sign(vspeed)-16,terrain_obj);
            move_contact_object(0,sign(vspeed),vert_wall);
        }
        if(col_object == gate_field_obj)
        {
            move_contact_object(0,sign(vspeed),touch_field);
        }
        
        //move_contact_solid(90+90*(sign(vspeed)+1),1)
        vspeed = 0;
    }
    
    //show_debug_message("final y: "+string(y));
    
    //self.unstuck_v = 0;
}

if(!place_meeting(x,y,terrain_obj) && !place_meeting(x,y,gate_field_obj))
{
    last_x = x;
    last_y = y;
    /*
    if(!place_meeting(x+hspeed,y+vspeed,terrain_obj))
    {
        stuck = false;
    }
    */
}

// GLITCHING
/*
dmg_ratio = min(1,self.damage/hp); 
if(is_glitching)
{
    if(random(2) > dmg_ratio)
    {
        is_glitching = false;
        glitch_phase = 0;
    }
}
else
{
    if(random(2) < dmg_ratio)
    {
        is_glitching = true;
    }
}

if(is_glitching)
{       
    if(glitch_phase == 0 || glitch_phase > 16)
    {
        glitch_dir = random(360);
        glitch_phase = 0;
    }
    glitch_phase += 4*dmg_ratio;
    
    glitch_x_offset = lengthdir_x(glitch_phase,glitch_dir);
    glitch_y_offset = lengthdir_y(glitch_phase,glitch_dir);
}
*/
/*
if(dead)
{
my_console_log("GUY " + string(name));
my_console_log("POS x: " + string(x) + " y: " + string(y));
my_console_log("CHUNK x: " + string(chunkgrid_x) + " y: " + string(chunkgrid_y));
my_console_log("OBS CHUNK x: " + string(obs_chunk_x) + " y: " + string(obs_chunk_y));
my_console_log("CHUNK LIST: " + string(myChunkArray));
}
*/
event_inherited();