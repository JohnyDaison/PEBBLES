event_inherited();

line_height = 32;
hor_spacing = 12;
vert_spacing = 16;
top_bar_hor_spacing = 32;
line_vert_padding = 12;
visible_line_count = 6;
depth = -9700;
bg_alpha = 0.1;
value_color = c_white;
error_color = c_red;

width = 1072;
x = view_wport[0] - width;
y = 0;

if (instance_exists(console_window) && singleton_obj.show_console == "peek") {
    y += console_window.height;
}

create_elements = function() {
    eloffset_x = x + hor_spacing;
    eloffset_y = y + vert_spacing;

    var inst;

    // TOP BAR
    inst = gui_add_button(0, 0, "Add watch", add_watch);
    inst.align = "left";
        
    eloffset_x += inst.width + top_bar_hor_spacing;
    
    inst = gui_add_button(0, 0, "Load Watches", load_watches_file);
    inst.align = "left";
    
    eloffset_x += inst.width + top_bar_hor_spacing;
    
    inst = gui_add_button(0, 0, "Save Watches", write_watches_file);
    inst.align = "left";
    
    eloffset_x += inst.width + top_bar_hor_spacing;
    
    inst = gui_add_button(0, 0, "Remove invalid", remove_invalid_watches);
    inst.align = "left";

    eloffset_x += inst.width + top_bar_hor_spacing;
    
    inst = gui_add_button(0, 0, "Remove all", remove_all_watches);
    inst.align = "left";

    eloffset_x += inst.width + top_bar_hor_spacing;
    
    inst = gui_add_button(0, 0, "", function() {
        close_frame(watches_window);
    });
    inst.centered = true;
    inst.width = 32;
    inst.icon = delete_icon;
    inst.show_icon = true;
    
    eloffset_x = x + hor_spacing;
    eloffset_y += inst.height + vert_spacing;

    // SCROLL LIST
    inst = gui_add_scroll_list2(0, 0);
    inst.width = width - 2 * hor_spacing;
    inst.height = visible_line_count * (line_height + line_vert_padding + inst.vertical_margin) + 2 * inst.vertical_margin;
    inst.centered = true;
    watches_scroll_list = inst;

    eloffset_y += watches_scroll_list.height + vert_spacing;

    // HEIGHT
    height = eloffset_y - y;

    if (y + height > view_hport[0]) {
        y = view_hport[0] - height;
    }
}

add_watch = function(index) {
    if (is_undefined(index)) {
        var pane = watches_scroll_list.add_item();
    } else {
        var pane = watches_scroll_list.insert_item(index);
    }
    var hor_spacing = self.hor_spacing / 2;
    var big_hor_spacing = self.hor_spacing * 2;
    var vert_spacing = line_vert_padding / 2;
    var inst;
    
    with (pane) {
        eloffset_x = x + hor_spacing;
        eloffset_y = y + vert_spacing;
        bg_alpha = 0.1;
        value_color = other.value_color;
        error_color = other.error_color;
        
        inst = gui_add_text_input(0, 0, "");
        inst.centered = true;
        object_input = inst;
        
        eloffset_x += inst.width + hor_spacing;
        
        inst = gui_add_text_input(0, 0, "");
        inst.centered = true;
        variable_name_input = inst;
        
        eloffset_x += inst.width + hor_spacing;
        
        inst = gui_add_dropdown(0, 0, "text", DB.watch_type_name_list, WatchType.Basic, DB.watch_type_id_list);
        inst.centered = true;
        inst.text_align = "left";
        inst.align_items = "left";
        inst.width = 128;
        variable_type_dropdown = inst;
        
        with (variable_type_dropdown) {
            event_perform(ev_alarm, 0);
            alarm[0] = -1;
            
            with(list_picker) {
                event_perform(ev_alarm, 0);
                alarm[0] = -1;
            }
        }
        
        eloffset_x += inst.width + hor_spacing;
        
        inst = gui_add_text_input(0, 0, "");
        inst.centered = true;
        key_input = inst;
        
        eloffset_x += inst.width + big_hor_spacing;
        
        inst = gui_add_label(0, 0, "");
        inst.centered = true;
        inst.bg_color = c_black;
        value_label = inst;
        
        eloffset_x += inst.width + big_hor_spacing;
        
        inst = gui_add_button(0, 0, "", function() {
            watches_window.duplicate_watch(item_index);
        });
        inst.centered = true;
        inst.width = 32;
        inst.icon = duplicate_icon;
        inst.show_icon = true;
        
        eloffset_x += inst.width + hor_spacing;
        
        inst = gui_add_button(0, 0, "", function() {
            gui_parent.remove_item(item_index);
        });
        inst.centered = true;
        inst.width = 32;
        inst.icon = delete_icon;
        inst.show_icon = true;
        
        eloffset_x += inst.width + hor_spacing;
        
        eloffset_y += inst.height + vert_spacing;
        
        set_value = function(value) {
            value_label.text = string(value);
            value_label.text_color = value_color;
        }
        
        set_error = function(error) {
            value_label.text = error;
            value_label.text_color = error_color;
        }
    }
    
    watches_scroll_list.resize_item(pane.item_index, pane.eloffset_y - pane.y);
    
    watches_scroll_list.update()
    
    return pane;
}

duplicate_watch = function(index) {
    var old_watch_pane = watches_scroll_list.gui_content[| index];
    var new_watch_pane = add_watch(index + 1);
    
    new_watch_pane.object_input.text = old_watch_pane.object_input.text;
    new_watch_pane.variable_name_input.text = old_watch_pane.variable_name_input.text;
    new_watch_pane.variable_type_dropdown.list_picker.select_item_by_id(old_watch_pane.variable_type_dropdown.value_id);
    new_watch_pane.variable_type_dropdown.inited = true;
    new_watch_pane.key_input.text = old_watch_pane.key_input.text;
}

