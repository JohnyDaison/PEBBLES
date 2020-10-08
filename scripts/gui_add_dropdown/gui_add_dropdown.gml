/// @description gui_add_dropdown(x, y, type, items_list, value, [id_list]);
/// @function gui_add_dropdown
/// @param x
/// @param y
/// @param type
/// @param items_list
/// @param value
/// @param [id_list]
function gui_add_dropdown() {
	var xx,yy,new_items,new_value,type,id_list,ii;

	xx = argument[0];
	yy = argument[1];
	type = argument[2];
	new_items = argument[3];
	new_value = argument[4];
	id_list = noone;

	if(argument_count > 5)
	{
	    id_list = argument[5];
	}


	ii = gui_child_init(xx+self.eloffset_x, yy+self.eloffset_y, gui_dropdown);
	ii.items = new_items;
	ii.value = new_value;
	ii.type = type;
	ii.id_list = id_list;


	return ii;



}
