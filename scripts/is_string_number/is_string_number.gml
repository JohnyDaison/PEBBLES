/// @description is_string_number(string)
/// @param string
function is_string_number() {

	var str = argument[0];

	var length = string_length(str);
	var invalid_character = false;
	var digit_found = false;
	var ord_0 = ord("0");
	var ord_9 = ord("9");
	var chr_ord;

	var str_parts = ds_list_create();
	string_explode(str, ".", str_parts);
	var part_count = ds_list_size(str_parts);

	if(part_count > 2)
	{
	    return false;   
	}

	var first_part = str_parts[| 0];
	var first_char = string_char_at(first_part, 0);
	if(first_char == "-")
	{
	    first_part = string_copy(first_part, 2, length);
	}

	for(var chr_i = 0; chr_i < length; chr_i++)
	{
	    chr_ord = string_ord_at(first_part, 0);
	    if(chr_ord >= ord_0 && chr_ord <= ord_9)
	    {
	        digit_found = true;
	    }
	    else
	    {
	        invalid_character = true;
	    }
	}


	return digit_found && !invalid_character;


}
