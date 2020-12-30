/// @description parse_stringvalue(type, value_string)
/// @function parse_stringvalue
/// @param type
/// @param value_string
function parse_stringvalue(arg_type, value_string) {
	var temp, obj_arg, script_arg, asset_arg;
	var arg_valid = false;

	var result = undefined;
	//my_console_log("part_index="+string(part_index) + " " + "arg_type="+string(arg_type));
	temp = value_string;

	// TYPE
	switch(arg_type)
	{
	    case "number":
            if(is_string_number(temp))
	        {
                temp = real(temp);
                arg_valid = true;
            }
	        break;
        
	    case "string":
	        arg_valid = true;
	        break;
        
	    case "object":
	        obj_arg = DB.objectmap[? temp];
	        result = noone;
	        if(!is_undefined(obj_arg))
	        {
	            temp = obj_arg;
	            arg_valid = true;
	        }
	        else
	        {
	            obj_arg = asset_get_index(temp);    
        
	            if(obj_arg > -1)
	            {
	                temp = obj_arg;
	                arg_valid = true;
	            }
	            else if(is_string_number(temp))
	            {
	                temp = real(temp);
	                if(instance_exists(temp))
	                {
	                    arg_valid = true;
	                }
	            }
	        }
        
	        if(!arg_valid && is_string_number(value_string))
	        {
	            obj_arg = real(value_string);
        
	            if(object_exists(obj_arg))
	            {
	                temp = object_get_name(obj_arg);
	                arg_valid = true;
	            }
	        }
	        break;
        
	    case "script":
	        script_arg = DB.console_scripts[? temp];
	        if(!is_undefined(script_arg))
	        {
	            temp = script_arg[? "index"];
	            arg_valid = true;
	        }
	        break;
        
	    case "assetornumber":
	        asset_arg = asset_get_index(temp);
        
	        if(asset_arg > -1)
	        {
	            temp = asset_arg;
	            arg_valid = true;
	        }
	        else if(is_string_number(temp))
			{
	            temp = real(temp);
	            arg_valid = true;
	        }
	        break;
	}

	// RESOLUTION
	if(arg_valid)
	{
	    result = temp;
	}

	return result;
}
