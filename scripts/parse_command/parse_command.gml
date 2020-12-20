/// @description parse_command(command_text)
/// @function parse_command
/// @param command_text
function parse_command() {
	var command_text = argument[0];
	var orig_command = command_text;

	var min_args = 0, max_args = 0, arg_type, temp, obj_arg, script_arg;
	var cur_char = "", cur_part = "", string_section = false;

	var command_split = ds_list_create();
	var part_count = 0, part_index = 0;

	var comm, comm_i, comm_list = DB.console_modes[? DB.console_mode];
	var comm_count = ds_list_size(comm_list);

	var console_script = "", script_index, arg_valid, bad_input = false;

	var result = choose("Didn't work, mate.", "Nothing happened.", "That's not quite right.", "Not really.", "Nice try, but no cigar.");

	// SPLIT COMMAND TEXT
	while(command_text != "")
	{
	    cur_char = string_char_at(command_text, 1);

	    switch(cur_char)
	    {
	        case " ":
	            if(string_section)
	            {
	                cur_part += cur_char;
	            }
	            else if(cur_part != "")
	            {
	                ds_list_add(command_split, cur_part);
	                cur_part = "";
	            }
	            break;
	        case "\"":
	            string_section = !string_section;
	            break;
	        default:
	            cur_part += cur_char;
	    }
    
	    command_text = string_copy(command_text, 2, string_length(command_text)-1);
	}

	if(cur_part != "")
	{
	    ds_list_add(command_split, cur_part);
	    cur_part = "";
	}

	part_count = ds_list_size(command_split);

	// IF NOT EMPTY
	if(part_count > 0)
	{
	    // CHECK IF COMMAND EXISTS
	    for(comm_i=0; comm_i<comm_count; comm_i++)
	    {
	        comm = comm_list[| comm_i];
	        if(command_split[| 0] == comm)
	        {
	            console_script = DB.console_scripts[? comm];
	            //my_console_log("comm="+string(comm));
	            break;
	        }
	    }
    
	    // IF IT EXISTS
	    if(console_script != "")
	    {
	        part_index = 1;
	        valid_args = 0;
        
	        min_args = console_script[? "min_args"];
	        max_args = console_script[? "max_args"];
        
	        // CHECK ARGUMENTS
	        while(part_index < part_count && part_index <= max_args)
	        {
	            arg_type = console_script[? "arg" + string(part_index)];
	            //my_console_log("part_index="+string(part_index) + " " + "arg_type="+string(arg_type) + " " + "part_count="+string(part_count));
	            temp = command_split[| part_index];
	            arg_valid = false;
            
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
	                    if(!is_undefined(obj_arg))
	                    {
	                        temp = obj_arg;
	                        arg_valid = true;
	                    }
	                    else {
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
                    
	                    break;
                    
	                case "script":
	                    script_arg = DB.console_scripts[? temp];
	                    if(!is_undefined(script_arg))
	                    {
	                        temp = script_arg[? "index"];
	                        arg_valid = true;
	                    }
	                    break;
	            }
            
	            // RESOLUTION
	            if(arg_valid)
	            {
	                valid_args++;
	                command_split[| part_index] = temp;
	            }
	            else 
	            {
	                bad_input = true;
	                part_index = part_count;
	            }
            
	            part_index++;
	        }
        
	        // EXECUTE COMMAND
	        //my_console_log("bad_input="+string(bad_input) + " " + "valid_args="+string(valid_args) + " " + "min_args="+string(min_args));
	        if(!bad_input && valid_args >= min_args)
	        {
	            script_index = console_script[? "index"];
	            var cs = command_split;

	            switch(valid_args)
	            {
	                case 0:
	                    result = script_execute(script_index);
	                    break;
	                case 1:
	                    result = script_execute(script_index, cs[| 1]);
	                    break;
	                case 2:
	                    result = script_execute(script_index, cs[| 1], cs[| 2]);
	                    break;
	                case 3:
	                    result = script_execute(script_index, cs[| 1], cs[| 2], cs[| 3]);
	                    break;
	                case 4:
	                    result = script_execute(script_index, cs[| 1], cs[| 2], cs[| 3], cs[| 4]);
	                    break;
	                case 5:
	                    result = script_execute(script_index, cs[| 1], cs[| 2], cs[| 3], cs[| 4], cs[| 5]);
	                    break;
	                case 6:
	                    result = script_execute(script_index, cs[| 1], cs[| 2], cs[| 3], cs[| 4], cs[| 5], cs[| 6]);
	                    break;
	                case 7:
	                    result = script_execute(script_index, cs[| 1], cs[| 2], cs[| 3], cs[| 4], cs[| 5], cs[| 6], cs[| 7]);
	                    break;
	                case 8:
	                    result = script_execute(script_index, cs[| 1], cs[| 2], cs[| 3], cs[| 4], cs[| 5], cs[| 6], cs[| 7], cs[| 8]);
	                    break;
	            }
	        }
	    }
	}

	ds_list_destroy(command_split);

	return result;



}
