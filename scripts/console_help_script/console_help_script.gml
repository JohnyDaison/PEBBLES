/// @description console_help_script()
/// @function console_help_script
function console_help_script() {
	var search_str = "";

	if(argument_count > 0)
	{
	    search_str = argument[0];
	}
    
    my_console_write("Note: An 'object' parameter can usually be passed either:");
    my_console_write("        * object name to affect instances of it and descendants");
    my_console_write("        * instance id to target specific instance");
    console_divider_level("", 3);
    

	var i, arg_i, script, script_str, list = DB.console_modes[? DB.console_mode];
	var count = ds_list_size(list), filtered_count = 0,  optional = false, name, cur_arg;
    var name_start_index = 4, arguments_start_index = 25, help_start_index = 50;

	for(i = -1; i < count; i++)
	{
	    if(i == -1)
	    {
	        name = "Command";    
	    }
	    else
	    {
	        name = list[| i];
    
	        if(ds_list_find_index(DB.console_secrets, name) != -1)
	            continue;
        
	        if(search_str != "" && string_pos(search_str, name) == 0)
	            continue;
        
	        script = DB.console_scripts[? name];
	    }
    
	    if(i == -1)
	    {
	        script_str = "";
	    }
	    else
	    {
	        script_str = string(i);
	    }
    
    
    
	    while(string_length(script_str) < name_start_index)
	    {
	        script_str += " ";
	    }
    
	    script_str += " " + name;
    
	    while(string_length(script_str) < arguments_start_index)
	    {
	        script_str += " ";
	    }
    
	    if(i == -1)
	    {
	        script_str += " Arguments";
	    }
	    else
	    {
	        arg_i = 1;
	        cur_arg = script[? "arg"+string(arg_i)];
	        optional = false;
    
	        while(!is_undefined(cur_arg))
	        {
	            script_str += " ";
	            if(arg_i > script[? "min_args"])
	            {
	                script_str += "[";
	                optional = true;
	            }
	            script_str += cur_arg;
    
	            arg_i += 1;
	            cur_arg = script[? "arg" + string(arg_i)];    
                
                if(optional)
    	        {
    	            script_str += "]";
    	        }
	        }
	    }
    
	    while(string_length(script_str) < help_start_index)
	    {
	        script_str += " ";
	    }
    
	    if(i == -1)
	    {
	        script_str += " Help";
	    }
	    else
	    {
	        script_str += " " + script[? "help_text"];
	    }
    
	    my_console_write(script_str);
        
        if(i == -1) {
            console_divider_level("-", 3);
        }
    
	    if(i >= 0)
	    {
	        filtered_count++;
	    }
	}

	return filtered_count;
}
