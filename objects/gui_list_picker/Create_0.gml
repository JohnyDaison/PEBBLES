event_inherited();

self.width = 236;
self.height = 196;
label_list = noone;
id_list = noone;
is_dropdown = false;
type = "";
max_items = 4;
cur_item = -1;
cur_item_id = undefined;
item_change_script = empty_script;
self.auto_height = false;
self.auto_items = false;
item_height = undefined
item_padding = undefined;
align_items = "center";
text_color = c_black;
select_text_color = c_black;

scroll_list = noone;

alarm[0] = 2;

select_item_by_index = function(index) {
    if (instance_exists(scroll_list) && scroll_list.select_item(index)) {
        gui_list_picker_update_script(id);
        return true;
    }
    
    return false;
}

select_item_by_id = function(item_id) {
    if (!ds_exists(id_list, ds_type_list)) {
        return false;
    }
    
    var index = ds_list_find_index(id_list, item_id);
    
    return (index != -1) && select_item_by_index(index);
}