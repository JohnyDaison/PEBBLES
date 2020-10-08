/// @description camera_position(view, x, y)
/// @function camera_position
/// @param view
/// @param  x
/// @param  y
function camera_position(argument0, argument1, argument2) {
	var target_view = argument0;
	var xx = argument1;
	var yy = argument2;
	var ret = false;

	camera_resume(target_view);

	with(camera_obj)
	{
	    if(view == target_view)
	    {
	        my_override = instance_create(xx, yy, place_holder_obj);
	        follow_override = true;
	        ret = true;
	    }
	}

	return ret;



}
