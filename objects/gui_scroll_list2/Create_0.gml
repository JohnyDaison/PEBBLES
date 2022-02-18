event_inherited();

draw_border = true;
draw_bg_color = true;
bg_alpha = 0.3;
border_alpha = 0.5;
width = 160;
height = 164;
side_margin = 4;
vertical_margin = 4;
bar_width = 16;
bar_corner_radius = corner_radius;
bar_bg_color = c_white;
bar_knob_color = merge_color(c_ltgray, c_white, 0.5);
bar_knob_margin = 0;
bar_knob_alpha = 0.9;
drawn_bar_width = 0;
main_width = 0;
bar_start = 0;
knob_offset = 0;
knob_height = 0;
total_items_height = 0;

centered = false;

scroll_offset = 0;
scroll_range = 0;
cur_item = -1;
first_item = 0;
max_first_item = 0;
last_item = 0;
item_count = 0;
selection_pos = 0;
highlighted_item = -1;
want_focus = true;
item_change_script = empty_script;
item_click_script = empty_script;
mouse_scroll_speed = 1;
is_list_picker = false;

add_item = function() {
    eloffset_x = x;
    eloffset_y = y;
    update();
    
    var pane = gui_add_pane(side_margin, total_items_height - scroll_offset + vertical_margin, "");
    with(pane) {
        width = other.main_width;
        centered = true;
        item_index = ds_list_find_index(other.gui_content, id);
    }
    
    return pane;
}

resize_item = function(index, height) {
    var child = gui_content[| index];
    
    if (is_undefined(child)) {
        return;
    }
    
    var orig_height = child.height;
    height = clamp(height, 0, self.height - 1);
    child.height = height;
    
    var diff = height - orig_height;
    reposition_lower_items(index + 1, diff);
}

reposition_lower_items = function(start_index, y_delta) {
    for (var index = start_index; index < item_count; index++) {
        var child = gui_content[| index];
        
        gui_move_element(child, child.x, child.y + y_delta);
    }
}

clamp_current_position = function() {
    if(item_count > 0)
    {
        if(cur_item < 0)
        {
            cur_item = 0;
            selection_pos = 0;
        }

        if(item_count-1 < cur_item)
        {
            cur_item = item_count-1;
            selection_pos = min(item_count-1, last_item - first_item);
        }
    }
}

clamp_selection_position = function() {
    selection_pos = max(0, min(selection_pos, min(item_count-1, last_item - first_item)));   
}

select_item = function(index) {
    if (index < 0) {
        index = item_count + index;
    }
    
    if (is_undefined(gui_content[| index])) {
        return false;
    }
    
    var diff = index - cur_item;
    selection_pos += diff;
    cur_item += diff;
    
    return true;
}

get_max_first_item = function() {
    var max_item_y;
    var max_first_item = item_count - 1;
    
    if (item_count <= 1) {
        return 0; 
    }
    
    max_item_y = get_y_of_item(max_first_item - 1);
    while (max_item_y > scroll_range) {
        max_first_item--;
        max_item_y = get_y_of_item(max_first_item - 1);
    }
    
    return max_first_item;
}

set_first_item = function(index) {
    first_item = clamp(index, 0, item_count - 1);
    var first_item_y = get_y_of_item(first_item);
    
    last_item = first_item;
    var next_item_bottom_y = get_bottom_y_of_item(last_item + 1);
    
    while (!is_undefined(next_item_bottom_y) && next_item_bottom_y <= (first_item_y + height)) {
        last_item++;
        next_item_bottom_y = get_bottom_y_of_item(last_item + 1);
    }
    
    set_scroll_offset(first_item_y);
    
    set_visibility_range();
}

set_scroll_offset = function(offset) {
    var last_scroll_offset = scroll_offset;
    scroll_offset = clamp(offset, 0, scroll_range);
    var diff = scroll_offset - last_scroll_offset;
    
    if (diff != 0) {
        for (var index = 0; index < item_count; index++) {
            var child = gui_content[| index];
            
            gui_move_element(child, child.x, child.y - diff);
        }
    }
}

update = function() {
    var last_main_width = main_width;
    main_width = width - 2 * side_margin - bar_width;
    if (bar_width > 0 && drawn_bar_width == 0) {
        main_width += bar_width;
    }
    if (last_main_width != main_width) {
        update_items_width();
    }
    
    item_count = ds_list_size(gui_content);
    total_items_height = get_items_range_height(0, item_count - 1);
    scroll_range = max(0, total_items_height - height + vertical_margin);
    max_first_item = get_max_first_item();
}

update_items_width = function() {
    for (var index = 0; index < item_count; index++) {
        var child = gui_content[| index];
            
        child.width = main_width;
    }
}

get_items_range_height = function(first_index, last_index) {
    var total_height = 0;
    
    for (var index = first_index; index <= last_index; index++) {
        var child = gui_content[| index];
        
        total_height += child.height + vertical_margin;
    }
    
    return total_height;
}

get_y_of_item = function(index) {
    var child = gui_content[| index];
    
    if (!is_undefined(child)) {
        return child.rel_y - rel_y + scroll_offset - vertical_margin;
    }
    
    return undefined;
}

get_bottom_y_of_item = function(index) {
    var child = gui_content[| index];
    
    if (!is_undefined(child)) {
        return child.rel_y - rel_y + scroll_offset + child.height + vertical_margin;
    }
    
    return undefined;
}

get_item_at_y = function(y) {
    for (var index = 0; index < item_count; index++) {
        if (get_y_of_item(index) <= y && y < get_bottom_y_of_item(index)) {
            return index;
        }
    }
    
    return -1;
}

set_visibility_range = function() {
    for (var index = 0; index < item_count; index++) {
        var child = gui_content[| index];
        if (index >= first_item && index <= last_item) {
            gui_show_element(child);
        } else {
            gui_hide_element(child);
        }
    }
}