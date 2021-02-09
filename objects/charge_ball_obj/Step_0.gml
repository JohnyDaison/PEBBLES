/// @description  MOVEMENT, COLLISION, CHARGING, AUTOFIRE
if(!instance_exists(my_guy))
{
    instance_destroy();
    exit;   
}


if(my_guy != id && my_color > -1)
{
    // COPY PARAMS
    invisible = my_guy.invisible;
    holographic = my_guy.holographic;
    part_system_automatic_draw(system, !invisible);
    desired_angle = my_guy.aim_dir;
    desired_dist = my_guy.aim_dist;
    charging = my_guy.charging && !firing;
    autofire = my_guy.autofire;
    overcharge = my_guy.ball_overcharge;
    if(object_is_ancestor(my_guy.object_index, guy_obj))
    {
        overcharge -= my_guy.status_left[? "weakness"] / DB.status_effects[? "weakness"].max_charge;
    }
    chargerate = my_guy.ball_chargerate;
    threshold = max_charge + overcharge;
        
    max_orbs = get_level(id, "chargeball");
        
    // MOVEMENT
    var des_x, des_y;
    des_x = lengthdir_x(desired_dist, desired_angle);
    des_y = lengthdir_y(desired_dist, desired_angle);
        
    des_dir = point_direction(rel_x, rel_y, des_x, des_y);
    cur_dist = point_distance(rel_x, rel_y, des_x, des_y);   
        
    cur_speed = min(cur_dist, base_speed*(1+cur_dist/(3*radius)));  
        
    // continue current movement
    if(cur_speed > 0)
    {
        var dir_diff = angle_difference(des_dir, cur_dir);
            
        cur_dir += dir_diff * max(0.01, (1-(charge/threshold)*0.5)); 
    }
        
    if(cur_speed == 0)
    {
        // start from center
        if((rel_x == 0 && rel_y == 0) || !object_is_ancestor(my_guy.object_index, guy_obj))
        {
            cur_dir = des_dir;
        }
        // start from main directions
        else if(rel_x == 0){
            cur_dir = (floor((des_dir+90)/180)) * 180;      
        }
        else if(rel_y == 0){
            cur_dir = (floor(des_dir/180)+0.5) * 180;   
        }
        // start from diagonal
        else {
            cur_dir = (floor(des_dir/90)+0.5) * 90;   
        }
    }
    cur_dist = point_distance(rel_x, rel_y, des_x, des_y);        
        
        
    rel_x += lengthdir_x(cur_speed, cur_dir);
    rel_y += lengthdir_y(cur_speed, cur_dir);
        
    next_guy_x = my_guy.x+my_guy.hspeed + center_offset_x;
    next_guy_y = my_guy.y+my_guy.vspeed + center_offset_y;

    my_next_x = next_guy_x + rel_x + lengthdir_x(cur_speed, cur_dir);
    my_next_y = next_guy_y + rel_y + lengthdir_y(cur_speed, cur_dir);
        
        
        
    if(object_is_ancestor(my_guy.object_index, guy_obj))
    {
        // TERRAIN COL
        if(desired_dist > 0) // && my_color > g_black
        {
            var collided = false, ter, field, body;
                
            ter = collision_line(next_guy_x + rel_x, next_guy_y + rel_y, my_next_x, my_next_y, solid_terrain_obj, false, true);
            if(ter != noone && ter.object_index != grate_block_obj)
            {
                collided = true;
            }
                
            if(!collided)
            {
                field = collision_line(next_guy_x + rel_x, next_guy_y + rel_y, my_next_x, my_next_y, gate_field_obj, false, true);
                if(field != noone && (holographic || !field.holographic))
                {
                    collided = true;
                }
            }
                
            if(!collided)
            {
                body = collision_line(next_guy_x + rel_x, next_guy_y + rel_y, my_next_x, my_next_y, phys_body_obj, false, true);
                if(body != noone && body != my_guy && (holographic || !body.holographic))
                {
                    collided = true;
                }
            }
                
            if(collided)
            {
                rel_x -= lengthdir_x(5, desired_angle);
                rel_y -= lengthdir_y(5, desired_angle);
            }
        }
            
        // EXHAUSTION
        var new_orb_exhaustion_ratio = get_orb_list_power_level(id.orbs);
        
        if(new_orb_exhaustion_ratio > 0)
        {
            if(my_color != g_black)
            {
                if(new_orb_exhaustion_ratio < 1 && new_orb_exhaustion_ratio > 0.5)
                {
                    new_orb_exhaustion_ratio = 1;
                }
                else if(new_orb_exhaustion_ratio <= 0.5)
                {
                    new_orb_exhaustion_ratio *= 2;
                }
            }
            
            orb_exhaustion_ratio = new_orb_exhaustion_ratio;
        }
            
        /*
        if(object_is_ancestor(my_guy.object_index, guy_obj) && my_guy.current_slot > 0)
        {
            display_exhaustion_ratio = get_orb_list_power_level(my_guy.color_slots);
        }    
        else
        {
            display_exhaustion_ratio = orb_exhaustion_ratio;
        }*/
            
        display_exhaustion_ratio = orb_exhaustion_ratio;
    }
}


