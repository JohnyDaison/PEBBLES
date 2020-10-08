/// @description string_explode(string, separator, list);
/// @function string_explode
/// @param string
/// @param  separator
/// @param  list
function string_explode(argument0, argument1, argument2) {
	var str = argument0;
	var separator = argument1;
	var list = argument2;

	var pos, tail_start, substr = "", separator_length = string_length(separator);
	ds_list_clear(list);

	while(str != "")
	{
	    pos = string_pos(separator, str);
	    if(pos == 0)
	    {
	        ds_list_add(list, str);
	        str = "";
	    }
	    else
	    {
	        substr = string_copy(str, 1, pos-1);
	        ds_list_add(list, substr);
	        tail_start = pos+separator_length;
	        str = string_copy(str, tail_start, string_length(str) - tail_start +1);
	    }
	}

	return ds_list_size(list);



}
