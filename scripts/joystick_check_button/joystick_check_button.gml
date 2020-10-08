/// @description Checks to see if a joystick button has been pressed.
/// @param id    the id of the joystick (1 or 2)
/// @param numb The number of the button to check (from 1 to 32).
/// @return {Boolean} true if selected button pressed / false otherwise
function joystick_check_button(argument0, argument1) {
	var jid=__joystick_2_gamepad(argument0);

	var button = 0;
	switch( argument1 )
	{
	case 0:    button = gp_face1; break;
	case 1:    button = gp_face2; break;
	case 2:    button = gp_face3; break;
	case 3:    button = gp_face4; break;
	case 4:    button = gp_shoulderl; break;
	case 5:    button = gp_shoulderlb; break;
	case 6:    button = gp_shoulderr; break;
	case 7:    button = gp_shoulderrb; break;
	case 8:    button = gp_select; break;
	case 9:    button = gp_start; break;
	case 10: button = gp_stickl; break;
	case 11: button = gp_stickr; break;
	default:
	    button = argument1;
	    break;
	}

	return (gamepad_button_value(jid, button) != 0);


}
