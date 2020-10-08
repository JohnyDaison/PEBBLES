/// @description my_console_write(string)
/// @function my_console_write
/// @param string
function my_console_write(argument0) {
	var str = argument0;

	ds_list_add(DB.console_history, str);

	if(instance_exists(console_window) && instance_exists(console_window.history_list))
	{
	    gui_add_scroll_item(console_window.history_list, str);
	    console_window.history_list.cur_item = console_window.history_list.item_count;
	    console_window.history_list.selection_pos = console_window.history_list.max_items;
	}



}
