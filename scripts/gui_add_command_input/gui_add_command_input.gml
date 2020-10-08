/// @description gui_add_command_input(x, y, prompt_str)
/// @function gui_add_command_input
/// @param x
/// @param  y
/// @param  prompt_str
function gui_add_command_input(argument0, argument1, argument2) {
	var xx,yy,new_text,ii;

	xx = argument0;
	yy = argument1;
	new_text = argument2;

	ii = gui_child_init(xx+self.eloffset_x, yy+self.eloffset_y, gui_command_input);
	ii.prompt_str = new_text;

	return ii;



}
