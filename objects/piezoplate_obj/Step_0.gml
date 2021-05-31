if(instance_exists(my_block))
{
    self.ready = (energy >= my_block.active_threshold);
    
    if(self.ready)
    {
        if(my_color != my_last_color)
        {
            my_color = my_last_color;
            tint_updated = false;
        }
    }

    if(compressed && !ready)
    {
        final_tint = tint;
    }
    else
    {
        final_tint = merge_colour( tint, black_tint, 1 - (energy / max_energy) );
    }
    
    // TOUCHED
    touched = false;
    var plate = self;
        
    with(guy_obj)
    {
        // TODO: IF PLATE DIRECTION CHANGES, THIS HAS TO CHANGE TOO
        if(vspeed >= 0)
        {
            var full_speed_meeting = place_meeting(x + hspeed, y + vspeed + 1, plate);
            var half_speed_meeting = place_meeting(x + hspeed / 2,y + vspeed / 2 + 1, plate);
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
                var guy = self;
                
                with(plate)
                {
                    var x_diff = guy.x + guy.hspeed * speed_coef - x;

                    if(abs(x_diff) < sprite_width / 2)
                    {
                        if(!compressed)
                        {
                            if(ready)
                            {
                                var params = create_params_map();
                                params[? "who"] = guy.id;
                                params[? "color"] = my_color;
            
                                my_block.my_next_color = my_color;
                                last_color = my_color;
                                last_tint = tint;
                                my_color = g_dark;
                                tint_updated = false;
                                my_block.energy += energy;
                                last_energy = energy;
                                energy = 0;
                                my_sound_play(gate_on_sound, true, 0.4);
                                
                                broadcast_event("piezoplate_press", id, params);
                            }
                            
                            compressed = true;
                        }
                        touched = true;
                    }
                }
            }
        }
    }
    
    if(!touched)
    {
        compressed = false;
    }
    
    
    if(compressed)
    {
        ambient_light = lerp(ambient_light, 0, light_fadeout_coef);
        direct_light = lerp(direct_light, 0, light_fadeout_coef);
        
        if(ambient_light > 0.02 || direct_light > 0.02)
        {
            tint = last_tint;
            tint_updated = false;
        }
    }
    else
    {
        if(energy != max_energy)
        {
            energy = min(energy+recharge_speed, max_energy);
        }
        
        ambient_light = ambient_light_coef * energy/max_energy;
        direct_light = direct_light_coef * energy/max_energy;
    }
}
else if(my_block != noone)
{
    instance_destroy();
}
