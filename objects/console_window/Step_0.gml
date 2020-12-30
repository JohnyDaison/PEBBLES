slide_speed = max(0.1, sqrt(abs(1-abs( (y - slide_peak)/slide_peak )))*max_slide_speed);

if(singleton_obj.show_console != "hide" && y<0)
{
    y = min(0, y + slide_speed);
}
if(singleton_obj.show_console == "hide")
{
    y = max(-height, y - slide_speed);
    if(y == -height)
    {
        close_frame(id);
    }
}

if(singleton_obj.show_console != show_state && singleton_obj.show_console != "hide")
{
    var resolution_coef = view_hport[0]/1080;
    
    switch(singleton_obj.show_console)
    {
        case "peek":
            visible_line_count = 3;
            break;
        case "normal":
            visible_line_count = floor(resolution_coef * 12);
            break;
        case "full":
            visible_line_count = floor(resolution_coef * 30);
            break;
    }
    
    max_slide_speed = 32 * visible_line_count;
    
    self.height = (visible_line_count+1)*line_height + panel_height;
    slide_peak = -height/2;
    history_list_picker.height = self.height - panel_height;
    history_list.height = history_list_picker.height;
    
    gui_move_element(status_button, x, y+height-32);
    gui_move_element(command_input, x+32, y+height-32);
    gui_move_element(menu_button, x+width-32, y+height-32);
    gui_move_element(menu_pane, x+width/2 -32, y+height - (menu_height+panel_height));
    
    show_state = singleton_obj.show_console;
}

DB.console_history_cur_item = history_list.cur_item;
DB.console_history_selection_pos = history_list.selection_pos;