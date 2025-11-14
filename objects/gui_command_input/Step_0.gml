if (!self.visible) {
    exit;
}

if (!self.enabled) {
    self.bg_color = self.disabled_color;
    exit;
}

if (self.bg_color == self.disabled_color) {
    self.bg_color = self.base_bg_color;
}

// get/lose focus
if (cursor_obj.x >= self.x && cursor_obj.x <= (self.x + self.width) &&
    cursor_obj.y >= self.y && cursor_obj.y <= (self.y + self.height) &&
    DB.mouse_has_moved) {
    self.mouse_over = true;

    if (!self.focused) {
        gui_get_focus();
    }
}
else {
    if (!self.active && self.mouse_over && self.focused) {
        gui_lose_focus();
    }

    self.mouse_over = false;
}

// handle click/Enter - toggle active state
if (self.focused) {
    if ((mouse_check_button_released(mb_left) && self.mouse_over) || (DB.gui_controls[# confirm, released] && (!self.mouse_over || self.active)))
    {
        if (!self.active) {
            if (self.text == self.prompt_str) {
                keyboard_string = "";
            }
            else {
                keyboard_string = self.text;
            }

            //gui_dropdown_script();
        }

        if (self.was_active) {
            self.text = keyboard_string;
            parse_user_command();
            self.command_history_index = -1;
            //gui_dropdown_script();
        }

        self.active = !self.active;
        self.depressed = self.active;
        my_sound_play(click_sound);
    }
}

if (!self.mouse_over && mouse_check_button_released(mb_left)) {
    self.focused = false;
}

if (!self.focused && self.had_focus) {
    if (self.was_active) {
        self.text = keyboard_string;
    }

    self.active = false;
    self.depressed = false;
    self.bg_color = self.base_bg_color;
}

if (self.depressed) {
    self.bg_color = self.depressed_color;
}

if (!self.depressed && self.focused) {
    self.bg_color = self.highlight_color;
}

if (!self.had_focus && self.focused) {
    my_sound_play(blip_sound);
}

var was_tab_mode = self.tab_mode;

// handle Tab, Up, Down keys; history mode
if (self.depressed) {
    if (string_length(keyboard_string) > self.max_chars) {
        keyboard_string = string_copy(keyboard_string, 0, self.max_chars);
    }

    var space_index = string_pos(" ", keyboard_string);

    var tab_key = keyboard_check_pressed(vk_tab);
    var up_key = keyboard_check_pressed(vk_up);
    var down_key = keyboard_check_pressed(vk_down);
    var console_key = keyboard_check_pressed(192);

    if (!self.history_mode && tab_key) {
        if (space_index == 0) {
            var list = DB.console_modes[? DB.console_mode];
            var count = ds_list_size(list);
            var command = self.text;
            var index = ds_list_find_index(list, command);
            var start = (index + 1) mod count;

            for (var i = 0; i < count; i++) {
                index = (start + i) mod count;
                command = list[| index];

                if (string_pos(self.tab_text, command) == 1 && ds_list_find_index(DB.console_secrets, command) == -1) {
                    self.tab_mode = true;
                    self.text = command;
                    break;
                }
            }
        }
    }
    else if (!self.tab_mode && (up_key || down_key)) {
        var dir = 0, count = ds_list_size(DB.console_command_history);
        var last_index = count - 1;

        if (up_key)
            dir--;
        if (down_key)
            dir++;

        if (count > 0) {
            if (self.command_history_index == -1) {
                self.command_history_index = last_index;
            }

            if (self.history_mode) {
                self.command_history_index += dir;

                if (self.command_history_index < 0)
                    self.command_history_index = 0;

                if (self.command_history_index > last_index)
                    self.command_history_index = last_index;
            }

            self.text = DB.console_command_history[| self.command_history_index];
            self.history_mode = true;
        }

    }
    else if (keyboard_check_pressed(vk_anykey) && !console_key) {
        if (self.tab_mode || self.history_mode) {
            var end_str = string_lettersdigits(keyboard_lastchar);

            if (self.tab_mode) {
                end_str = " " + end_str;
            }

            keyboard_string = self.text + end_str;
        }

        self.tab_mode = false;
        self.history_mode = false;
    }

    if (!self.tab_mode && !self.history_mode) {
        self.text = keyboard_string;

        if (self.active) {
            self.text += "_";
        }
    }

    if (space_index == 0) {
        self.tab_text = keyboard_string;
    }
    else {
        self.tab_text = string_copy(keyboard_string, 1, space_index);
    }
}

if (!self.depressed) {
    self.tab_mode = false;
    self.history_mode = false;
}

var reset_list_picker = false;

// tab_mode start
if (!was_tab_mode && self.tab_mode) {
    ds_list_clear(self.items);
    gui_show_element(self.list_picker);

    var list = DB.console_modes[? DB.console_mode];
    var count = ds_list_size(list);

    for (var i = 0; i < count; i++) {
        var command = list[| i];

        if (string_pos(self.tab_text, command) == 1 && ds_list_find_index(DB.console_secrets, command) == -1) {
            ds_list_add(self.items, command);
        }
    }

    reset_list_picker = true;
}

// tab_mode update
if (self.tab_mode) {
    var scroll_list = self.list_picker.scroll_list;
    var index = ds_list_find_index(scroll_list.items, self.text);
    if (index != -1) {
        scroll_list.cur_item = index;
        scroll_list.selection_pos = index;
    }
}

// tab_mode end
if (was_tab_mode && !self.tab_mode) {
    //ds_list_clear(items);
    gui_hide_element(self.list_picker);

    //reset_list_picker = true;
}

// list_picker reset
if (reset_list_picker) {
    self.list_picker.scroll_list.max_items = ds_list_size(self.items);
    gui_list_picker_items_reset(self.list_picker, "text", self.items);
}

// adjust position
gui_move_element(self.list_picker, self.list_picker.x, self.y + self.height);

if (singleton_obj.show_console == "full") {
    gui_move_element(self.list_picker, self.list_picker.x, self.y - self.list_picker.height);
}

// trim whitespace, show prompt
if (self.was_active && !self.active) {
    if (string_length(self.text) > 0) {
        while (string_char_at(self.text, string_length(self.text)) == " ") {
            self.text = string_copy(self.text, 1, string_length(self.text) - 1);
        }

        while (string_char_at(self.text, 1) == " ") {
            self.text = string_copy(self.text, 2, string_length(self.text) - 1);
        }
    }

    if (string_length(self.text) == 0) {
        self.text = self.prompt_str;
    }
}

// record previous state
self.had_focus = self.focused;
self.was_active = self.active;
