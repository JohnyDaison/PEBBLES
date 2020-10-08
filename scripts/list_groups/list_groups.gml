/// @description list_groups()
/// @function list_groups
function list_groups() {

	var count = 0;
	with(obj_group_obj)
	{
	    my_console_write(group_id + " " + string(ds_list_size(members)));
	    count++;
	}

	return count;



}
