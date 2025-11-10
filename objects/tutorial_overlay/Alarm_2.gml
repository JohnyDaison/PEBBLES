/// @description  UPDATE MESSAGE
if (instance_exists(self.my_guy)) {
    self.old_message = self.message;
    var change_made = false;

    // UPDATE MESSAGE
    for (var index = 0; index < self.message_count; index++) {
        var message_script = self.messages[index];

        var state = self.message_state[index];

        if (state == 0 && self.message == "" && self.fadeout_step == self.fadeout_time) {
            self.title = script_execute(message_script, "title");

            if (script_execute(message_script, "show_check")) {
                self.message = script_execute(message_script, "message");
                self.blink_step = 0;
                self.cur_message_step = 0;
                state = 1;
                change_made = true;
            }

        }

        if (state != 2 && !change_made) {
            if (script_execute(message_script, "hide_check")) {
                self.title = script_execute(message_script, "title");

                if (state == 1) {
                    self.fadeout_step = 0;
                    self.blink_step = self.blink_time;
                } //self.message = "";

                state = 2;
                change_made = true;
            }

            if (state == 1) {
                if (script_execute(message_script, "cancel_check")) {
                    self.title = script_execute(message_script, "title");
                    self.fadeout_step = 0;
                    self.blink_step = self.blink_time; //self.message = "";
                    state = 0;
                    change_made = true;
                }
            }
        }

        self.message_state[index] = state;

        //if(self.message != self.old_message) break;
        if (change_made) break;
    }

    // UPDATE FRAME
    var view = self.my_player.my_camera.view;
    self.max_width = view_get_wport(view) - 192;

    if (self.message != "") {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        my_draw_set_font(self.font);

        self.width = 256;
        self.height = 1000;

        while (self.width <= self.max_width && self.height > (self.line_height * self.max_lines)) {
            self.width += 32;
            self.height = string_height_ext(self.message, self.line_height, self.width);
        }

        self.width += 32;
        self.height += 32;

        self.focused = true;
    }
    else {
        self.width = 0;
        self.height = 0;
    }

    self.x = view_get_xport(view) + view_get_wport(view) / 2 - self.width / 2;
    self.y = view_get_yport(view) + view_get_hport(view) * 0.8 - self.height / 2;
}
else {
    self.width = 0;
    self.height = 0;
}

self.alarm[2] = self.message_delay;
