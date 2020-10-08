/// @description gui_add_text_input(x, y, init_value)
/// @function gui_add_text_input
/// @param x
/// @param  y
/// @param  init_value
function gui_add_text_input(argument0, argument1, argument2) {
	var xx,yy,new_text,ii;

	xx = argument0;
	yy = argument1;
	new_text = argument2;

	ii = gui_child_init(xx+self.eloffset_x,yy+self.eloffset_y,gui_text_input);
	ii.prompt_str = new_text;
	ii.text = new_text;

	return ii;



}
