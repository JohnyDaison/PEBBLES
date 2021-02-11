/// @description COVERS, BURSTING, LIGHTS
event_inherited();

energy += direct_input_buffer;
direct_input_buffer = 0;

if(energy > max_energy)
{
    energy = max_energy;
}

if(cover != cover_indestr)
{
    // NEGATIVE VALUE CUTOFF
    if(damage < 0)
    {
        damage = 0;
    }
    // CRUMBLE ANIMATION
    if(damage >= hp && image_speed == 0)
    {
        image_speed = 0.2;
        if(!sound_played)
        {
            my_sound_play(wall_crumble_sound);
            sound_played = true;
            depth -= 1;
        }
        mask_index = big_empty_mask;
        damage = hp;
        image_index = 3;
        bursting = false;
        spreading = false;
        active = false;
        falling = false;
        energy = min(energy,status_threshold);
        with(energy_burst_obj)
        {
            if(my_guy == other.id)
            {
                done_for = true;
            }
        }
        done_for = true;
    }
    
    // NORMAL STATE
    if(image_speed == 0)
    {
        // DAMAGE INDICATION
        image_index = 3*damage/hp;

        //SCALE BUFFER
        scale_amount = min(max_scale_amount, scale_amount + scale_buffer);
    }
    
    scale_buffer = 0;
    
    if(scale_amount >= 0)
    {
        scale_dist = -ceil(scale_amount*max_scale_distance);
        
        scale = 1 - scale_dist/radius;
        
        scale_amount = max(0, scale_amount - unscale_speed);
    }
    
    // LOCK ALPHA
    if(color_locked && image_speed > 0)
    {
        lock_alpha = max(0,1-(image_index-2)/6);
    }

    
    // END OF ANIM DESTROY
    if(image_index+image_speed >= image_number)
    {
        if(mod_get_state("regenerate_terrain"))
        {
            var regen_obj = instance_create(xstart, ystart, wall_regenerator_obj);
            regen_obj.energy = orig_energy;
            regen_obj.my_color = orig_color;
            regen_obj.damage = orig_damage;
            regen_obj.color_locked = orig_locked;
        }
        
        instance_destroy();
        exit;
    }
}
// COLOR UPDATE
if(my_color != my_next_color && !color_locked)
{   
    if(bursting && !beam_end_met)
    {
        my_next_color = my_color;    
    }
    if(!bursting && !(aoe_met || beam_end_met))
    {
        my_old_color = my_color;
        tint_updated = false;
        my_color = my_next_color;
    }
}
if(color_locked)
{
    my_next_color = my_color;
}


