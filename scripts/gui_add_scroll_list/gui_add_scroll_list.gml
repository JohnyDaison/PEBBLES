/// @description gui_add_scroll_list(x, y)
/// @function gui_add_scroll_list
/// @param x
/// @param  y
function gui_add_scroll_list(argument0, argument1) {
	var xx,yy,ii;

	xx = argument0;
	yy = argument1;

	ii = gui_child_init(xx+self.eloffset_x, yy+self.eloffset_y, gui_scroll_list);

	return ii;



}
