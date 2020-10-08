/// @description gui_add_scroll_item(scroll_list, new_str)
/// @function gui_add_scroll_item
/// @param scroll_list
/// @param  new_str
function gui_add_scroll_item(argument0, argument1) {
	var scroll_list = argument0;
	var new_str = argument1;

	if(instance_exists(scroll_list))
	{
	    ds_list_add(scroll_list.items, new_str);
	    scroll_list.item_count = ds_list_size(scroll_list.items);
	    frame_manager.window_log_str += new_str + "\t";
	}



}
