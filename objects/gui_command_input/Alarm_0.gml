self.list_picker = gui_add_list_picker(x, y+height, "text", items);
list_picker.width = 256;
list_picker.align_items = "left";
gui_hide_element(list_picker);
list_picker.is_dropdown = true;
list_picker.auto_height = true;

with(list_picker)
{
    alarm[0] = -1;
    event_perform(ev_alarm, 0);
}

var scroll_list = list_picker.scroll_list;
scroll_list.item_click_script = gui_command_whisper_script;
