/// @description Create a new color power pane object
/// @function gui_add_color_power_pane
/// @param {real} xx  the x coordinate
/// @param {real} yy  the y coordinate
/// @param {string} text  the heading
function gui_add_color_power_pane(xx, yy) {
	var ii;

	ii = gui_child_init(xx + self.eloffset_x, yy + self.eloffset_y, gui_color_power_pane);
	frame_manager.window_log_str += ii.text + "\n";

	return ii;
}
