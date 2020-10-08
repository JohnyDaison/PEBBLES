/// @description add_console_script(command, script_index, arguments)
/// @function add_console_script
/// @param command
/// @param  script_index
/// @param  arguments
function add_console_script() {
	var command = argument[0];
	var script_index = argument[1];
	var arguments = argument[2];
	var help_text = "";

	if(argument_count > 3)
	{
	    help_text = argument[3];   
	}

	var min_args = 0, max_args = 0, done = false;
	var cur_char = "", cur_arg = "", optional_args = false;

	var script = ds_map_create();
	script[? "index"] = script_index;
	script[? "arg0"] = command;


	while(!done)
	{
	    if(arguments != "")
	    {
	        cur_char = string_char_at(arguments, 1);
	    }
	    else
	    {
	        cur_char = "";
	        done = true;
	    }
    
	    switch(cur_char)
	    {
	        case " ":
	        case "]":
	            break;
 
	        case "[":
	            optional_args = true;
	        case ",": 
	        case "":            
	            if(cur_arg != "")
	            {
	                if(!optional_args || cur_char == "[") { min_args++; } 
               
	                max_args++;
	                script[? "arg" + string(max_args)] = cur_arg;

	                cur_arg = "";
	            }
	            break;
 
	        default:
	            cur_arg += cur_char;
	    }
    
	    if(arguments != "")
	    {
	        arguments = string_copy(arguments, 2, string_length(arguments)-1);
	    }
	}

	script[? "min_args"] = min_args;
	script[? "max_args"] = max_args;

	script[? "help_text"] = help_text;

	console_scripts[? command] = script;



}
