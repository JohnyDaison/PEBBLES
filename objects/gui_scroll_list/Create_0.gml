event_inherited();

self.font = label_font;
self.draw_border = true;
self.draw_bg_color = true;
self.draw_lines_bg = true;
self.bg_alpha = 0.3;
self.border_alpha = 0.5;
self.width = 160;
self.height = 164;
self.ends_height = 16;
self.item_height = 32;
self.item_padding = 0;
self.item_bg_color = c_white;
self.item_bg_alpha = 0.8;
self.alternate_lines = true;
self.content_padding = 6;
self.bar_width = 8;
self.bar_margin = 2; 
self.bar_bg_color = c_white;
self.bar_knob_color = merge_color(c_ltgray, c_white, 0.5);
self.bar_knob_margin = 1;
self.bar_knob_alpha = 0.9;
self.auto_height = false;
self.auto_items = false;
main_width = 0;
bar_start = 0;
knob_offset = 0;
knob_height = 0;

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

function do_auto_updates() {
    if(auto_height)
    {
        height = ends_height*2 + max_items*item_height;
    }

    if(auto_items)
    {
        max_items = floor((height - ends_height*2) / item_height);
    }
}

function clamp_current_position() {
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
    }
}

select_item = function(index) {
    if (is_undefined(items[| index])) {
        return false;
    }
    
    var diff = index - cur_item;
    selection_pos += diff;
    cur_item += diff;
    
    return true;
}
