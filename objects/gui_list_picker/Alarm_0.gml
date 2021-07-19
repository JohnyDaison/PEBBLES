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
        bar_knob_color = c_dkgray;
    
        height = ends_height*2 + max_items*item_height;
    }
    
    self.height = scroll_list.height;
}
else
{
    scroll_list.item_height = 40;
    scroll_list.item_padding = 8;
    
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

/*
if(ds_exists(source_list, ds_type_list))
{
    if(type == "text")
    {
        ds_list_copy(scroll_list.items, source_list);
        scroll_list.type = "text";
    }
    else if(type == "flag")
    {
        var i, count = ds_list_size(source_list);

        for(i=0; i < count; i++)
        {
            scroll_list.items[| i] = DB.battlefeed_icon_map[? (source_list[| i])];
        }
        
        scroll_list.type = "icon";
    }
}
*/


eloffset_x = x; //  + scroll_list.width + 8
eloffset_y = y;


self.up_arrow = gui_add_button(0,0, "",gui_list_picker_script,true);
up_arrow.icon = small_nice_up_arrow_spr;
up_arrow.button_function = "up";

up_arrow.width = scroll_list.width - scroll_list.bar_margin - scroll_list.bar_width;
up_arrow.height = scroll_list.ends_height;
up_arrow.show_icon = true; 
up_arrow.center_icon = true;
up_arrow.centered = true;
up_arrow.depth -= 1;

up_arrow.enabled_icon_color = up_arrow.base_bg_color;
up_arrow.base_bg_color = merge_color(select_color, c_white, 0.5);


self.down_arrow = gui_add_button(0,scroll_list.height-scroll_list.ends_height, "",gui_list_picker_script,true);
down_arrow.icon = small_nice_down_arrow_spr;
down_arrow.button_function = "down";

down_arrow.width = scroll_list.width - scroll_list.bar_margin - scroll_list.bar_width;
down_arrow.height = scroll_list.ends_height;
down_arrow.show_icon = true;
down_arrow.center_icon = true;
down_arrow.centered = true;
down_arrow.depth -= 1;

down_arrow.enabled_icon_color = down_arrow.base_bg_color;
down_arrow.base_bg_color = merge_color(select_color, c_white, 0.5);


gui_list_picker_update_script(id);