function gui_add_joybinder(argument0, argument1, argument2, argument3) {
	var xx,yy,which_id,new_joy,ii;

	xx = argument0;
	yy = argument1;
	which_id = argument2;
	new_joy = argument3;

	ii = gui_child_init(xx+self.eloffset_x,yy+self.eloffset_y,gui_joybinder);
	ii.joystick_id = which_id;
	ii.joy = new_joy;

	return ii;



}
