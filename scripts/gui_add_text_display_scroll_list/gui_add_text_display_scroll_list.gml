function gui_add_text_display_scroll_list(xx, yy) {
    var scroll_list = gui_add_scroll_list(xx, yy);
    
    with(scroll_list) {
        centered = true;
        auto_items = true;
        align_items = "left";
        text_color = c_white;
        select_text_color = c_white;
        alternate_lines = false;

        bg_color = c_black;
        bg_alpha = 0.8;
        bar_bg_color = c_gray;
        item_bg_color = c_black;
        item_height = 20;
        ends_height = side_margin;
        item_padding = 0;
        highlight_color = merge_colour(item_bg_color, c_purple, 0.1);
        select_color = merge_colour(item_bg_color, c_lime, 0.1);
    }
    
    return scroll_list;
}