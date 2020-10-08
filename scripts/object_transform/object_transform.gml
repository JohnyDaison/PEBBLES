/// @description object_transform(from[, to])
/// @function object_transform
/// @param from[
/// @param  to]
function object_transform() {
	var from = argument[0];
	var to = noone;
	if(argument_count > 1)
	{
	    to = argument[1];
	}

	var transform_count = 0;
	var al, alval, is_exception, orig_obj; 

	with(from)
	{
	    orig_obj = object_index;
	    is_exception = ds_list_find_index(DB.chunk_exceptions, orig_obj) != -1;
    
	    if(is_exception)
	    {
	        my_console_log("transform exception skipped: " + object_get_name(orig_obj));
	        continue;
	    }
    
	    if(to == data_holder_obj && orig_obj == data_holder_obj)
	    {
	        show_debug_message("ERROR: Transforming data_holder(was " + object_get_name(transform_memory[? "object_index"]) + ") at [" + string(x) + "," + string(y) + "] into data_holder aborted!");
	        continue;
	    }
    
	    if(to == data_holder_obj)
	    {   
	        transform_memory[? "object_index"] = object_index;
	        transform_memory[? "sprite_index"] = sprite_index;
	        transform_memory[? "mask_index"] = mask_index;
	        transform_memory[? "image_index"] = image_index;
	        transform_memory[? "image_speed"] = image_speed;
	        transform_memory[? "speed"] = speed;
	        transform_memory[? "direction"] = direction;
	        transform_memory[? "gravity"] = gravity;
	        transform_memory[? "friction"] = friction;
	        transform_memory[? "invisible"] = invisible;
        
	        for(al = 0; al <= 11; al++)
	        {
	            alval = alarm[al];
	            if(alval == 0)
	            {
	                alval = 1;
	            }
	            transform_memory[? "alarm"+string(al)] = alval;
	        }
        
	    }
	    else if(to == noone)
	    {
	        to = transform_memory[? "object_index"];
	        if(is_undefined(to)) 
	            continue;
	    }
    
    
	    instance_change(to, false);
    
	    if(to == data_holder_obj)
	    {
	        speed = 0;
	        gravity = 0;
	        friction = 0;
	        visible = false;
	        invisible = true;
	    }
    
	    if(orig_obj == data_holder_obj)
	    {
	        sprite_index = transform_memory[? "sprite_index"];
	        mask_index = transform_memory[? "mask_index"];
	        image_index = transform_memory[? "image_index"];
	        image_speed = transform_memory[? "image_speed"];   
	        speed = transform_memory[? "speed"];
	        direction = transform_memory[? "direction"];
	        gravity = transform_memory[? "gravity"];
	        friction = transform_memory[? "friction"];
	        invisible = transform_memory[? "invisible"];
        
	        for(al = 0; al <= 11; al++)
	        {
	            alarm[al] = transform_memory[? "alarm"+string(al)];
	        }
	    }
    
	    transform_count++;
	}

	return transform_count;





}
