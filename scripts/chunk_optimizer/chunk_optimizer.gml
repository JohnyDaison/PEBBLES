/// @description chunk_optimizer([chunkgrid])
/// @function chunk_optimizer
/// @param [chunkgrid]
function chunk_optimizer() {
	var grid_obj = noone;

	if(argument_count > 0)
	{
	    grid_obj = argument[0];   
	}
	else
	{
	    if(instance_exists(chunkgrid_obj))
	    {
	        grid_obj = chunkgrid_obj.id;
	    }
	}

	var objects_affected = 0;

	if (!object_is_child(grid_obj, chunkgrid_obj))
	{
	    return "Not a chunkgrid!";   
	}

	with(grid_obj)
	{
	    var observer_range = self.observer_range;
    
	    if(!do_optimization || singleton_obj.step_count <= 5
	    || (grid_width <= (2*observer_range + 1) && grid_height <= (2*observer_range + 1)))
	    {
	        return objects_affected;   
	    }
    
	    var observer_count = ds_list_size(observers);
    
	    if(observer_count > 0)
	    {
	        var obs, observer, chunk, list, list_size, item, obj, mode, undef, error_str;
	        var cur_grid_x, cur_grid_y, xx, yy, min_x, max_x, min_y, max_y;
	        var remove, start_x, start_y;
        
	        for(obs = 0; obs < observer_count; obs++)
	        {
	            observer = observers[| obs];
	            var observer_range = observer.observer_range;
            
	            cur_grid_x = floor(observer.x / grid_obj.chunk_size);
	            cur_grid_y = floor(observer.y / grid_obj.chunk_size);
            
            
	            // GRID SECTION STATE UPDATE
	            if(cur_grid_x != observer.obs_chunk_x || cur_grid_y != observer.obs_chunk_y)
	            {
	                remove = true;
	                start_x = observer.obs_chunk_x;
	                start_y = observer.obs_chunk_y;
                
	                repeat(2)
	                {
	                    if(observer.obs_chunk_x > -1 && observer.obs_chunk_y > -1)
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
	                                if(point_distance(start_x, start_y, xx, yy) < observer_range + 0.5)
	                                {
	                                    chunk = ds_grid_get(grid, xx, yy);
                                
	                                    if(remove)
	                                    {
	                                        chunk[? "observers"] -= 1;
	                                    }
	                                    else
	                                    {
	                                        chunk[? "observers"] += 1;
	                                    }
	                                }
	                            }
	                        }
	                    }
                    
	                    observer.obs_chunk_x = cur_grid_x;
	                    observer.obs_chunk_y = cur_grid_y;
	                    /*
	                    my_console_log("OBSERVER MOVED TO x: " + string(cur_grid_x) + " y: " + string(cur_grid_y));
	                    my_console_log("GRID SIZE IS x: " + string(grid_width) + " y: " + string(grid_height));
	                    */
                    
	                    remove = false;
	                    start_x = observer.obs_chunk_x;
	                    start_y = observer.obs_chunk_y;
	                }
	            }
	        }
        
        
	        // DO OBJECT TRANSFORM BASED ON STATE CHANGE
	        for(xx=0; xx<grid_width; xx+=1)
	        {
	            for(yy=0; yy<grid_height; yy+=1)
	            {
	                chunk = ds_grid_get(grid, xx, yy);
	                mode = "";
                
	                if(chunk[? "observers"] == 0)
	                {
	                    chunk[? "state"] = "held";
	                }
	                else
	                {
	                    chunk[? "state"] = "active";
	                }
                
	                if(gamemode_obj.mode == "rougelike" && chunk[? "state"] == "active" && !chunk[? "generated"])
	                {
	                    chunk_generate(xx, yy, self.seed);
	                }
                
	                if(chunk[? "prev_state"] == "active" && chunk[? "state"] == "held")
	                {
	                    mode = "hold";
	                }
	                else if(chunk[? "prev_state"] == "held" && chunk[? "state"] == "active")
	                {
	                    mode = "activate";
	                }
                
	                if(mode != "")
	                {
	                    // TERRAIN
	                    list = chunk[? "terrain"];
	                    list_size = ds_list_size(list);
                    
	                    for(item = 0; item < list_size; item++)
	                    {
	                        obj = list[| item];
                        
	                        if(mode == "activate")
	                        {
	                            objects_affected += object_transform(obj);
	                        }
	                        else if(mode == "hold")
	                        {
	                            objects_affected += object_transform(obj, data_holder_obj);   
	                        }
	                    }
                    
	                    // NON-TERRAIN
	                    list = chunk[? "non_terrain"];
	                    list_size = ds_list_size(list);
                    
	                    for(item = list_size - 1; item >= 0; item--)
	                    {
	                        obj = list[| item];
	                        undef = is_undefined(obj);
                        
	                        if(!undef && instance_exists(obj))
	                        {
	                            if(mode == "activate")
	                            {
	                                objects_affected += object_transform(obj);
	                            }
	                            else if(mode == "hold")
	                            {
	                                objects_affected += object_transform(obj, data_holder_obj);   
	                            }
	                        }
	                        else
	                        {
	                            error_str = "CHUNK["+string(xx)+","+string(yy)+"]:";
	                            if(undef)
	                            {
	                                error_str += " invalid";
	                            }
	                            error_str += " non-terrain member";
	                            if(!undef)
	                            {
	                                error_str += " doesn't exist";
	                            }
	                            error_str += ": " + string(item) + " " + string(obj);
	                            if(!is_undefined(obj_indexes[? obj]))
	                            {
	                                error_str += " " + object_get_name(obj_indexes[? obj]);
	                            }
	                            else
	                            {
	                                error_str += " index unknown";
	                            }
	                            my_console_log(error_str);
                            
	                            ds_list_delete(list, item);
	                        }
	                    }
	                    /*
	                    update_str = "CHUNK["+string(xx)+","+string(yy)+"]: " + mode;
                    
	                    my_console_log(update_str);
	                    */
                    
	                    chunk[? "prev_state"] = chunk[? "state"];
	                }
                  
	            }
	        }
    
	    }
	}

	return objects_affected;



}
