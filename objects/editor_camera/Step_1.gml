if (self.on) {
    var viewCamera = view_get_camera(self.view);
    var half_wview = camera_get_view_width(viewCamera) / 2;
    var half_hview = camera_get_view_height(viewCamera) / 2;

    if (self.pan_mode) {
        var mouse_down = mouse_check_button(mb_left);

        if (mouse_down) {
            if (!self.dragging) {
                self.dragging = true;
                self.orig_x = x;
                self.orig_y = y;
                self.orig_mouse_x = cursor_obj.x;
                self.orig_mouse_y = cursor_obj.y;
            }
            else {
                self.x = self.orig_x - (cursor_obj.x - self.orig_mouse_x);
                self.y = self.orig_y - (cursor_obj.y - self.orig_mouse_y);
                self.x = max(half_wview, min(self.x, place_obj.x + place_obj.width + place_obj.margin - half_wview));
                self.y = max(half_hview, min(self.y, place_obj.y + place_obj.height + place_obj.margin - half_hview));
            }
        }

        if (self.dragging && !mouse_down) {
            self.dragging = false;
        }
    }

    if (!self.inited_view) {
        self.inited_view = true;
        update_display();
    }

    camera_set_view_pos(viewCamera,
        self.x - camera_get_view_width(viewCamera) / 2,
        self.y - camera_get_view_height(viewCamera) / 2
    );
}
