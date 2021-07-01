/// @function gui_list_picker_update_script
/// @param list_picker
/// @param force_change_script
function gui_list_picker_update_script() {

    var list_picker = argument[0];
    var force_change_script = false;

    if(argument_count > 1)
    {
        force_change_script = argument[1];
    }

    if(instance_exists(list_picker) && list_picker.object_index == gui_list_picker && instance_exists(list_picker.scroll_list))
    {
        with(list_picker)
        {
            scroll_list.auto_height = auto_height;
            scroll_list.auto_items = auto_items;
            
            scroll_list.do_auto_updates();
            
            if(auto_height)
            {
                height = scroll_list.height;
                down_arrow.y = y + height - scroll_list.ends_height;
            }
            
            if(auto_items)
            {
                max_items = scroll_list.max_items;
            }
            
            var last_cur_item = cur_item;
            var last_cur_item_id = cur_item_id;
            cur_item = scroll_list.cur_item;
            cur_item_id = undefined;
        
            if(id_list != noone)
            {
                cur_item_id = id_list[| cur_item];
            }
        
            if(force_change_script || last_cur_item != cur_item || last_cur_item_id = cur_item_id)
            {
                script_execute(item_change_script);
            }
        
            up_arrow.enabled = false;
            down_arrow.enabled = false;
        
            if(scroll_list.cur_item > 0)
            {
                up_arrow.enabled = true;
            }
        
            if(scroll_list.cur_item < scroll_list.item_count-1)
            {
                down_arrow.enabled = true;
            }
        }
    }
}
