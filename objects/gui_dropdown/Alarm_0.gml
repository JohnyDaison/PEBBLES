if(ds_exists(items, ds_type_list))
{
    str = string(items[| value]);
}
else
{
    str = "";
}

self.button = gui_add_button(x, y, str, gui_dropdown_script);
button.width = width;
button.height = height;
button.centered = true;
button.icon = arrow_down_spr;
button.show_icon = true;
button.button_function = "toggleDropdown";
button.text_align = text_align;

if(id_list != noone)
{
    self.list_picker = gui_add_list_picker(x, y+height, type, items, id_list);
}
else
{
    self.list_picker = gui_add_list_picker(x, y+height, type, items);
}

list_picker.width = width;
list_picker.visible = false;
list_picker.depth -= 20;
list_picker.hidden = true;
list_picker.is_dropdown = true;
list_picker.item_change_script = self.item_change_script;
list_picker.align_items = align_items;