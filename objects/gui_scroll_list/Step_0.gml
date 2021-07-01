event_inherited();

do_auto_updates();

main_width = width - bar_width - bar_margin;

// SCROLL BAR
if(self.bar_width > 0)
{
    bar_start = main_width + bar_margin;
    
    var item_range = max(0, item_count - max_items);
    knob_height = height/(1 + item_range);
    if(bar_width > knob_height)
    {
        knob_height = bar_width;
    }
    
    //knob_offset = round(knob_height * first_item);
    knob_offset = ceil((height - knob_height) * (first_item / item_range));
    knob_height = floor(knob_height);
}


var last_cur_item = cur_item;

item_count = ds_list_size(items);

// MOUSE WHEEL SCROLL
if(cur_item != -1 && cursor_obj.focus == id)
{
    if(cur_item > 0 && mouse_wheel_up())
    {
        cur_item -= mouse_scroll_speed;
        selection_pos -= mouse_scroll_speed;
    }
    else if(cur_item < item_count-1 && mouse_wheel_down())
    {
        cur_item += mouse_scroll_speed;
        selection_pos += mouse_scroll_speed;
    }
}

// CLAMP cur_item AND selection_pos
clamp_current_position();

// MAIN UPDATE
if(cur_item != -1)
{
    selection_pos = max(0, min(selection_pos, min(item_count-1, max_items-1)));
    
    first_item = max(0, min(item_count - max_items, cur_item - selection_pos));
    last_item = min(item_count-1, first_item + max_items-1);

    mouse_over = false;
    
    var i, diff;
    
    if(visible && cursor_obj.focus == id)
    {
        // ITEMS
        for(i = 0; i < (last_item - first_item + 1) && !mouse_over; i++)
        {
            if(DB.mouse_has_moved
            && cursor_obj.x > x && cursor_obj.x < (x + main_width)
            && cursor_obj.y > (y + ends_height + i*item_height + item_padding)
            && cursor_obj.y < (y + ends_height + (i+1)*item_height - item_padding))
            {
                mouse_over = true;
                highlighted_item = i+first_item;
                if(!focused) gui_get_focus();
            
                if(focused)
                {
                    if(mouse_check_button_pressed(mb_left) && mouse_over)
                    {
                        diff = i - self.selection_pos;
                        selection_pos += diff;
                        cur_item += diff;
                        my_sound_play(blip_sound);
                        script_execute(item_click_script);
                    }
                }
            }
            
        }
        
        // SCROLL BAR
        if(DB.mouse_has_moved
        && cursor_obj.x > (x + bar_start) && cursor_obj.x < (x + bar_start + bar_width)
        && cursor_obj.y > (y + bar_knob_margin) && cursor_obj.y < (y + height - bar_knob_margin))
        {
            mouse_over = true;
            var bar_ratio = (cursor_obj.y - (y + bar_knob_margin)) / (height - 2*bar_knob_margin);
            var max_first_item = max(0, item_count - max_items);
            var new_first_item = floor((max_first_item+1) * bar_ratio);
            if(!focused) gui_get_focus();
        
            if(focused)
            {
                if(mouse_check_button(mb_left) && mouse_over)
                {
                    diff = (new_first_item - first_item);
                    if(diff != 0)
                    {
                        first_item = new_first_item;
                        last_item = min(item_count-1, first_item + max_items-1);
                        
                        selection_pos -= diff;
                        var temp_selection_pos = selection_pos;
                        selection_pos = max(0, min(selection_pos, min(item_count-1, max_items-1)));
                        
                        if(temp_selection_pos != selection_pos)
                        {
                            cur_item += selection_pos - temp_selection_pos;
                        }
                        
                        my_sound_play(blip_sound);
                        script_execute(item_click_script);
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
