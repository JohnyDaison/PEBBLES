/// @description Create a new pane object
/// @function gui_add_pane
/// @param {real} xx  the x coordinate
/// @param {real} yy  the y coordinate
/// @param {string} text  the heading
function gui_add_pane(argument0, argument1, argument2) {
	var xx,yy,new_text,ii;

	xx = argument0;
	yy = argument1;
	new_text = argument2;

	ii = gui_child_init(xx+self.eloffset_x,yy+self.eloffset_y,gui_pane);
	ii.text = new_text;
	frame_manager.window_log_str += new_text + "\n";

	return ii;



}
