if (!gamemode_obj.limit_reached && instance_exists(self.my_guy) && sprite_index != no_sprite && self.my_color != -1 && self.display_exhaustion_ratio > 0) {
    if (self.my_guy != self.id && !object_is_ancestor(self.my_guy.object_index, turret_obj) && self.my_guy.my_player != gamemode_obj.environment) {
        var xx, yy, scale = 1;
        
        var camera = self.my_guy.my_player.my_camera;
        if (main_camera_obj.on) {
            camera = main_camera_obj.id;
        }
        
        var camera_found = instance_exists(camera);
        if (!camera_found) {
            exit;
        }
        
        // POSITION
        if (self.my_guy.object_index == cannon_base_obj) {
            scale = 0.4;
            xx = self.my_guy.gui_x;
            yy = self.my_guy.gui_y + 24;
        } else {
            scale = camera.zoom_level;
            
            var viewCamera = view_get_camera(camera.view);
            var viewX = camera_get_view_x(viewCamera);
            var viewY = camera_get_view_y(viewCamera);
            
            var portX = view_get_xport(camera.view);
            var portY = view_get_yport(camera.view);
            
            xx = floor((self.my_guy.x - viewX) * camera.zoom_level + portX);
            yy = floor((self.my_guy.y - viewY) * camera.zoom_level + portY);
        }
        
        self.bar_dist = (self.base_radius * 0.5 + 16) * scale;
        
        // SIZE
        var base_charge = max(self.charge_step, self.max_charge + self.overcharge) * self.display_exhaustion_ratio;
        var base_bar_width = floor(scale * base_charge * 60);
        
        var left_border = floor(xx - base_bar_width / 2);
        var right_border = floor(xx + base_bar_width / 2);
        var top_border = floor(yy + self.bar_dist);
        var bottom_border = floor(yy + self.bar_dist + self.bar_height);

        // COLOR
        var bg_color, border_color;
        
        if (self.my_color == g_dark) {
            bg_color = self.light_bg_color;
            border_color = self.light_bg_color;
        }
        else if (self.my_color == g_white) {
            bg_color = self.dark_bg_color;
            border_color = self.dark_bg_color;
        }
        else {
            bg_color = self.dark_bg_color;
            border_color = self.light_bg_color;
        }
        
        // DRAW
        draw_set_color(bg_color);
        draw_rectangle(left_border, top_border, right_border, bottom_border, false);
        
        var bar_width = floor((self.charge / base_charge) * base_bar_width);
        draw_set_color(self.base_bar_color);
        draw_rectangle(left_border, top_border, left_border + bar_width, bottom_border, false);
        
        draw_set_color(border_color);
        draw_rectangle(left_border, top_border, right_border, bottom_border, true);
        
        my_draw_set_font(label_font);
        //draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        //my_draw_text(left_border, bottom_border, string(chargerate));
        
        if (self.autofire) {
            draw_set_color(c_white);
            draw_set_halign(fa_center);
            my_draw_text(left_border + base_bar_width, bottom_border, "A");
        }
    }
}
