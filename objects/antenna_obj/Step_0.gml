if(instance_exists(my_holder))
{
    if(instance_exists(my_block))
    {
        var block_color = my_block.my_next_color;
    }
    
    if(instance_exists(my_struct))
    {
        var block_color = my_struct.my_color;
    }
    
    var stabilised = tint_updated || my_color == g_octarine;
    
    // COPY BLOCK COLOR IF STABILISED
    if((my_color > g_dark || stabilised) 
        && my_color != block_color && my_holder.tint_updated && block_color > g_dark)
    {
        my_color = block_color;
        stabilised = false;
    }
    
    if(my_color == g_dark && stabilised)
    {    
        if(!lightning_reset)
        {
            for(i=0; i<4; i++)
            {
                lightning_dist[? i] = 0;
            }
            lightning_reset = true;
        }
        
        // BLINK WITH STORED COLOR
        if(energy > 0 && my_last_color > g_dark)
        {
            my_color = my_last_color;
            stabilised = false;
        }
    }
    
    // DRAIN HOLDER
    if(my_color > g_dark && stabilised)
    {
        if(my_holder.energy > 0)
        {
            energy += my_holder.energy;
            if(my_color != block_color)
            {
                my_color = block_color;
                stabilised = false;
            }
            
            if(instance_exists(my_block))
            {
                my_block.my_next_color = g_dark;
                my_block.energy = 0;
            }
            
            if(instance_exists(my_struct))
            {
                my_struct.my_color = g_dark;
                my_struct.tint_updated = false;
                my_struct.energy = 0;
            }
        }
    }
        
    // READY
    if(my_color > g_dark && stabilised)
    {
        // BLINK OFF IF LOW ENERGY
        if (energy < activation_threshold)
        {
            my_last_color = my_color;
            my_color = g_dark;
            stabilised = false;
        }
        else
        {
            // FIND TARGETS
            var i, hdir, vdir, xx,yy, structure, steps;
            var targets = ds_list_create();
            lightning_color = my_color;
            lightning_tint = tint;
            
            for(i=0; i<4; i++)
            {
                hdir = 0;
                vdir = 0;
                lightning_dist[? i] = 0;
                if(enabled[? i])
                {
                    if(i mod 2 == 0)
                        hdir = -(i -1) * grid_size;
                    else
                        vdir = (i -2) * grid_size;
                
                    for(steps = 1; steps <= range; steps++)
                    {
                        xx = x + steps*hdir;
                        yy = y + steps*vdir;   
                        structure = instance_nearest(xx, yy, structure_obj);
                        
                        if(point_distance(structure.x, structure.y, xx, yy) < grid_size/2)
                        {
                            if(instance_exists(structure.my_block) && structure.my_block.object_index == wall_obj)
                            {
                                ds_list_add(targets, structure.my_block);
                                lightning_dist[? i] = steps*grid_size;
                                lightning_reset = false;
                            }
                            else if(structure.object_index == universal_pad_obj)
                            {
                                ds_list_add(targets, structure);
                                lightning_dist[? i] = steps*grid_size;
                                lightning_reset = false;
                            }
                        }
                    }
                }
            }
            
            
            var count = ds_list_size(targets);
            if(count > 0)
            {
                // FIRE ENERGY
                var energy_boost = energy/count;
            
                for(i=0; i<count; i++)
                {
                    with(targets[|i])
                    {
                        if(object_index == wall_obj)
                        {
                            my_next_color = other.my_color;
                            energy += energy_boost;
                        }
                        else if(object_index == universal_pad_obj)
                        {
                            pad_color = other.my_color;
                            tint_updated = false;
                            cur_power += energy_boost;
                        }
                    }
                }
                
                var nearest_guy = instance_nearest(x,y, player_guy);
                if(nearest_guy != noone && point_distance(x,y,nearest_guy.x,nearest_guy.y) < DB.sound_cutoff_dist)
                {
                    my_sound_play(energy_pulse_sound);
                }
            }
            else
            {
                // RETURN ENERGY
                if(instance_exists(my_block))
                {
                    my_block.my_next_color = my_color;
                    my_block.energy += energy;
                }
            
                if(instance_exists(my_struct))
                {
                    my_struct.my_color = my_color;
                    my_struct.tint_updated = false;
                    my_struct.energy += energy;
                }
            }
            
            // DISCARD COLOR
            my_last_color = my_color;
            my_color = g_dark;
            stabilised = false;
            energy = 0;
      
            ds_list_destroy(targets);   
        }   
    }
    
    if(!stabilised)
    {
        tint_updated = false;
    }
}
else
{
    if(my_holder != noone)
    {
        instance_destroy();
    }
}
