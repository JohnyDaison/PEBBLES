/// @description Returns the position of the x-axis of joystick.
/// @param id    the id of the joystick (1 or 2)
/// @return {Number} the position of the x-axis of the joystick/gamepad with the given id, with the value being somewhere between -1 and 1
function joystick_xpos(argument0) {

	var jid=__joystick_2_gamepad(argument0);

	return gamepad_axis_value( jid, 0);


}
