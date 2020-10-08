/// @description chunk_deoptimizer([chunkgrid])
/// @function chunk_deoptimizer
/// @param [chunkgrid]
function chunk_deoptimizer() {
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
	    if(!do_optimization)
	    {
	        return objects_affected;   
	    }
    
	    do_optimization = false;
    
	    var xx,yy, chunk, mode, list, list_size, item, obj, undef;
        
	    // DO OBJECT TRANSFORM BASED ON STATE CHANGE
	    for(xx = 0; xx < grid_width; xx++)
	    {
	        for(yy = 0; yy < grid_height; yy++)
	        {
	            chunk = ds_grid_get(grid, xx, yy);
	            mode = "";
            
	            chunk[? "state"] = "active";
            
	            if(chunk[? "prev_state"] == "held" && chunk[? "state"] == "active")
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
                
	                for(item = 0; item < list_size; item++)
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
	                    /*
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
	                        my_console_log(error_str);
	                    }
	                    */
	                }
	            }
            
	            chunk[? "prev_state"] = chunk[? "state"];
	        }
	    }
	}

	return objects_affected;



}
