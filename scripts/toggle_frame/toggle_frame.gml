/// @description toggle_frame(frame, state)
/// @function toggle_frame
/// @param frame
/// @param  state
function toggle_frame(argument0, argument1) {
	var frame = argument0;
	var state = argument1;

	if(state && !instance_exists(frame))
	{
	    add_frame(frame);
	}
	if(!state && instance_exists(frame))
	{
	    close_frame(frame);
	}



}
