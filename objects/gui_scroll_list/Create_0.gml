event_inherited();

self.font = label_font;
self.character_width = 10;
self.draw_border = true;
self.draw_bg_color = true;
self.draw_lines_bg = true;
self.bg_alpha = 0.3;
self.border_alpha = 0.5;
self.width = 160;
self.height = 164;
self.ends_height = 4;
self.item_height = 32;
self.item_padding = 0;
self.item_bg_color = c_white;
self.item_bg_alpha = 0.8;
self.alternate_lines = true;
self.content_padding = 6;
self.side_margin = 4;
self.bar_width = 16;
self.drawn_bar_width = 0;
self.bar_corner_radius = corner_radius;
self.bar_bg_color = c_white;
self.bar_knob_color = merge_color(c_ltgray, c_white, 0.5);
self.bar_knob_margin = 0;
self.bar_knob_alpha = 0.9;
self.auto_height = false;
self.auto_items = false;
main_width = 0;
drawn_main_width = 0;
bar_start = 0;
knob_offset = 0;
knob_height = 0;
dropdown_bar_handled = true;

type = "text";
centered = false;
align_items = "center";
items = ds_list_create();

self.cur_item = -1;
self.first_item = 0;
self.last_item = 0;
self.item_count = 0;
self.max_items = 4;
self.selection_pos = 0;
self.highlighted_item = -1;
self.want_focus = true;
self.item_change_script = empty_script;
self.item_click_script = empty_script;
self.mouse_scroll_speed = 1;
self.is_list_picker = false;

do_auto_updates = function() {
    if(auto_height)
    {
        height = ends_height*2 + max_items*item_height;
    }

    if(auto_items)
    {
        max_items = floor((height - ends_height*2) / item_height);
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
            selection_pos = min(item_count-1, max_items-1);
        }
        
        selection_pos = max(0, min(selection_pos, min(item_count-1, max_items-1)));
    
        first_item = max(0, min(item_count - max_items, cur_item - selection_pos));
        last_item = min(item_count-1, first_item + max_items-1);
    }
}

select_item = function(index) {
    if (index < 0) {
        index = item_count + index;
    }
    
    if (is_undefined(items[| index])) {
        return false;
    }
    
    var diff = index - cur_item;
    selection_pos += diff;
    cur_item += diff;
    
    return true;
}

update = function() {
    main_width = width - 2 * side_margin - bar_width;
    drawn_main_width = main_width;
    if (bar_width > 0 && drawn_bar_width == 0) {
        drawn_main_width += bar_width;
    }
    total_items_height = item_count * item_height;
}

load_long_text = function(new_text, list) {
    var max_line_length = (main_width - 2 * content_padding) / character_width;
    var line, line_length, new_line, chi, line_break_delay = 0, do_delay;
    
    string_explode(new_text,"\n",list);
    
    var count = ds_list_size(list);
    
    for(var i=0; i<count; i++)
    {
        line = list[| i];
        line_length = string_length(line);
        new_line = "";
        
        while(line_length > max_line_length)
        {
            line_break_delay = 0;
            for(chi = line_length; chi >= 1; chi--)
            {
                if(string_char_at(line, chi) == " ")
                {
                    do_delay = (string_char_at(line, chi-2) == " " || string_char_at(line, chi-3) == " " || string_char_at(line, chi-4) == " ");
                    if(do_delay)
                    {
                        line_break_delay++;
                    }
                    
                    if(!do_delay || line_break_delay > 3)
                    {
                        new_line = string_copy(line, chi, line_length-chi+1) + new_line;
                        line = string_copy(line, 1, chi-1);
                        break;
                    }
                }
            }
            
            line_length = string_length(line);
        }
        
        if(new_line != "")
        {
            list[| i] = line;
            ds_list_insert(list, i+1, new_line);
            count++;
        }
    }
    
    if(count < max_items)
    {
        repeat(max_items - count)
        {
            ds_list_add(list, "");
        }
    }
    
    gui_reset_scroll_items(id, "text", list);
}