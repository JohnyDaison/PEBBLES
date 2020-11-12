/// @description my_console_write(string, [from_command])
/// @function my_console_write
/// @param string
/// @param [from_command]
function my_console_write(str) {
    var from_command = false;
    
    if (argument_count > 1) {
        from_command = argument[1];
    }
    
	ds_list_add(DB.console_history, str);

	if(instance_exists(console_window) && instance_exists(console_window.history_list))
	{
	    var list = console_window.history_list;
        var was_on_last_item = list.cur_item == list.item_count - 1;
        
        gui_add_scroll_item(list, str);
        
        if(was_on_last_item || from_command) {
    	    list.cur_item = list.item_count - 1;
    	    list.selection_pos = list.max_items - 1;
        }
	}
}
