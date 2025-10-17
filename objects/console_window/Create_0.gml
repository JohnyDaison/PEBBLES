event_inherited();

self.line_height = 32;
self.panel_height = 32;
self.visible_line_count = 1;
self.show_state = "hide";
self.menu_open = false;
self.show_backgrounds = true;

function updateVisibleLineCount() {
    var resolution_coef = view_hport[0] / 1080;

    switch (singleton_obj.show_console) {
        case "peek":
            self.visible_line_count = 3;
            break;
        case "normal":
            self.visible_line_count = floor(resolution_coef * 12);
            break;
        case "full":
            self.visible_line_count = floor(resolution_coef * 30);
            break;
    }

    self.height = (self.visible_line_count + 1) * self.line_height + self.panel_height;
}

updateVisibleLineCount();

self.width = view_wport[0];

self.x = 0;
self.y = 0;

self.keep_inside = false;

self.draw_border = false;
self.bg_alpha = 0.9;
self.bg_color = c_black;
self.border_alpha = 0.9;
self.border_color = c_green;


// ELEMENTS

var inst;

// HISTORY
inst = gui_add_scroll_list(self.x, self.y);
inst.width = self.width;
inst.height = self.height - self.panel_height;
inst.centered = true;
inst.auto_items = true;
inst.align_items = "left";
inst.draw_bg_color = false;
inst.draw_border = false;
inst.bg_color = c_black;
inst.text_color = c_white;
inst.alternate_lines = true;
inst.item_height = 32;
inst.bar_width = 16;
inst.item_padding = 0;
inst.ends_height = 16;
inst.highlight_color = merge_colour(c_black, c_purple, 0.5);
inst.select_color = merge_colour(c_black, c_lime, 0.5);
inst.max_items = self.visible_line_count;
inst.is_list_picker = true;

gui_reset_scroll_items(inst, "text", DB.console_history);

self.history_list = inst;


// POPUP TOGGLE
inst = gui_add_button(self.x, self.y + self.height - 32, "", console_toggle_popup_on_log);
inst.icon = green_dot_spr;
inst.show_icon = true;
inst.center_icon = true;
inst.width = 31;
inst.height = 31;
inst.centered = true;
inst.tooltip = "Show Console when a new log message is added (toggle)";

self.log_popup_button = inst;

// INPUT
inst = gui_add_command_input(self.x + 32, self.y + self.height - 32, ">");
inst.text_align = "left";
inst.show_prompt = true;
inst.width = self.width - 64;
inst.height = 31;
inst.centered = true;

self.command_input = inst;

// MENU

inst = gui_add_button(self.x + self.width - 32, self.y + self.height - 32, "", toggle_console_menu);
inst.icon = hamburger_icon_spr;
inst.show_icon = true;
inst.center_icon = true;
inst.width = 31;
inst.height = 31;
inst.centered = true;

self.menu_button = inst;

self.menu_height = 128;

inst = gui_add_pane(self.x + self.width / 2 - 32, self.y + self.height - (self.menu_height + self.panel_height), "");
inst.width = self.width / 2;
inst.height = self.menu_height;
inst.draw_bg_color = true;
inst.bg_alpha = 0.8;
inst.depth -= 5;
inst.visible = false;
inst.hidden = true;
inst.align = "left";
inst.centered = true;

self.menu_pane = inst;

with (self.menu_pane) {
    self.eloffset_x = self.x + 16;
    self.eloffset_y = self.y + 8;

    self.command_drop = gui_add_dropdown(0, 16, "text", DB.console_commands_saved, 0);

    self.command_drop.width = self.width - 64;

    inst = gui_add_button(0, 64, "Copy", console_dropdown_copy);
    inst.align = "left";

    inst = gui_add_button(192, 64, "Copy & Execute", console_dropdown_copyparse);
    inst.align = "left";

    inst = gui_add_button(416, 64, "Watches", open_watches_window);
    inst.align = "left";
}

if (DB.console_history_cur_item == -1) {
    self.history_list.cur_item = self.history_list.item_count;
    self.history_list.selection_pos = self.history_list.max_items;
} else {
    self.history_list.cur_item = DB.console_history_cur_item;
    self.history_list.selection_pos = DB.console_history_selection_pos;
}

with (self.history_list) {
    script_execute(self.item_change_script);
}

self.alarm[1] = 5;
