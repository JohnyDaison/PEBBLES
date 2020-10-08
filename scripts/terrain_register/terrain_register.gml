/// @description terrain_register(grid_obj, terrain_obj)
/// @function terrain_register
/// @param grid_obj
/// @param  terrain_obj
function terrain_register(argument0, argument1) {
	var obj = argument0;
	var ter = argument1;
	var ret = false;

	var xx, yy, wall, i, count, grid_ter;
	/*
	if(!instance_exists(obj) || !instance_exists(ter))
	    return false;
	*/    
	if(!ds_exists(obj.terrain_grid, ds_type_grid) || !instance_exists(ter))
	{
	    return false;
	}
    
	xx = floor((ter.x - obj.grid_margin) / obj.grid_cell_size);
	yy = floor((ter.y - obj.grid_margin) / obj.grid_cell_size);

	if(xx >= 0 && xx < obj.grid_width && yy >= 0 && yy < obj.grid_height)
	{
	    ter.my_list = ds_grid_get(obj.terrain_grid, xx, yy);
	    ter.grid_x = xx;
	    ter.grid_y = yy;
    
	    ter.aligned_x = floor(ter.x / 32)*32;
	    ter.aligned_y = floor(ter.y / 32)*32;
    
	    if(DB.console_mode == "test" || DB.console_mode == "debug")
	    {
	        with(ter)
	        {
	            if(aligned_x != x || aligned_y != y)
	            {
	                var color = my_color;
	                if(color == g_black) {
	                    color = g_white;   
	                }
                
	                create_text_popup("REG NONALIGN", color, id);
	            }
	        }
	    }
    
	    if(!is_undefined(ter.my_list) && ds_exists(ter.my_list, ds_type_list))
	    {
	        if(DB.console_mode == "test" || DB.console_mode == "debug")
	        {
	            count = ds_list_size(ter.my_list);
        
	            for(i=0; i<count; i++)
	            {
	                grid_ter = ter.my_list[| i];
            
	                if(grid_ter.aligned_x == ter.aligned_x && grid_ter.aligned_y == ter.aligned_y)
	                {
	                    ter.error_placement = true;
	                    grid_ter.error_placement = true;
	                    show_debug_message("TERRAIN OVERLAP at ["+ string(ter.aligned_x)+","+string(ter.aligned_y)+"]");
	                }
	            }
	        }
        
	        ds_list_add(ter.my_list, ter.id); 
        
	        if(ter.object_index == wall_obj)    
	        {
	            ter.alarm[0] = 1;
	            ter.is_new = true;
	        }
	        ret = true;
	    }
	    else
	    {
	        ter.my_list = noone;
	        ter.grid_x = -1;
	        ter.grid_y = -1;
        
	        ter.aligned_x = x;
	        ter.aligned_y = y;
	    }
	}

	chunk_register(chunkgrid_obj, ter);

	return ret;



}
