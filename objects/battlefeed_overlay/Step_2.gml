/// @description MESSAGES, SIZE, POSITION UPDATE

// MESSAGES CROPPING AND FADING
self.last_msg_count = self.msg_count;
self.msg_count = ds_list_size(self.msg_list);

var resize = false;

if (self.msg_count != self.last_msg_count) {
    self.fade_ratio = 6;
    resize = true;
}

if (self.msg_count > self.msg_max) {
    self.destroyMessageItemAtIndex(0);

    ds_list_delete(self.msg_list, 0);
    self.msg_count -= 1;

    resize = true;
}

if (self.fade_ratio > self.fade_speed) {
    self.fade_ratio -= self.fade_speed;
}
else {
    self.fade_ratio = 0;

    self.destroyAllMessages();
}

//height = msg_count*msg_height + (msg_count + 1)*content_spacing;
self.bg_alpha = min(1, self.fade_ratio);
self.border_alpha = self.bg_alpha;


// SIZE AND POSITION UPDATE
if (resize) {
    my_draw_set_font(self.msg_font);
    self.width = 0;

    for (var i = 0; i < self.msg_count; i += 1) {
        var msg_item = self.msg_list[| i];
        var item_width = 0;

        if (is_string(msg_item)) {
            item_width = string_width(msg_item);
        }
        else if (instance_exists(msg_item)) {
            for (var ii = 0; ii < msg_item.content_length; ii++) {
                if (msg_item.type[? ii] == "text") {
                    item_width += string_width(msg_item.content[? ii]);
                }
                else if (msg_item.type[? ii] == "icon") {
                    item_width += sprite_get_width(msg_item.content[? ii]);
                }

                if (msg_item.type[? ii] != "blank" && ii < msg_item.content_length - 1) {
                    item_width += self.content_spacing;
                }
            }

            msg_item.width = item_width;
        }

        self.width = max(self.width - 2 * self.content_spacing, item_width) + 2 * self.content_spacing;
    }

    if (self.my_player == gamemode_obj.environment) {
        if (gamemode_obj.player_count == 1 || gamemode_obj.single_cam) {
            self.x = singleton_obj.current_width * 3 / 4 - self.width / 2 - 16;
            self.y = singleton_obj.current_height - self.height - camera_obj.border_width - 1 - self.msg_height - 80;
        }
        else {
            self.x = singleton_obj.current_width / 2 - self.width / 2;
            self.y = singleton_obj.current_height - self.height - camera_obj.border_width - 1 - self.msg_height - 144;
        }
    }
    else {
        var my_camera = my_player.my_camera;

        if (instance_exists(my_camera)) {
            var offset_set = false;

            if (view_get_visible(my_camera.view)) {
                self.view_x_offset = view_get_xport(my_camera.view);
                self.view_y_offset = view_get_yport(my_camera.view);

                offset_set = true;
            }

            if (!offset_set) {
                self.view_x_offset = view_get_xport(0) + (view_get_wport(0) / 2) * (my_camera.view - 1);
                self.view_y_offset = view_get_yport(0);
            }

            self.x = view_get_wport(my_camera.view) / 2 - self.width / 2 + self.view_x_offset - 1;
            self.y = my_camera.border_width + 64 + self.view_y_offset - 1;

            if (gamemode_obj.player_count == 1) {
                self.x = singleton_obj.current_width * 3 / 4 - self.width / 2 - 16;
                //y += 48; // for the time window
            }
        }
    }
}
