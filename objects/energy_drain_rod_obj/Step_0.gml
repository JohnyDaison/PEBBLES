if(instance_exists(my_block))
{
    var block_color = my_block.my_next_color;
    var update_potential_targets = true;
    var update_targets = true;
    var do_drain = true;
    
    var count, target, list;
    var dir, dist, i, xx, yy, nearest_dist, nearest, is_nearest, has_target = false;
    var available_energy;
    
    // UPDATE POTENTIAL TARGETS
    if(update_potential_targets)
    {
        chunks_content(potential_targets, chunkgrid_obj.id, chunkgrid_x - 1, chunkgrid_y - 1,
                                          chunkgrid_x + 1, chunkgrid_y + 1, true);
        ds_list_clear(potential_drain_rods);
        
        count = ds_list_size(potential_targets);
        
        // FILTER THE LIST
        for(i = count - 1; i >= 0; i--)
        {
            target = potential_targets[| i];
            
            if(is_undefined(target) || !instance_exists(target))
            {
                ds_list_delete(potential_targets, i);   
                continue;
            }
            
            if(point_distance(target.x, target.y, x, y) > radius)
            {
                ds_list_delete(potential_targets, i);   
                continue;
            }
            
            if(ds_list_find_index(drainables, target.object_index) == -1)
            {
                ds_list_delete(potential_targets, i);   
                continue;
            }

        }
        
        update_targets = true;
    }   
    
    // UPDATE ACTUAL TARGETS
    if(update_targets)
    {
        count = ds_list_size(potential_targets);
        ds_list_clear(potential_drain_rods);
        
        // UPDATE POTENTIAL DRAIN RODS
        for(i = 0; i < count; i++)
        {
            target = potential_targets[| i];
            potential_drain_rods[| i] = -1;
            nearest_dist = -1;
            
            for(dir = 0; dir < 4; dir++)
            {
                nearest_drain_target[? i] = noone;
                
                if(enabled[? dir])
                {
                    xx = 0;
                    yy = 0;
                    if(dir mod 2 == 0)
                        xx = -(dir -1) * drain_point_dist;
                    else
                        yy = (dir -2) * drain_point_dist;
                        
                    dist = point_distance(x+xx, y+yy, target.x, target.y);
                    
                    if(dist <= range && target.energy > energy_tick && (potential_drain_rods[| i] == -1 || nearest_dist > dist))
                    {
                        potential_drain_rods[| i] = dir;
                        nearest_dist = dist;
                    }
                }
            }
        }
        
        // RESET NEAREST TARGETS
        for(dir = 0; dir < 4; dir++)
        {
            nearest_drain_target[? dir] = noone;
        }
        
        has_target = false;
        
        // FIND NEAREST VALID TARGETS
        for(i = 0; i < count; i++)
        {
            target = potential_targets[| i];
            dir = potential_drain_rods[| i];   
            is_nearest = false; 
            
            if(dir != -1 && (target.my_color & block_color || block_color == g_dark))
            {   
                xx = 0;
                yy = 0;
                if(dir mod 2 == 0)
                    xx = -(dir -1) * drain_point_dist;
                else
                    yy = (dir -2) * drain_point_dist;
                
                dist = point_distance(x+xx, y+yy, target.x, target.y);
                
                if(instance_exists(nearest_drain_target[? dir]))
                {
                    nearest = nearest_drain_target[? dir];
                    if(point_distance(x+xx, y+yy, nearest.x, nearest.y) > dist)
                    {
                        is_nearest = true;
                    }
                    
                }
                else
                {
                    is_nearest = true;
                }
                
                if(is_nearest)
                {
                    nearest_drain_target[? dir] = target;
                }

                has_target = true;
            }
        }
        
        // CLEAR THE ACTUAL DRAIN TARGETS       
        for(dir = 0; dir < 4; dir++)
        {
            list = drain_target_list[? dir];
            ds_list_clear(list);
        }
        
        if(has_target)
        {
            // DECIDE ON NEW COLOR IF DARK
            if(block_color == g_dark)
            {
                nearest = noone;
                
                // EITHER COMBINE COLORS OF NEAREST TARGETS
                for(dir = 0; dir < 4; dir++)
                {
                    target = nearest_drain_target[? dir];
                    if(instance_exists(target))
                    {
                        nearest = target;
                    
                        if(target.my_color == g_octarine)
                        {   
                            block_color = target.my_color;
                            break;
                        }
                        else
                        {
                            block_color = block_color & target.my_color;
                        }
                    }
                }
                
                // IF THAT FAILED JUST TAKE THE FIRST NON-DARK COLOR
                if(block_color == g_dark)
                {
                    for(i = 0; i < count; i++)
                    {
                        target = potential_targets[| i];
                        dir = potential_drain_rods[| i];   
                        
                        if(dir != -1 && target.my_color > g_dark)
                        {
                            block_color = target.my_color;
                            break;
                        }
                    }
                }
                
                my_block.my_next_color = block_color;
            }          
            
            // ASSIGN THE ACTUAL DRAIN TARGETS
            for(i = 0; i < count; i++)
            {
                target = potential_targets[| i];
                dir = potential_drain_rods[| i];   
                
                if(dir != -1 && (target.my_color & block_color))
                {   
                    list = drain_target_list[? dir];
                    ds_list_add(list, target);
                }
            }
        }
        
    }
    
    // DRAIN THE ENERGY
    if(do_drain)
    {
        for(dir = 0; dir < 4; dir++)
        {
            list = drain_target_list[? dir];
            count = ds_list_size(list);
            
            for(i = 0; i < count; i++)
            {
                target = list[| i];
            
                if(instance_exists(target))
                {
                    if(target.object_index == color_orb_obj)
                    {
                        //available_energy = min(energy_tick, target.energy);
                        
                        if(target.energy > energy_tick)
                        {
                            target.energy -= energy_tick;
                            my_block.direct_input_buffer += energy_tick;
                        }
                    }
                    else if(target.object_index == slime_mob_obj)
                    {
                        available_energy = min(energy_tick, target.energy);
                        
                        if(available_energy > 0)
                        {
                            target.energy -= available_energy;
                            my_block.direct_input_buffer += available_energy;
                        }
                    }
                    else if(target.object_index == shield_obj)
                    {
                        target.charge -= energy_tick;
                        my_block.direct_input_buffer += energy_tick;
                    }
                }
            }
        }
    }
    
    my_color = block_color;
    tint_updated = false;
    lightning_tint = tint;
}
else
{
    if(my_block != noone)
    {
        instance_destroy();
    }
}
