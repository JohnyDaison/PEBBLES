/// @description get_first_group_key(instance)
/// @function get_first_group_key
/// @param instance
function get_first_group_key(argument0) {
	var inst = argument0;

	var key = undefined;

	var first_group = inst.my_groups[| 0];

	if(!is_undefined(first_group))
	{
	    key = inst.my_keys[? first_group];
	}

	return key;





}
