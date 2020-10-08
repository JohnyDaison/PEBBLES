/// @description Returns the number of axes the joystick has.
/// @param id    the id of the joystick (1 or 2)
function joystick_axes(argument0) {
	var jid=__joystick_2_gamepad(argument0);
	return gamepad_axis_count(jid);


}
