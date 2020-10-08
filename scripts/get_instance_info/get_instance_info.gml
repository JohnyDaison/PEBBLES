/// @description get_instance_info(instance)
/// @function get_instance_info
/// @param instance
function get_instance_info(argument0) {
	var inst = argument0;

	ret = "";

	if(instance_exists(inst))
	{
	    ret = object_get_name(inst.object_index) + "@[" + string(inst.x) + "," + string(inst.y) + "]";
	}
	else
	{
	    ret = "Instance doesn't exist";
	}

	return ret;



}
