/// @description observer_remove(grid_obj, observer_obj)
/// @function observer_remove
/// @param grid_obj
/// @param  observer_obj
function observer_remove(argument0, argument1) {
	var grid_obj = argument0;
	var target = argument1;
	var ret = false;

	var xx, yy, min_x, max_x, min_y, max_y;
	var start_x, start_y, chunk;

	if(instance_exists(grid_obj))
	{
	    var index = ds_list_find_index(grid_obj.observers, target.id);
    
	    if(index > -1)
	    {
	        with(grid_obj)
	        {
	            start_x = target.obs_chunk_x;
	            start_y = target.obs_chunk_y;
	            //var observer_range = self.observer_range;
	            var observer_range = target.observer_range;
    
	            if(target.obs_chunk_x > -1 && target.obs_chunk_y > -1)
	            {
	                min_x = start_x - observer_range;
	                max_x = start_x + observer_range;
	                min_y = start_y - observer_range;
	                max_y = start_y + observer_range;
                
	                // MAKE SURE EDGES ARE INSIDE GRID
	                min_x = clamp(min_x, 0, grid_width - 1);
	                max_x = clamp(max_x, 0, grid_width - 1);
	                min_y = clamp(min_y, 0, grid_height - 1);
	                max_y = clamp(max_y, 0, grid_height - 1);
                
	                for(xx=min_x; xx<=max_x; xx+=1)
	                {
	                    for(yy=min_y; yy<=max_y; yy+=1)
	                    {
	                        // observer distance
	                        if(point_distance(target.obs_chunk_x, target.obs_chunk_y, xx, yy) < observer_range + 0.5)
	                        {
	                            chunk = ds_grid_get(grid, xx, yy);
	                            chunk[? "observers"] -= 1;
	                        }
	                    }
	                }
	            }
            
	            ds_list_delete(observers, index);
	            target.my_chunkgrid = noone;
            
	            ret = true;
	        }
	    }
	}

	return ret;



}
