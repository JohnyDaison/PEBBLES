/// @function group_auto_group
/// @param group_id
/// @param member
/// @param member_id
/// @param [member_index]
function group_auto_group() {
	var group_id = argument[0];
	var member_obj = argument[1];
	var member_id = argument[2];
	var member_index = 0;

	if(argument_count > 3)
	{
	    member_index = argument[3];
	}

	var group = get_group(group_id);
	if(!instance_exists(group))
	{
	    group = create_group(member_obj.object_index);
	    group.group_id = group_id;
	}

	group_add_member(group, member_obj, member_id, member_index);


}
