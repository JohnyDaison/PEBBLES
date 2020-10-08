/// @description get_group(group_id)
/// @function get_group
/// @param group_id
function get_group(argument0) {
	var target_group_id = argument0;
	var group = noone;

	with(obj_group_obj)
	{
	    if(group_id == target_group_id)
	    {
	        group = id;
	    }
	}

	return group;



}
