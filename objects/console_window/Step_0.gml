if(singleton_obj.show_console == "hide")
{
    close_frame(id);
    exit;
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
    
    self.height = (visible_line_count+1)*line_height + panel_height;
    history_list.height = self.height - panel_height;    
    
    gui_move_element(log_popup_button, x, y+height-32);
    gui_move_element(command_input, x+32, y+height-32);
    gui_move_element(menu_button, x+width-32, y+height-32);
    gui_move_element(menu_pane, x+width/2 -32, y+height - (menu_height+panel_height));
    
    show_state = singleton_obj.show_console;
}

if (history_list.cur_item == history_list.item_count - 1) {
    DB.console_history_cur_item = -1;
    DB.console_history_selection_pos = -1;
} else {
    DB.console_history_cur_item = history_list.cur_item;
    DB.console_history_selection_pos = history_list.selection_pos;
}

if (DB.console_popup_on_log) {
    log_popup_button.icon = green_dot_spr;
} else {
    log_popup_button.icon = black_dot_spr;
}