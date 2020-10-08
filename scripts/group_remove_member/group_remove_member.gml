/// @description group_remove_member(group_obj, member_obj)
/// @function group_remove_member
/// @param group_obj
/// @param  member_obj
function group_remove_member() {
	var group_obj = argument[0];
	var member_obj = argument[1];
	/*
	var member_id = "", member_order = -1;

	if(argument_count > 2)
	{
	    member_id = argument[2];
	    if(argument_count > 3)
	    {
	        member_order = argument[3];
	    }
	}
	*/
	if(instance_exists(group_obj) && instance_exists(member_obj))
	{
	    var index = ds_list_find_index(group_obj.members, member_obj.id);
	    if(index != -1)
	    {
	        ds_list_delete(group_obj.members, index);
	        var key = member_obj.my_keys[? group_obj.id];
	        ds_map_delete(group_obj.member_ids, key);
        
	        index = ds_list_find_index(member_obj.my_groups, group_obj.id);
	        ds_list_delete(member_obj.my_groups, index);
	        ds_map_delete(member_obj.my_keys, group_obj.id);
	    }
	}



}