threshold = (max_charge + overcharge) * orb_exhaustion_ratio;
cur_charge_step = charge_step * chargerate * orb_exhaustion_ratio;

// STOP CHARGING IF NO ORBS LEFT
if(object_is_child(my_guy, guy_obj) && orb_count == 0) 
{
    charging = false;
    my_guy.charging = false;
}

// CHARGING
if(charging && !firing)
{
    if(!started)
    {
        started = true;
        if(object_is_ancestor(my_guy.object_index, guy_obj))
        {
            my_charge_sound = my_sound_play(charge_sound);
            //my_color = my_guy.my_color;
            //tint_updated = false;
        }
    }
    
    //audio_sound_pitch(my_charge_sound, DB.colorpitch[? my_color]);
    
    // CHARGE STEP
    cur_charge_step = min(cur_charge_step, max(0, threshold - charge));
    
    for(i=0; i<orb_count; i++) 
    {
        var orb = orbs[| i];
        var diff = orb.energy - orb_exhaustion_rate*cur_charge_step;
        var missing_energy = max(0, -diff);
        cur_charge_step -= missing_energy/orb_exhaustion_rate;
        orb.energy = max(0, diff);
    }
    
    charge = min(charge + cur_charge_step, threshold);
    
    // FULL CHARGE
    if(charge >= threshold)
    {
        // STRUCTURES
        if(started && object_is_ancestor(my_guy.object_index, structure_obj))
        {
            my_sound_stop(my_charge_sound);
            started = false;
            my_guy.charging = false;
        }
    }
    
    if(desired_dist == 0 && cur_dist < 8)
    {
        // SHIELD CHANNELING
        
        channeling = false;
        if(instance_exists(my_guy) && my_guy != id)
        {
            if(object_is_ancestor(my_guy.object_index, guy_obj) && has_level(my_guy, "shield", 1))
            {
                if(my_color > g_black
                && (charge > (max_charge+overcharge)*orb_exhaustion_ratio || charge >= threshold)
                && my_guy.shield_ready)
                {
                    var shield = my_guy.my_shield;
                    if(instance_exists(shield))
                    {
                        if(shield.my_color == my_color)
                        {
                            var channel_step = charge_step * channelrate;
                            //var channel_step = cur_charge_step*channelrate;
                        
                            if(shield.threshold > shield.charge)
                            {
                                channel_step = max(0, channel_step - sign(shield.diff)*shield.cur_step);
                            }
                            
                            var diff = (shield.threshold + shield.channel_maxboost) * orb_exhaustion_ratio - shield.charge;
                        
                            channel_step = min(channel_step, max(diff,0) );
                            
                            if(channel_step > 0)
                            {
                                shield.charge += channel_step;
                                //self.charge -= cur_charge_step;
                                self.charge -= channel_step;
                            }
                            
                            if(diff >= 0)
                            {
                                shield.channeled = true;
                                channeling = true;
                            }
                        }
                    }
                    else
                    {
                        trigger(id);
                    }
                }
            }
        }
    }
}
else
{
    if(started)
    {
        my_sound_stop(my_charge_sound);
        started = false;
    }
    
    // FIRING
    if(firing)
    {
        // STOP ON LOST CONTROL
        if(object_is_ancestor(my_guy.object_index, guy_obj))
        {
            if(my_guy.lost_control)
            {
                firing = false;
                dash_steps_left = 0;
                my_guy.air_dashing = false;
                alarm[1] = -1;
            }
        }
        
        // DASHWAVE
        if(dash_steps_left > 0 && firing)
        {
            var dir = point_direction(0,0, rel_x, rel_y);
            var xx = lengthdir_x(dash_dist, dir);
            var yy = lengthdir_y(dash_dist, dir);
            var safe = false;
            
            charge = 0;
            
            with(my_guy)
            {
                var sprinkler_shield = instance_place(x+hspeed+xx, y+vspeed+yy, sprinkler_shield_obj);
                var energy_shield = instance_place(x+hspeed+xx, y+vspeed+yy, shield_obj);
                if(!place_meeting(x+hspeed+xx, y+vspeed+yy, terrain_obj)
                && !place_meeting(x+hspeed+xx, y+vspeed+yy, gate_field_obj)
                && (sprinkler_shield == noone || sprinkler_shield.my_guy == id)
                && (energy_shield == noone || !iff_check("shield_will_push_me", id, energy_shield)))
                {
                    safe = true;
                }
            }
            
            if(safe && !dash_interrupted)
            {
                if(my_guy.airborne)
                {
                    my_guy.vspeed -= my_guy.gravity; 
                    my_guy.y -= my_guy.gravity;   
                }
                 
                my_guy.x += xx;
                my_guy.y += yy;
                
                x += xx;
                y += yy;

                dash_steps_left--;
            
                i = instance_create(x,y, dash_wave_obj);
                i.image_angle = dir;
                i.my_player = self.my_player;
                i.dash_dist = dash_dist;
                i.my_color = self.my_color;
                i.tint_updated = false;
                i.my_guy = my_guy.id;
                i.my_source = object_index;
                i.holographic = self.holographic;          
            
                if(dash_steps_left == 0)
                {
                    i.force = self.trig_charge*dash_end_ratio;
                    i.knockback = true;
                }
                else
                {
                    i.force = self.trig_charge*dash_step_ratio;
                    i.image_xscale = 0.5;
                    i.image_yscale = 0.5;
                }
            }
            
            if(!safe || dash_interrupted)
            {
                dash_steps_left = 0;
            }
            
            if(dash_steps_left <= 0)
            {
                firing = false;
                my_guy.air_dashing = false;
                
                my_guy.hspeed += xx*self.trig_charge/4;
                my_guy.vspeed += yy*self.trig_charge/4;
            }
        }
    }
    else
    {
        // ALL BUT STRUCTURES LOSE CHARGE
        if(!object_is_ancestor(my_guy.object_index, structure_obj))
        {
            if(charge > 0)
            {
                charge -= cur_charge_step;
                /*
                for(i=0; i<orb_count; i++) 
                {
                    var orb = orbs[| i];
                    orb.direct_input_buffer += cur_charge_step/orb_count;
                }
                */
            }    
        }       
    }
}

if(charge < 0)
    charge = 0;
    
if(my_guy != id)
{
    charge = min(charge, threshold);
}

// AUTOFIRE
if(charge >= threshold && self.autofire)
{
    trigger(id);
}

energy = charge;
dash_interrupted = false;
