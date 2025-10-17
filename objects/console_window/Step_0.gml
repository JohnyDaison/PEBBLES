if (singleton_obj.show_console == "hide") {
    close_frame(self.id);
    exit;
}

if (singleton_obj.show_console != self.show_state && singleton_obj.show_console != "hide") {
    updateVisibleLineCount();

    self.history_list.height = self.height - self.panel_height;

    gui_move_element(self.log_popup_button, self.x, self.y + self.height - 32);
    gui_move_element(self.command_input, self.x + 32, self.y + self.height - 32);
    gui_move_element(self.menu_button, self.x + self.width - 32, self.y + self.height - 32);
    gui_move_element(self.menu_pane, self.x + self.width / 2 - 32, self.y + self.height - (self.menu_height + self.panel_height));

    self.show_state = singleton_obj.show_console;
}

if (self.history_list.cur_item == self.history_list.item_count - 1) {
    DB.console_history_cur_item = -1;
    DB.console_history_selection_pos = -1;
} else {
    DB.console_history_cur_item = self.history_list.cur_item;
    DB.console_history_selection_pos = self.history_list.selection_pos;
}

if (DB.console_popup_on_log) {
    self.log_popup_button.icon = green_dot_spr;
} else {
    self.log_popup_button.icon = black_dot_spr;
}