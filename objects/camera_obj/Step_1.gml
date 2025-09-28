/// @description FOLLOW AND ZOOM
if (self.on && self.view != -1) {
    //show_debug_message("CAMERA "+string(view)+" ON");
    var last_zoom_level = self.zoom_level;
    var camera = view_get_camera(self.view);
    var view_x = camera_get_view_x(camera);
    var view_y = camera_get_view_y(camera);
    var view_width = camera_get_view_width(camera);
    var view_height = camera_get_view_height(camera);

    // FOLLOW GUY
    if (self.follow_guy && instance_exists(self.my_guy)) {
        self.followed_x = self.my_guy.x + self.my_guy.hspeed;
        self.followed_y = self.my_guy.y + self.my_guy.vspeed;
        self.box_xoffset = -2 * self.my_guy.hspeed;
        self.box_yoffset = -2 * self.my_guy.vspeed;

        //speed_threshold = my_guy.running_maxspeed +1;
        //speed_threshold = 10;
        var speed_threshold = DB.max_jump_pad_power;

        var ratio;
        if (self.my_guy.object_index != place_holder_obj && self.my_guy.max_speed > 0) {
            ratio = clamp((self.speed - speed_threshold) / speed_threshold, 0, 1);
        }
        else {
            ratio = 0;
        }

        var desired_zoom = lerp(self.normal_zoom, self.min_zoom, ratio);
        var dir = sign(desired_zoom - self.zoom_level);
        if (self.stop_zoom) {
            dir = 0;
        }

        self.zoom_level = clamp(self.zoom_level + dir * self.zoom_speed, self.min_zoom, self.normal_zoom);

        if (self.my_guy.wanna_look) {
            if (self.my_guy.hor_dir_held) {
                self.box_xoffset = -self.my_guy.facing * self.guy_hor_dist;
            }
            if (self.my_guy.looking_up) {
                self.box_yoffset = self.guy_ver_dist;
            }
            if (self.my_guy.looking_down) {
                self.box_yoffset = -self.guy_ver_dist;
            }

            var delayed_start = self.my_guy.look_start + self.look_zoom_delay * singleton_obj.game_speed;
            var current_step = self.my_guy.step_count - delayed_start;
            var zoom_steps = self.look_zoom_duration * singleton_obj.game_speed;
            ratio = clamp(current_step / zoom_steps, 0, 1);
            desired_zoom = lerp(self.normal_zoom, self.look_zoom, ratio);

            self.zoom_level = desired_zoom;

            if (self.my_guy.aim_dist > 0) {
                self.followed_x += lengthdir_x(self.guy_hor_dist, self.my_guy.aim_dir);
                self.followed_y += lengthdir_y(self.guy_ver_dist, self.my_guy.aim_dir);
            }
        }

    }

    // FOLLOW SPAWNER

    if (self.follow_spawner && instance_exists(self.my_spawner)) {
        self.followed_x = my_spawner.x;
        self.followed_y = my_spawner.y;
        self.box_xoffset = 0;
        self.box_yoffset = 0;

        var dir = sign(self.normal_zoom - self.zoom_level);
        if (self.stop_zoom) {
            dir = 0;
        }

        self.zoom_level = clamp(self.zoom_level + dir * self.zoom_speed, self.min_zoom, self.normal_zoom);
    }

    // FOLLOW SHOT
    if (self.follow_shot) {
        if (instance_exists(self.my_shot)) {
            self.followed_x = self.my_shot.x + self.my_shot.hspeed;
            self.followed_y = self.my_shot.y + self.my_shot.vspeed;
            self.box_xoffset = -3 * self.my_shot.hspeed;
            self.box_yoffset = -3 * self.my_shot.vspeed;
            
            if (self.my_guy.max_speed > 0) {
                var ratio = self.speed / self.my_guy.max_speed;
                var desired_zoom = lerp(self.normal_zoom, self.min_zoom, ratio);
                var dir = sign(desired_zoom - self.zoom_level);
                
                self.zoom_level += dir * self.zoom_speed;
            }
            
            if (self.alarm[1] < 0) {
                self.alarm[1] = 300;
            }
        }
        else if (self.my_shot != noone) {
            self.follow_shot = false;
            self.alarm[1] = 20;
        }
    }
    else {
        self.my_shot = noone;
    }

    // FOLLOW OVERRIDE
    if (self.follow_override && instance_exists(self.my_override)) {
        self.followed_x = self.my_override.x;
        self.followed_y = self.my_override.y;
        
        if (self.my_override.object_index == cursor_obj) {
            self.followed_x = self.my_override.room_x;
            self.followed_y = self.my_override.room_y;
        }

        self.box_xoffset = 0;
        self.box_yoffset = 0;

        var dir = sign(self.normal_zoom - self.zoom_level);
        if (self.stop_zoom) {
            dir = 0;
        }

        self.zoom_level = clamp(self.zoom_level + dir * self.zoom_speed, self.min_zoom, self.normal_zoom);
    }

    var half_xsize = self.box_xsize / 2;
    var half_ysize = self.box_ysize / 2;
    var x_margin = view_width / 2 - half_xsize;
    var y_margin = view_height / 2 - half_ysize;

    self.followed_x = clamp(self.followed_x, x_margin, room_width - x_margin);
    self.followed_y = clamp(self.followed_y, y_margin, room_height - y_margin);

    var x_dist = self.followed_x - (self.x + self.box_xoffset);
    var y_dist = self.followed_y - (self.y + self.box_yoffset);

    self.move_speed_x = self.move_speed_coef * x_dist;
    self.move_speed_y = self.move_speed_coef * y_dist;


    // BOX CHECK
    self.hspeed = 0;
    if (abs(x_dist) > half_xsize) {
        if (abs(x_dist - self.move_speed_x) > half_xsize) {
            if ((x_dist < 0 && view_x > 0) ||
                (x_dist > 0 && view_x < room_width - view_width))
                self.hspeed = self.move_speed_x;
        }
        else {
            self.x = self.followed_x - self.box_xoffset - sign(x_dist) * half_xsize;
        }
    }

    self.vspeed = 0;
    if (abs(y_dist) > half_ysize) {
        if (abs(y_dist - self.move_speed_y) > half_ysize) {
            if ((y_dist < 0 && view_y > 0) ||
                (y_dist > 0 && view_y < room_height - view_height))
                self.vspeed = self.move_speed_y;
        }
        else {
            self.y = self.followed_y - self.box_yoffset - sign(y_dist) * half_ysize;
        }
    }

    var zoom_changed = last_zoom_level != self.zoom_level;

    // APPLY CHANGES
    if (view_enabled) {
        if (camera_get_view_target(camera) != self.id) {
            camera_set_view_target(camera, self.id);
            update_display();
        }

        if (zoom_changed) {
            update_display();
        }

        var old_x = self.x;
        var old_y = self.y;

        view_x = self.x - view_width / 2;
        view_y = self.y - view_height / 2;

        view_x = clamp(view_x, 0, room_width - view_width);
        view_y = clamp(view_y, 0, room_height - view_height);

        camera_set_view_pos(camera, view_x, view_y);

        self.x = view_x + view_width / 2;
        self.y = view_y + view_height / 2;

        self.stop_zoom = false;

        if (old_x != self.x) {
            self.hspeed = 0;
        }

        if (old_x != self.x && (view_x == 0 || (view_x + view_width) >= room_width)) {
            self.stop_zoom = true;
            self.shake_dist = 0;
        }

        if (old_y != self.y) {
            self.vspeed = 0;
        }

        if (old_y != self.y && (view_y == 0 || (view_y + view_height) >= room_height)) {
            self.stop_zoom = true;
            self.shake_dist = 0;
        }

        view_set_visible(self.view, true);

        if (self.view == 0 || self.view == 1) {
            camera_before_view();
        }

    }
}

if (!self.on && self.view > -1) {
    view_set_visible(self.view, false);
}