update_watches_values = function() {
    var total_count = watches_scroll_list.item_count;
    
    for (var index = 0; index < total_count; index++) {
        var watch_pane = watches_scroll_list.gui_content[| index];
        
        var object = parse_stringvalue("object", watch_pane.object_input.text);
        if (is_string(object)) {
            watch_pane.object_input.text = object;
            object = parse_stringvalue("object", object);
        }
        var variable = watch_pane.variable_name_input.text;
        var type = watch_pane.variable_type_dropdown.value_id;
        var key = watch_pane.key_input.text;
        
        var inst_id = noone;
        var temp_value, struct, list, map;
        
        if (!instance_exists(object)) {
            watch_pane.set_error("!NO instance!");
            continue;
        }
        
        inst_id = object.id;
        
        if (!variable_instance_exists(inst_id, variable)) {
            watch_pane.set_error("!NO variable!");
            continue;
        }
        
        temp_value = variable_instance_get(inst_id, variable);  
        
        switch(type) {
            case WatchType.Basic:
                watch_pane.set_value(temp_value);
                continue;
            break;
            
            case WatchType.Instance:
                if (!instance_exists(temp_value)) {
                    watch_pane.set_error("!NO instance2!");
                    continue;
                }
                
                inst_id = temp_value.id;
                
                if (!variable_instance_exists(inst_id, key)) {
                    watch_pane.set_error("!NO variable2!");
                    continue;
                }
                
                temp_value = variable_instance_get(inst_id, key);  
                
                watch_pane.set_value(temp_value);
                continue;
            break;
            
            case WatchType.Struct:
                if (!is_struct(temp_value)) {
                    watch_pane.set_error("!NO struct!");
                    continue;
                }
                
                struct = temp_value;
                
                if (!variable_struct_exists(struct, key)) {
                    watch_pane.set_error("!NO key!");
                    continue;
                }
                
                temp_value = variable_struct_get(struct, key);  
                
                watch_pane.set_value(temp_value);
                continue;
            break;
            
            case WatchType.DS_List:
                if (!ds_exists(temp_value, ds_type_list)) {
                    watch_pane.set_error("!NO list!");
                    continue;
                }
                
                list = temp_value;
                key = parse_stringvalue("number", key);
                
                if (is_undefined(key) || is_undefined(list[| key])) {
                    watch_pane.set_error("!NO index!");
                    continue;
                }
                
                temp_value = list[| key];  
                
                watch_pane.set_value(temp_value);
                continue;
            break;
            
            case WatchType.DS_Map:
                if (!ds_exists(temp_value, ds_type_map)) {
                    watch_pane.set_error("!NO map!");
                    continue;
                }
                
                map = temp_value;
                temp_value = map[? key];
                
                if (is_undefined(temp_value)) {
                    key = parse_stringvalue("number", key);
                    
                    if (is_undefined(key)) {
                        watch_pane.set_error("!NO key!");
                        continue;
                    }
                    
                    temp_value = map[? key];
                }
                
                if (is_undefined(temp_value)) {
                    watch_pane.set_error("!NO key!");
                    continue;
                }
                
                watch_pane.set_value(temp_value);
                continue;
            break;
        }
    }
}

write_watches_file = function() {
    var total_count = watches_scroll_list.item_count;
    var watches_obj = { watches: []};
    
    for (var index = 0; index < total_count; index++) {
        var watch_pane = watches_scroll_list.gui_content[| index];
        watches_obj.watches[index] = {
            instance: watch_pane.object_input.text,
            variable: watch_pane.variable_name_input.text,
            type: watch_pane.variable_type_dropdown.value_id,
            key: watch_pane.key_input.text
        };
    }
    
    var file = file_text_open_write("watches.json");
    file_text_write_string(file, json_stringify(watches_obj));    
    file_text_close(file);
    
    delete watches_obj;
}

load_watches_file = function() {
    var file = file_text_open_read("watches.json");
    var json = file_text_read_string(file);
    file_text_close(file);
    var data;
    
    try {
        data = json_parse(json);
    } catch(error) {
        my_console_log("ERROR: corrupted watches.json : " + error.message);
        return;
    }
    
    if (!(is_struct(data) && variable_struct_exists(data, "watches") && is_array(data.watches))) {
        my_console_log("ERROR: malformed watches.json");
        return;
    }
    
    remove_all_watches();
    
    var total_count = array_length(data.watches);
    for (var index = 0; index < total_count; index++) {
        var watch_data = data.watches[index];
        var watch_pane = add_watch();

        watch_pane.object_input.text = watch_data.instance;
        watch_pane.variable_name_input.text = watch_data.variable;
        watch_pane.variable_type_dropdown.list_picker.select_item_by_id(watch_data.type);
        watch_pane.variable_type_dropdown.inited = true;
        watch_pane.key_input.text = watch_data.key;
    }
}

remove_invalid_watches = function() {
    var total_count = watches_scroll_list.item_count;
    
    for (var index = total_count - 1; index >= 0; index--) {
        var watch_pane = watches_scroll_list.gui_content[| index];
        
        if (watch_pane.value_label.text_color == error_color) {
            watches_scroll_list.remove_item(index);
        }
    }
}

remove_all_watches = function() {
    watches_scroll_list.remove_all_items();
}

create_elements();