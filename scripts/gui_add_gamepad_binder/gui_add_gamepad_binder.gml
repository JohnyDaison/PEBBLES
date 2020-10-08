/// @param x
/// @param y
/// @param gamepad_index
/// @param bind_id
function gui_add_gamepad_binder(argument0, argument1, argument2, argument3) {

	var xx,yy,gamepad_index,bind_id,ii;

	xx = argument0;
	yy = argument1;
	gamepad_index = argument2;
	bind_id = argument3;

	ii = gui_child_init(xx+self.eloffset_x, yy+self.eloffset_y, gui_gamepad_binder);
	ii.gamepad_index = gamepad_index;
	ii.bind_id = bind_id;

	with(gamepad_input_obj)
	{
	    if(index == ii.gamepad_index)
	    {
	        ii.control_obj = id;
	        ii.control_id = ii.control_obj.binds[? bind_id];
	    }
	}


	return ii;



}
