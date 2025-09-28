/// @description  BEFORE VIEW
if (self.view > -1 && view_enabled) {
    if (self.on && view_get_visible(self.view)) {
        // RE-CREATE VIEW SURFACE
        if (self.camera_ready && !surface_exists(self.view_surface)) {
            self.view_surface = surface_create(self.surface_width, self.surface_height);
            view_set_surface_id(self.view, self.view_surface);
        }

        // DARKNESS
        if (view_current == self.view && self.darkness_alpha > 0) {
            var camera = view_get_camera(self.view);
            self.light_x_offset = -camera_get_view_x(camera);
            self.light_y_offset = -camera_get_view_y(camera);
            self.surface_width = camera_get_view_width(camera);
            self.surface_height = camera_get_view_height(camera);
            self.light_size_coef = self.darkness_light_size_coef;

            if (!surface_exists(self.darkness_surface)) {
                self.darkness_surface = surface_create(self.surface_width, self.surface_height);
            } else {
                surface_resize(self.darkness_surface, self.surface_width, self.surface_height);
            }

            // draw darkness surface
            surface_set_target(self.darkness_surface);

            draw_set_color(merge_color(c_white, c_black, self.darkness_alpha));
            draw_set_alpha(1);
            draw_rectangle(0, 0, self.surface_width, self.surface_height, false);

            with (self.bg_light) {
                event_perform(ev_draw, 0);
            }
            with (self.main_light) {
                event_perform(ev_draw, 0);
            }

            surface_reset_target();

            // draw darkness to view surface
            gpu_set_blendmode_ext(bm_dest_color, bm_zero);

            draw_surface_ext(self.darkness_surface, -self.light_x_offset, -self.light_y_offset, 1, 1, 0, c_white, 1);

            gpu_set_blendmode(bm_normal);
        }

        self.light_x_offset = 0;
        self.light_y_offset = 0;
        self.light_size_coef = 1;

        // CAMERA BEFORE VIEW
        if (self.view > 1 && view_current == self.view - 1) {
            camera_before_view();
        }
    }
}
