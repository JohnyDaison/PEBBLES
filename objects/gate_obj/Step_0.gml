if(instance_exists(my_block))
{
    var i, inv, found, has_field = false;
    
    // COPY BLOCK COLOR ON CHANGE
    if(my_last_color != my_block.my_color && my_color != my_block.my_color)
    {
        my_color = my_block.my_color;
        if(my_last_color == g_nothing || my_color == g_octarine)
        {
            my_last_color = my_color;
        }
        tint_updated = false;
    }
    
    // WHILE STABLE
    if(tint_updated && my_last_color == my_block.my_color)
    {
        for(i=0; i<4; i++)
        {
            var other_gate = noone;
            
            if(instance_exists(field[? i]))
            {
                other_gate = field[? i].my_gates[? i];
                
                if(instance_exists(other_gate) && other_gate.my_block.object_index == wall_obj)
                {
                    var other_block = other_gate.my_block;
                
                    if(my_block.energy > other_block.energy
                    && my_block.energy >= (DB.terrain_config[? "active_threshold"] + transfer_packet_size))
                    {
                        my_block.energy -= transfer_packet_size;
                        other_block.direct_input_buffer += transfer_packet_size;
                    
                        if(other_block.my_color == g_dark)
                        {
                            other_block.my_next_color = my_block.my_next_color;
                        }
                    
                    }
                }
            }
        }
    }
    
    // WHEN COLOR CHANGE FINISHES
    if(tint_updated && my_color > g_dark && my_color < g_white)
    {
        if(my_last_color > g_dark && my_last_color < g_white)
        {
            // EXECUTE COMMAND
            var old_dir = DB.colordirs[? my_last_color];
            var new_dir = DB.colordirs[? my_color];
            rotate_by += ((round(new_dir-old_dir+2) mod 4)+4) mod 4 -2;
        }   
        
        // DISCARD COLOR
        my_last_color = my_color;
        my_color = g_dark;
        tint_updated = false;
    }
    
    // RESET FIELDS
    if(abs(rotate_by) > 0)
    {
        for(i=0; i<4; i++)
        {
            if(instance_exists(field[? i]))
            {
                instance_destroy(field[? i]);
            }
        }
    }
    
    // ROTATE
    var rotate_failed = false;
    var orig_rotate_by = rotate_by;
    var done = false;
    
    while(!done)
    {
        while(rotate_by != 0)
        {
            if(rotate_by > 0)
            {
                var orig_last_active = active[?3];
                for(i=3; i>0; i--)
                {
                    active[?i] = active[?i-1];
                }
                active[?0] = orig_last_active;
                
                rotate_by--;
            }
            if(rotate_by < 0)
            {
                var orig_first_active = active[?0];
                for(i=0; i<3; i++)
                {
                    active[?i] = active[?i+1];
                }
                active[?3] = orig_first_active;
                
                rotate_by++;
            }
            
            has_rotated = true;
        }
        
        rotate_failed = false;
        for(i=0; i<4; i++)
        {
            if(active[?i] && !enabled[?i])
            {
                rotate_failed = true;
                has_rotated = false;
            }
        }
        
        if(rotate_failed)
        {
            rotate_by = -orig_rotate_by;
        }
        else
        {
            done = true;
        }
    }
    
    // MANAGE FIELDS
    for(i=0; i<4; i++)
    {
        inv = (i+2) mod 4; // inverted
        
        if(enabled[?i] && active[?i])
        {
            if(!instance_exists(field[?i]))
            {
                found = false;
                with(gate_obj)
                {
                    if(other.id != id)
                    {
                        if(enabled[?inv] && active[?inv] && !instance_exists(field[?inv]))
                        {
                            var hor = false;
                            var vert = false;
                            var width = 0;
                            var height = 0;
                            
                            //horizontal
                            if(i mod 2 == 0 && y == other.y)
                            {
                                var dir = sign(x-other.x);
                                if(dir == -i+1) // same dir
                                {                            
                                    if(!collision_line(other.x + dir*16, other.y, x - dir*16, y, gate_blocking_terrain_obj, false, false))
                                    {
                                        width = abs(x-other.x)-32;
                                        hor = true;
                                        found = true;
                                    }
                                }
                            }
                            //vertical
                            else if(i mod 2 == 1 && x == other.x)
                            {
                                var dir = sign(y-other.y);
                                if(dir == i-2) // same dir
                                {                            
                                    if(!collision_line(other.x, other.y + dir*16, x, y - dir*16, gate_blocking_terrain_obj, false, false))
                                    {
                                        height = abs(y-other.y)-32;
                                        vert = true;
                                        found = true;
                                    }
                                }
                            }
                            
                            if(found)
                            {
                                var field_inst = instance_create(ceil((x+other.x)/2)+1, ceil((y+other.y)/2)+1, gate_field_obj);
                                field[? inv] = field_inst;
                                other.field[? i] = field_inst;
                                if(my_player == other.my_player)
                                    field_inst.my_player = my_player;
                                    
                                field_inst.my_gates[? inv] = other.id;
                                field_inst.my_gates[? i] = id;
                                
                                field_inst.horizontal = hor;
                                field_inst.vertical = vert;
                                if(width > 0)
                                    field_inst.width = width;
                                if(height > 0)    
                                    field_inst.height = height;
                                    field_inst.radius = max(width, height);
                                break;
                            }
                        }
                    }
                }      
            }
            else
            {
                has_field = true;
            }
        }
    }
    
    if(my_color == g_dark && has_field)
    {
        my_color = g_white;
        tint_updated = false;
    }
    else if(my_color == g_white && !has_field)
    {
        my_color = g_dark;
        tint_updated = false;
    }
 
    var ii, col, dir_diff, col_diff, list;
    
    // RECALCULATE TINTS
    if(has_rotated)
    {
        for(i=0; i<4; i++)
        {
            list = tints[? i];
            ds_list_clear(list);
            
            if(enabled[? i])
            {
                if(active[? i])
                {
                    ds_list_add(list, DB.colormap[? g_white]);
                }
                else if(my_last_color <= g_dark || my_last_color >= g_white)
                {
                    ds_list_add(list, DB.colormap[? g_dark]);
                }
                else
                {
                    for(ii=0; ii<4; ii++)
                    {
                        if(active[? ii])
                        {
                            for(col = g_red; col <= g_cyan; col++)
                            {
                                if(col == my_last_color)
                                    continue;
                                    
                                dir_diff = (i-ii +4) mod 4;
                                col_diff = round(DB.colordirs[? col] - DB.colordirs[? my_last_color] +4) mod 4;
                                                                
                                if(dir_diff == col_diff)
                                {
                                    ds_list_add(list, DB.colormap[? col]);
                                }
                            }
                        }
                    }   
                }              
            }
        }
        
        has_rotated = false;
    }
}
