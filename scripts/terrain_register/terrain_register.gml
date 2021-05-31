function terrain_register(grid, terrain) {
    var result = false;

    if(!ds_exists(grid.terrain_grid, ds_type_grid) || !instance_exists(terrain))
    {
        return false;
    }
    
    var run_debug_code = DB.console_mode == "test" || DB.console_mode == "debug";
    
    var xx, yy, i, count, other_terrain;
    xx = floor((terrain.x - grid.grid_margin) / grid.grid_cell_size);
    yy = floor((terrain.y - grid.grid_margin) / grid.grid_cell_size);

    if(xx >= 0 && xx < grid.grid_width && yy >= 0 && yy < grid.grid_height)
    {
        terrain.my_list = ds_grid_get(grid.terrain_grid, xx, yy);
        terrain.grid_x = xx;
        terrain.grid_y = yy;
    
        terrain.aligned_x = floor(terrain.x / 32)*32;
        terrain.aligned_y = floor(terrain.y / 32)*32;
    
        if(run_debug_code)
        {
            with(terrain)
            {
                if(aligned_x != x || aligned_y != y)
                {
                    var color = my_color;
                    if(color == g_dark) {
                        color = g_white;   
                    }
                
                    create_text_popup("NON-ALIGNED TERRAIN REGISTERED", color, id);
                }
            }
        }
    
        if(!is_undefined(terrain.my_list) && ds_exists(terrain.my_list, ds_type_list))
        {
            if(run_debug_code)
            {
                count = ds_list_size(terrain.my_list);
        
                for(i=0; i<count; i++)
                {
                    other_terrain = terrain.my_list[| i];
            
                    if(other_terrain.aligned_x == terrain.aligned_x && other_terrain.aligned_y == terrain.aligned_y)
                    {
                        terrain.error_placement = true;
                        other_terrain.error_placement = true;
                        my_console_log("TERRAIN OVERLAP at ["+ string(terrain.aligned_x)+","+string(terrain.aligned_y)+"]");
                    }
                }
            }
        
            ds_list_add(terrain.my_list, terrain.id); 
        
            if(terrain.object_index == wall_obj)    
            {
                terrain.alarm[0] = 1;
                terrain.is_new = true;
            }
            result = true;
        }
        else
        {
            terrain.my_list = noone;
            terrain.grid_x = -1;
            terrain.grid_y = -1;
        
            terrain.aligned_x = x;
            terrain.aligned_y = y;
        }
    }

    chunk_register(chunkgrid_obj, terrain);

    return result;
}
