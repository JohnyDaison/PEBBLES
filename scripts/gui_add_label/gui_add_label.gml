/// @description gui_add_label(xx,yy,new_text);
/// @function gui_add_label
/// @param xx
/// @param yy
/// @param new_text
function gui_add_label(argument0, argument1, argument2) {
	var xx,yy,new_text,ii;

	xx = argument0;
	yy = argument1;
	new_text = argument2;

	ii = gui_child_init(xx+self.eloffset_x,yy+self.eloffset_y,gui_label);
	ii.text = new_text;
	ii.orig_text = new_text;
	frame_manager.window_log_str += new_text + "\t";

	return ii;



}
