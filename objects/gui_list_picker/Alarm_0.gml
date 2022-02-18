/// @description CREATE SCROLL LIST AND BUTTONS
self.scroll_list = gui_add_scroll_list(x,y);
scroll_list.width = self.width;
scroll_list.height = self.height;
scroll_list.max_items = self.max_items;
scroll_list.auto_height = self.auto_height;
scroll_list.auto_items = self.auto_items;
scroll_list.centered = true;
scroll_list.align_items = self.align_items;
scroll_list.item_change_script = gui_list_picker_scroll_list_script;
scroll_list.is_list_picker = true;
scroll_list.text_color = self.text_color;
scroll_list.select_text_color = self.select_text_color;
scroll_list.alternate_lines = false;

if(is_dropdown)
{
    with(scroll_list)
    {
        bg_alpha = 1;
        border_alpha = 1;
        item_click_script = gui_dropdown_script;
        item_height = 36;
        item_padding = 4;
        ends_height = 2;
        bar_bg_color = merge_color(c_gray, c_ltgray, 0.5);
        dropdown_bar_handled = false;
    
        height = ends_height*2 + max_items*item_height;
    }
    
    self.height = scroll_list.height;
}
else
{
    scroll_list.item_height = 40;
    scroll_list.item_padding = 8;
    scroll_list.ends_height = 0;
    
    scroll_list.auto_items = true;
}

if(!is_undefined(item_height))
{
    scroll_list.item_height = item_height;
}

if(!is_undefined(item_padding))
{
    scroll_list.item_padding = item_padding;
}

gui_reset_scroll_items(scroll_list, type, label_list);

scroll_list.update();

gui_list_picker_update_script(id);