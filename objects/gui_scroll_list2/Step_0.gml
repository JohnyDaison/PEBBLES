event_inherited();

update();

// SCROLL BAR
if(self.bar_width > 0)
{
    bar_start = width - bar_width;
    knob_height = height;
    knob_offset = 0;
    
    if (scroll_range > 0) {
        var displayed_ratio = height / total_items_height;
        
        knob_height = height * displayed_ratio;
        if(bar_width > knob_height)
        {
            knob_height = bar_width;
        }

        knob_offset = ceil((height - knob_height) * (scroll_offset / scroll_range));
    }
    knob_height = floor(knob_height);
    
    if (scroll_range == 0) {
        drawn_bar_width = 0;
    } else {
        drawn_bar_width = bar_width;
    }
} else {
    drawn_bar_width = 0;
}


var last_cur_item = cur_item;

// MOUSE WHEEL SCROLL
if(cur_item != -1 && cursor_obj.focus == id)
{
    if(cur_item > 0 && mouse_wheel_up())
    {
        select_item(max(0, cur_item - mouse_scroll_speed));
    }
    else if(cur_item < item_count-1 && mouse_wheel_down())
    {
        select_item(min(item_count-1, cur_item + mouse_scroll_speed));
    }
}

// CLAMP cur_item AND selection_pos
clamp_current_position();

// MAIN UPDATE
if(cur_item != -1)
{
    clamp_selection_position();
    
    var new_first_item = min(max_first_item, cur_item - selection_pos);
    set_first_item(new_first_item);

    mouse_over = false;
    
    var i, diff;
    
    if(visible && cursor_obj.focus == id)
    {
        // ITEMS
        for(i = 0; i < (last_item - first_item + 1) && !mouse_over; i++)
        {
            var item = gui_content[| i + first_item];
            
            if(DB.mouse_has_moved
            && cursor_obj.x > item.x && cursor_obj.x < (item.x + item.width)
            && cursor_obj.y > item.y && cursor_obj.y < (item.y + item.height))
            {
                mouse_over = true;
                highlighted_item = i + first_item;
                if(!focused) gui_get_focus();
            
                if(focused)
                {
                    if(mouse_check_button_pressed(mb_left) && mouse_over)
                    {
                        select_item(i + first_item);
                        script_execute(item_click_script);
                    }
                }
            }
        }
        
        // SCROLL BAR
        if(DB.mouse_has_moved && scroll_range > 0
        && cursor_obj.x > (x + bar_start) && cursor_obj.x < (x + bar_start + bar_width)
        && cursor_obj.y > (y + bar_knob_margin) && cursor_obj.y < (y + height - bar_knob_margin))
        {
            mouse_over = true;
            
            if(!focused) gui_get_focus();
        
            if(focused)
            {
                if(mouse_check_button(mb_left) && mouse_over)
                {
                    var bar_ratio = (cursor_obj.y - (y + bar_knob_margin)) / (height - 2*bar_knob_margin);
                    var new_item_y = bar_ratio * total_items_height;
                    var new_first_item = min(max_first_item, get_item_at_y(new_item_y));
                    
                    diff = (new_first_item - first_item);
                    if(diff != 0)
                    {
                        set_first_item(new_first_item);
                        
                        selection_pos -= diff;
                        var temp_selection_pos = selection_pos;
                        clamp_selection_position();
                        
                        if(temp_selection_pos != selection_pos)
                        {
                            cur_item += selection_pos - temp_selection_pos;
                            script_execute(item_click_script);
                        }
                        
                        my_sound_play(blip_sound);
                    }
                }
            }
        }
    }
} 
if(!had_focus && focused)
{
    my_sound_play(blip_sound);
}
if(had_focus && !mouse_over)
{
    highlighted_item = -1;
}

had_focus = focused;

if(last_cur_item != cur_item)
{
    script_execute(item_change_script);
}
