function console_jump_to_end() {
    if(instance_exists(console_window) && instance_exists(console_window.history_list))
    {
        var list = console_window.history_list;
        
        list.cur_item = list.item_count - 1;
        list.selection_pos = list.max_items - 1;
    }
}
