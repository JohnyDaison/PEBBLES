/// @description console_help_script()
/// @function console_help_script
function console_help_script() {
	var search_str = "";

	if(argument_count > 0)
	{
	    search_str = argument[0];
	}

	var i, arg_i, script, script_str, list = DB.console_modes[? DB.console_mode];
	var count = ds_list_size(list), filtered_count = 0,  optional = false, name, cur_arg;

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
    
    
    
	    while(string_length(script_str) < 4)
	    {
	        script_str += " ";
	    }
    
	    script_str += " " + name;
    
	    while(string_length(script_str) < 20)
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
	        }
    
	        if(optional)
	        {
	            script_str += "]";
	        }
	    }
    
	    while(string_length(script_str) < 50)
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
    
	    if(i >= 0)
	    {
	        filtered_count++;
	    }
	}

	return filtered_count;





}
