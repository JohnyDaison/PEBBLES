/// @description group_add_member(group_obj, member_obj, [member_id, member_order])
/// @function group_add_member
/// @param group_obj
/// @param member_obj
/// @param [member_id]
/// @param [member_order]
function group_add_member() {
	var group_obj = argument[0];
	var member_obj = argument[1];
	var member_id = "", member_order = -1;

	if(argument_count > 2)
	{
	    member_id = argument[2];
	    if(argument_count > 3)
	    {
	        member_order = argument[3];
	    }
	}

	if(instance_exists(group_obj) && instance_exists(member_obj))
	{
	    if(ds_list_find_index(group_obj.members, member_obj.id) == -1)
	    {
	        if(group_obj.front_insert)
	        {
	            ds_list_insert(group_obj.members, 0, member_obj.id);
	        }
	        else
	        {
	            ds_list_add(group_obj.members, member_obj.id);
	        }
        
	        ds_list_add(member_obj.my_groups, group_obj.id);
	        member_obj.my_keys[? group_obj.id] = member_id;
        
	        if(member_order >= 0)
	        {
	            group_obj.order[? member_order] = member_obj.id;
	        }
        
	        if(member_id != "")
	        {
	            group_obj.member_ids[? member_id] = member_obj.id;
	        }
	    }
	}



}
