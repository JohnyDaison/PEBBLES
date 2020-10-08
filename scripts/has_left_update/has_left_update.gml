/// @function has_left_update(instance, value);
/// @param instance
/// @param new_value
function has_left_update() {
	var inst = argument[0];
	var value = false;

	if(argument_count > 1)
	{
	    value = argument[1];   
	}

	if(value == false && (is_undefined(has_left_inst[? inst]) || has_left_inst[? inst]))
	{
	    ds_list_add(has_not_left_list, inst);
	}
	else if(value == true && !is_undefined(has_left_inst[? inst]) && !has_left_inst[? inst])
	{
	    ds_list_delete(has_not_left_list, ds_list_find_index(has_not_left_list, inst));
	}

	has_left_inst[? inst] = value;


}
