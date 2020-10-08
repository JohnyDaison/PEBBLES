/// @description gui_add_checkbox(xx, yy, [size])
/// @function gui_add_checkbox
/// @param xx
/// @param yy
/// @param [size]
function gui_add_checkbox() {
	var xx,yy,ii, size;

	xx = argument[0];
	yy = argument[1];

	ii = gui_child_init(xx + self.eloffset_x, yy + self.eloffset_y, gui_checkbox);
	size = ii.width;

	if(argument_count > 2)
	{
	    size = argument[2];
	    ii.height = size;
	    ii.width = size;
	}

	return ii;



}