if(active)
{
    var energy_tick = min(energy, burst_rate);
    
    var over_burner_threshold = energy > behaviour_threshold;
    var over_burn_to_black_start_treshold = energy > 0;
    var burner_start_burn = over_burner_threshold || (burn_to_black && over_burn_to_black_start_treshold);
    var burner_stop_burn = ( !burn_to_black && !over_burner_threshold );
                        //|| ( burn_to_black && over_burn_to_black_start_treshold );
    
    var above_start_bursting_threshold = energy > outburst_threshold;
    var below_burst_stop_threshold = energy < active_threshold;
    
    var start_bursting = above_start_bursting_threshold || (is_burner && burner_start_burn);
    var stop_bursting = ( !is_burner && below_burst_stop_threshold)
                     || ( is_burner && burner_stop_burn);
    
    var stop_spreading = 
        (!is_burner && below_burst_stop_threshold)
        || (is_burner && !over_burner_threshold);
        
    
    // OUT OF ENERGY
    if(my_next_color != g_black && energy <= 0)
    {
        if(!color_locked)
        {
            my_next_color = g_black;
        }
        energy = 0;
        
        stop_bursting = true;    
        stop_spreading = true;
        //my_console_log("GOING DARK");
    }
    
    // BURST STOP
    if(bursting && stop_bursting)
    {
        bursting = false;
            
        with(energy_burst_obj)
        {
            if(my_guy == other.id)
            {
                done_for = true;
            }
        }   
    }
        
    
    // BURST START
    if(start_bursting)
    {
        spreading = true;
        
        if(!bursting)
        {
            if(my_color != my_next_color && !color_locked) 
            {
                tint_updated = false;
                my_color = my_next_color;
            }
            
            var dir, burst_x, burst_y, ter, i;
            
            burst_count = 0;
            
            for(i=0; i<=3; i+=1) 
            {
                dir = i*90;
                burst_x = x+16+lengthdir_x(32,dir);
                burst_y = y+16+lengthdir_y(32,dir);

                if (!place_meeting(burst_x -(burst_x mod 32), burst_y - (burst_y mod 32), solid_terrain_obj)) 
                {
                    burst = instance_create(burst_x, burst_y, energy_burst_obj);
                    burst.direction = dir;
                    burst.my_guy = id;
                    burst.my_source = object_index;
                    burst.my_color = my_color;
                    burst.tint_updated = false;
                    burst.holographic = holographic;
                    
                    burst_count += 1;
                }
            }
            
            if(burst_count > 0)
            {
                bursting = true;   
            }
        }     
    }
    
    // SPREADING END
    if(stop_spreading)
    {
        spreading = false;
    }
    
    // NEW ENERGY SPREADING    
    if((bursting || spreading) && energy > 0)
    {    
        if(singleton_obj.step_count mod 2 == 0)
        {
            spread_count = 0;
            
            for(i=0;i<4;i+=1)
            {
                will_spread[? i] = false;
                if(instance_exists(near_walls[? i]))
                {
                    if(near_walls[? i].energy < status_threshold
                    || (near_walls[? i].my_color == my_color && near_walls[? i].my_next_color == my_color))
                    {
                        will_spread[? i] = true;
                        spread_count += 1;
                    }
                }
            }
            
            if(spreading)
            {
                for(i=0;i<4;i+=1)
                {
                    if(will_spread[? i])
                    {
                        near_walls[? i].energy += energy_tick / (spread_count + burst_count/3);
                        if(beam_end_met)
                            near_walls[? i].my_next_color = my_next_color;
                        else
                            near_walls[? i].my_next_color = my_color;
                        near_walls[? i].start_glow = true;
                    }
                }
            }
            
            if(spread_count + burst_count > 0)
            {
                energy -= energy_tick;
                //my_console_log("ENERGY AFTER TICK " + string(energy));
            }
        }
    }

    // GLOW ON BURST
    if(bursting && !do_glow)
    {
        start_glow = true;
    }
    
    // LIGHTING
    if(start_glow)
    {
        do_glow = true;
        alarm[1] = 2;
        start_glow = false;
    }
    
    // LIGHTS OFF
    if(energy < status_threshold)
    {
        gives_light = false;
        ambient_light = 0;
        direct_light = 0;
    }
    
    // ENERGY LEVEL LIGHTS
    if(energy >= status_threshold)
    {
        gives_light = true;
        var light_ratio = (energy - status_threshold)/(outburst_threshold - status_threshold);
        
        if(light_shape == shape_circle)
        {
            ambient_light = 0.3 * light_ratio + 0.2;
            direct_light = 0.3 * light_ratio + 0.2;
        }
        /*
        if(light_shape == shape_rect)
        {
            ambient_light = 0.65 * light_ratio + 0.35;
            direct_light = 0.65 * light_ratio + 0.35;
        }
        */
    }
    
    // STRONG GLOW
    if(do_glow)
    {
        gives_light = true;
        //ambient_light = max(0.5,energy-status_threshold);
        
        if(ambient_light == 0)
        {
            if(light_shape == shape_circle)
            {
                ambient_light = 0.3;
            }
            /*
            if(light_shape == shape_rect)
            {
                ambient_light = 0.7;
            }
            */
        }
        else
        {
            ambient_light *= 1.2;   
            if(strong_glow)
            {
                ambient_light *= 1.2;
            }
        }
        
        if(direct_light == 0)
        {
            if(light_shape == shape_circle)
            {
                direct_light = 0.3;
            }
            /*
            if(light_shape == shape_rect)
            {
                direct_light = 0.7;
            }
            */
        }
        else
        {
            direct_light *= 1.2;   
            if(strong_glow)
            {
                direct_light *= 1.2;
            }
        }

    }
}

aoe_met = false;
beam_end_met = false;
has_changed = false;
//active = false;
