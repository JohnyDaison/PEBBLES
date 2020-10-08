/// @description debug_key_list([search])
/// @function debug_key_list
/// @param [search]
function debug_keys_list() {

	var search = "";

	if(argument_count > 0)
	{
	    search = argument[0];   
	}

	var count = ds_map_size(DB.debug_keys_map);

	var input = ds_map_find_first(DB.debug_keys_map), str, line;
	search = string_lower(search);

	while(!is_undefined(input))
	{
	    str = input;
    
	    while(string_length(str) < 20)
	    {
	        str += " ";
	    }
    
	    line = str + " : " + DB.debug_keys_map[? input];
    
	    if(search == "" || string_pos(search, string_lower(line)) > 0)
	    {
	        my_console_write(line);
	    }
    
	    input = ds_map_find_next(DB.debug_keys_map, input);
	}

	return count;


}
