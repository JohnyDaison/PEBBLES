/// @description chunk_register(grid_obj, game_obj)
/// @function chunk_register
/// @param grid_obj
/// @param game_obj
function chunk_register(argument0, argument1) {

	var grid_obj = argument0;
	var target = argument1;
	var ret = false;
	var schedule_optimizer = false;
	var target_is_observer = ds_list_find_index(grid_obj.observers, target) > -1;

	// IF OBSERVER LEFT A CHUNK, RUN OPTIMIZER
	if(target_is_observer && target.my_chunklist != noone)
	{
	    schedule_optimizer = true;
	}

	// CALCULATE CHUNK
	var xx = floor(target.x / grid_obj.chunk_size);
	var yy = floor(target.y / grid_obj.chunk_size);
	var chunk, id_str;

	if(xx >= 0 && xx < grid_obj.grid_width && yy >= 0 && yy < grid_obj.grid_height)
	{
	    // IF OBSERVER ARRIVED IN NEW CHUNK, RUN OPTIMIZER
	    if(target_is_observer)
	    {
	        if(target.my_chunklist == noone)
	        {
	            chunk_optimizer();
	        }
	        else
	        {
	            schedule_optimizer = true;
	        }
	    }
    
	    chunk = ds_grid_get(grid_obj.grid, xx, yy);
	    if(DB.console_mode == "debug")
	    {
	        id_str = "CHUNK["+string(xx)+","+string(yy)+"]: " + string(target.id) + " " + object_get_name(target.object_index);
	    }
    
	    // TERRAIN
	    if(object_is_ancestor(target.object_index, terrain_obj))
	    {
	        var ter = target;
        
	        ter.my_chunklist = chunk[? "terrain"];
	        ter.chunkgrid_x = xx;
	        ter.chunkgrid_y = yy;
        
	        if(!is_undefined(ter.my_chunklist) && ds_exists(ter.my_chunklist, ds_type_list))
	        {
	            if(ds_list_find_index(ter.my_chunklist, ter.id) != -1)
	            {
	                if(DB.console_mode == "debug")
	                {
	                    my_console_log("ERROR: Trying to re-add terrain " + id_str);
	                }
	                ret = false;
	            }
	            else
	            {
	                ds_list_add(ter.my_chunklist, ter.id); 
            
	                if(ter.object_index == wall_obj)    
	                {
	                    ter.alarm[0] = 1;
	                    ter.is_new = true;
	                }
            
	                ret = true;
	            }
	        }
	    }
	    // NON-TERRAIN
	    else
	    {
	        var entity = target;
        
	        entity.my_chunklist = chunk[? "non_terrain"];
	        entity.chunkgrid_x = xx;
	        entity.chunkgrid_y = yy;
        
	        if(!is_undefined(entity.my_chunklist) && ds_exists(entity.my_chunklist, ds_type_list))
	        {
	            if(ds_list_find_index(entity.my_chunklist, entity.id) != -1)
	            {
	                if(DB.console_mode == "debug")
	                {
	                    my_console_log("ERROR: Trying to re-add entity " + id_str);
	                }
	                ret = false;
	            }
	            else
	            {
	                ds_list_add(entity.my_chunklist, entity.id); 
            
	                ret = true;
	            }
	        }
	    }
    
	    // ON SUCCESS
	    if(ret)
	    {
	        if(is_undefined(grid_obj.obj_indexes[? target.id]))
	        {
	            grid_obj.obj_indexes[? target.id] = target.object_index;
	        }
        
	        // IF THE NEW CHUNK IS FROZEN
	        if(chunk[? "state"] == "held")
	        {
	            // (BECAUSE OF ITEMS FALLING THROUGH TERRAIN):
	            // ---
	            // POSITION CORRECTION
	            target.x -= target.hspeed;
	            target.y -= target.vspeed;
            
	            // IF FALLING SLOWLY
	            if(abs(target.hspeed) < 2 && target.vspeed > 0 && target.vspeed < 5) {
	                // CANCEL FALL
	                target.vspeed = 0;
                
	                // ADJUST FOR EDGE-TO-CENTER DISTANCE
	                if(object_is_ancestor(target.object_index, item_obj)
	                || object_is_ancestor(target.object_index, energyball_obj)
	                || object_is_ancestor(target.object_index, phys_body_obj)
	                || object_is_ancestor(target.object_index, structure_obj))
	                {
	                    target.y -= target.radius;
	                }
	            }
            
	            if(object_is_child(target.object_index, phys_body_obj))
	            {
	                target.x -= lengthdir_x(target.radius + 1, target.direction);
	                target.y -= lengthdir_y(target.radius + 1, target.direction);
	            }
	            //---
                
	            //TRANSFORM TO DATA HOLDER
	            object_transform(target, data_holder_obj);
	        }
	    }
	}

	if(schedule_optimizer)
	{
	    schedule_chunk_optimizer();
	    my_console_log("SCHEDULE CHUNK OPTIMIZER");
	}


	return ret;



}
