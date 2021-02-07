event_inherited();

self.line_height = 32;
self.panel_height = 32;
self.visible_line_count = 1;
self.show_state = "hide";
self.menu_open = false;
self.show_backgrounds = true;

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

self.width = view_wport[0];
self.height = (visible_line_count+1)*line_height + panel_height;

x = 0;
y = 0;

self.keep_inside = false;

self.draw_border = false;
self.bg_alpha = 0.9;
self.bg_color = c_black;
self.border_alpha = 0.9;
self.border_color = c_green;


// ELEMENTS

var i, ii;

// HISTORY
ii = gui_add_list_picker(x, y, "text", DB.console_history);
ii.width = self.width;
ii.height = self.height - panel_height;
ii.centered = true;
ii.auto_items = true;
with(ii)
{
    alarm[0] = -1;
    event_perform(ev_alarm, 0);
}

gui_hide_element(ii.up_arrow);
gui_hide_element(ii.down_arrow);

self.history_list_picker = ii;

i = history_list_picker.scroll_list;

i.align_items = "left";
i.draw_bg_color = false;
i.draw_border = false;
i.bg_color = c_black;
i.text_color = c_white;
i.alternate_lines = true;
i.item_height = 32;
i.bar_width = 16;
i.item_padding = 0;
i.highlight_color = merge_colour(c_black, c_purple, 0.5);
i.select_color = merge_colour(c_black, c_lime, 0.5);
i.max_items = visible_line_count;
i.item_count = ds_list_size(i.items);

self.history_list = i;


// STATUS
i = gui_add_button(x, y+height-32, "", empty_script);
i.icon = green_dot_spr;
i.show_icon = true;
i.center_icon = true;
i.width = 31;
i.height = 31;
i.centered = true;

self.status_button = i;

// INPUT
i = gui_add_command_input(x+32, y+height-32, ">");
i.text_align = "left";
i.show_prompt = true;
i.width = self.width-64;
i.height = 31;
i.centered = true;

self.command_input = i;

// MENU

i = gui_add_button(x+width-32, y+height-32, "", toggle_console_menu);
i.icon = hamburger_icon_spr;
i.show_icon = true;
i.center_icon = true;
i.width = 31;
i.height = 31;
i.centered = true;

self.menu_button = i;

menu_height = 128;

i = gui_add_pane(x+width/2 -32, y+height - (menu_height+panel_height), "");
i.width = width/2;
i.height = menu_height;
i.draw_bg_color = true;
i.bg_alpha = 0.8;
i.depth -= 5;
i.visible = false;
i.hidden = true;
i.align = "left";
i.centered = true;

self.menu_pane = i;

with(menu_pane)
{
    eloffset_x = x + 16;
    eloffset_y = y + 8;
    
    command_drop = gui_add_dropdown(0, 16, "text", DB.console_commands_saved, 0);
    
    command_drop.width = width - 64;
    
    i = gui_add_button(0, 64, "Copy", console_dropdown_copy);
    i.align = "left";
    
    i = gui_add_button(192, 64, "Copy & Execute", console_dropdown_copyparse);
    i.align = "left";
}

if (DB.console_history_cur_item == -1) {
    history_list.cur_item = history_list.item_count;	
    history_list.selection_pos = history_list.max_items;
} else {
    history_list.cur_item = DB.console_history_cur_item;
    history_list.selection_pos = DB.console_history_selection_pos;
}

with(history_list)
{
    script_execute(item_change_script);
}

alarm[1] = 5;
