/// @description gui_list_picker_items_reset(list_picker, type, label_list, [id_list])
/// @function gui_list_picker_items_reset
/// @param list_picker
/// @param type
/// @param label_list
/// @param [id_list]
function gui_list_picker_items_reset() {

	var list_picker = argument[0];
	var type = argument[1];
	var label_list = argument[2];
	var id_list = noone;

	if(argument_count > 3)
	{
	    id_list = argument[3];
	}

	if(instance_exists(list_picker))
	{
	    list_picker.type = type;
	    list_picker.label_list = label_list;
	    list_picker.id_list = id_list;

	    gui_reset_scroll_items(list_picker.scroll_list, list_picker.type, label_list);
    
	    gui_list_picker_update_script(list_picker);
	}


}
