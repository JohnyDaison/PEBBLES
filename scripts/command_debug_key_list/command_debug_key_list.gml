/// @description command_debug_key_list([search])
/// @function command_debug_key_list
/// @param [search]
function command_debug_key_list() {

	var search = "";

	if(argument_count > 0)
	{
	    search = argument[0];   
	}

	var count = ds_list_size(DB.debug_keys_list);

	var item, str, line;
	search = string_lower(search);

	for(var i=0; i < count; i++)
	{
	    item = DB.debug_keys_list[| i];
        str = item.input;
    
	    while(string_length(str) < 20)
	    {
	        str += " ";
	    }
    
	    line = str + " : " + item.label;
    
	    if(search == "" || string_pos(search, string_lower(line)) > 0)
	    {
	        my_console_write(line);
	    }
	}

	return count;
}
