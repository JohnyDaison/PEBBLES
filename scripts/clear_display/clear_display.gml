/// @description clear_display(display)
/// @function clear_display
/// @param display
function clear_display(argument0) {
	var disp_obj = argument0;

	if(instance_exists(disp_obj))
	{
	    empty_display(disp_obj);
	    disp_obj.ready = false;
	    disp_obj.active = false;
	}



}
