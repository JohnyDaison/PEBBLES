/// @description console_background_toggle([state])
/// @function console_background_toggle
/// @param [state]
function console_background_toggle() {
	var state = !console_window.show_backgrounds;

	if(argument_count > 0)
	{
	    state = argument[0];
	}

	gui_set_property(console_window, "draw_bg_color", state, true);

	console_window.history_list.draw_bg_color = false;
	console_window.history_list.draw_lines_bg = state;

	console_window.show_backgrounds = state;

	return state;




}
