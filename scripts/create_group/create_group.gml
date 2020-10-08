/// @description create_group(object_index)
/// @function create_group
/// @param object_index
function create_group(argument0) {
	var object = argument0;

	if(object == terrain_obj)
	{
	    return instance_create(0,0, terrain_group_obj);
	}
	else if(object == infodisplay_obj)
	{
	    return instance_create(0,0, display_group_obj);
	}
	else if(object == filter_projector_obj)
	{
	    return instance_create(0,0, filter_projector_group_obj);
	}
	else
	{
	    return instance_create(0,0, obj_group_obj);
	}
    



}
