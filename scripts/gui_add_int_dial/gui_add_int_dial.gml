function gui_add_int_dial(argument0, argument1, argument2) {
	var xx,yy,new_value,ii;

	xx = argument0;
	yy = argument1;
	new_value = argument2;

	ii = gui_child_init(xx+self.eloffset_x,yy+self.eloffset_y,gui_int_dial);
	ii.value = new_value;
	ii.text = string(new_value);

	return ii;



}
