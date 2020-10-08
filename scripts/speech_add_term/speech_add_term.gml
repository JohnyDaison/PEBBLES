/// @description speech_add_term(term_id, term_name, term_color)
/// @function speech_add_term
/// @param term_id
/// @param term_name
/// @param term_color
function speech_add_term() {

	var term_id = argument[0];
	var term_name = argument[1];
	var term_color = argument[2];

	var term_exists = ds_list_find_index(term_id_list, term_id) != -1 || ds_list_find_index(term_name_list, term_name) != -1;

	if(term_exists)
	{
	    return false;
	}

	ds_list_add(term_id_list, term_id);
	ds_list_add(term_name_list, term_name);
	term_name_map[? term_id] = term_name;
	term_color_map[? term_id] = term_color;

	return true;


}
