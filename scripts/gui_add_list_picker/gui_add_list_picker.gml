/// @description gui_add_list_picker(xx, yy, type, [label_list], [id_list])
/// @function gui_add_list_picker
/// @param xx
/// @param yy
/// @param type
/// @param [label_list]
/// @param [id_list]
function gui_add_list_picker() {
	var xx,yy,type,label_list,id_list,ii;

	xx = argument[0];
	yy = argument[1];
	type = argument[2];
	label_list = noone;
	id_list = noone;

	if(argument_count > 3)
	{
	    label_list = argument[3];
	}
	if(argument_count > 4)
	{
	    id_list = argument[4];
	}

	ii = gui_child_init(xx+self.eloffset_x, yy+self.eloffset_y, gui_list_picker);
	ii.type = type;
	ii.label_list = label_list;
	ii.id_list = id_list;

	return ii;



}
