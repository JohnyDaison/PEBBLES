var res_list = resolution_picker.scroll_list;
var res_string = string(singleton_obj.current_width)+"x"+string(singleton_obj.current_height);
var last_cur_item = res_list.cur_item;
res_list.cur_item = ds_list_find_index(res_list.items,res_string);
res_list.selection_pos += (res_list.cur_item - last_cur_item);
with(res_list)
{
    script_execute(item_change_script);
}

