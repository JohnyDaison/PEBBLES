function gui_add_keybinder(argument0, argument1, argument2) {
	var xx,yy,new_key,ii;

	xx = argument0;
	yy = argument1;
	new_key = argument2;

	ii = gui_child_init(xx+self.eloffset_x,yy+self.eloffset_y,gui_keybinder);
	ii.key = new_key;

	return ii;



}
