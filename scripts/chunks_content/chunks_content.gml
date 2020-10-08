/// @description chunks_content(chunkgrid, x1, y1, x2, y2, [only_active], [type])
/// @function chunks_content
/// @param output_list
/// @param chunkgrid
/// @param  x1
/// @param  y1
/// @param  x2
/// @param  y2
/// @param  [only_active]
/// @param  [type] default "non_terrain" | "terrain" | "all"
function chunks_content() {
	var output_list = argument[0];
	var grid_obj = argument[1];
	var x1 = argument[2];
	var y1 = argument[3];
	var x2 = argument[4];
	var y2 = argument[5];

	var only_active = false;
	if(argument_count > 6)
	{
	    only_active = argument[6];
	}

	var type = "non_terrain";
	if(argument_count > 7)
	{
	    type = argument[7];
	}

	var xx, yy, chunk, list, count, i;

	ds_list_clear(output_list);

	if(instance_exists(grid_obj))
	{
	    // CLAMP COORDS TO BE INSIDE GRID
	    x1 = clamp(x1, 0, grid_obj.grid_width - 1);
	    x2 = clamp(x2, 0, grid_obj.grid_width - 1);
    
	    y1 = clamp(y1, 0, grid_obj.grid_height - 1);
	    y2 = clamp(y2, 0, grid_obj.grid_height - 1);

	    for(yy = y1; yy <= y2; yy++)
	    {
	        for(xx = x1; xx <= x2; xx++)
	        {
	            chunk = ds_grid_get(grid_obj.grid, xx, yy);
            
	            if(!only_active || chunk[? "state"] == "active")
	            {
	                if(type == "terrain" || type == "all")
	                {
	                    list = chunk[? "terrain"];
	                    count = ds_list_size(list);
            
	                    for(i = 0; i < count; i++)
	                    {
	                        ds_list_add(output_list, list[| i]);
	                    }
	                }
                
	                if(type == "non_terrain" || type == "all")
	                {
	                    list = chunk[? "non_terrain"];
	                    count = ds_list_size(list);
            
	                    for(i = 0; i < count; i++)
	                    {
	                        ds_list_add(output_list, list[| i]);
	                    }
	                }
	            }
	        }
	    } 
	}

	return true;




}
