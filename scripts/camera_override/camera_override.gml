/// @description camera_override(view, instance)
/// @function camera_override
/// @param view
/// @param  instance
function camera_override(argument0, argument1) {
	var target_view = argument0;
	var instance = argument1;
	var ret = false;

	camera_resume(target_view);

	with(camera_obj)
	{
	    if(view == target_view && instance_exists(instance))
	    {
	        my_override = instance.id;
	        follow_override = true;  
	        ret = true; 
	    }
	}

	return ret;



}
