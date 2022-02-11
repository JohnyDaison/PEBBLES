function gui_add_text_display_scroll_list(xx, yy) {
    var scroll_list = gui_add_scroll_list(xx, yy);
    
    scroll_list.centered = true;
    scroll_list.auto_items = true;
    scroll_list.align_items = "left";
    scroll_list.text_color = c_white;
    scroll_list.select_text_color = c_white;
    scroll_list.alternate_lines = false;

    scroll_list.bg_color = c_black;
    scroll_list.bg_alpha = 0.8;
    scroll_list.bar_bg_color = c_gray;
    scroll_list.item_bg_color = c_black;
    scroll_list.item_height = 20;
    scroll_list.item_padding = 0;
    scroll_list.highlight_color = merge_colour(scroll_list.item_bg_color, c_purple, 0.1);
    scroll_list.select_color = merge_colour(scroll_list.item_bg_color, c_lime, 0.1);
    
    return scroll_list;
}