/// @description gui_add_int_input(xx, yy, value, min, max)
/// @function gui_add_int_input
/// @param xx
/// @param  yy
/// @param  value
/// @param  min
/// @param  max
function gui_add_int_input(argument0, argument1, argument2, argument3, argument4) {
	var xx,yy,new_value,new_sign,new_min,new_max,ii;

	xx = argument0;
	yy = argument1;
	new_value = argument2;
	new_sign = sign(new_value);
	new_min = argument3;
	new_max = argument4;

	ii = gui_child_init(xx+self.eloffset_x,yy+self.eloffset_y,gui_int_input);
	ii.value = new_value;
	if(new_sign == -1) 
	    ii.cur_sign = new_sign;
	ii.min_value = new_min;
	ii.max_value = new_max;

	return ii;



}
