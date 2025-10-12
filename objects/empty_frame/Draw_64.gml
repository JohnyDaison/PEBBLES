/// @description  DRAW FRAME 

var debug = false;

if (self.keep_inside) {
    self.border_width = 0;
    
    if (instance_exists(main_camera_obj)) {
        self.border_width = main_camera_obj.border_width;
    }
    
    var minX = self.border_width;
    var maxX = singleton_obj.current_width - self.width - self.border_width;
    var minY = self.border_width;
    var maxY = singleton_obj.current_height - self.height - self.border_width;

    self.x = clamp(self.x, minX, maxX);
    self.y = clamp(self.y, minY, maxY);
}

//self.offset_x = self.x + self.view_x_offset;
//self.offset_y = self.y + self.view_y_offset;
self.window_axis = self.x + self.width / 2;

if (self.focused || self.nonfocusable) {
    self.focus_modifier = 1;
}
else {
    self.focus_modifier = 0.5;
}

// BG
draw_set_alpha(self.alpha * self.bg_alpha * self.focus_modifier);
if (self.draw_bg_color) {
    draw_set_color(self.bg_color);
    draw_roundrect(self.x, self.y, self.x + self.width, self.y + self.height, false);
}

// BORDER
draw_set_alpha(self.alpha * self.border_alpha * self.focus_modifier);
if (self.draw_border) {
    draw_set_color(self.border_color);
    //gpu_set_blendmode(bm_subtract); 
    draw_roundrect(self.x, self.y, self.x + self.width, self.y + self.height, true);
    //gpu_set_blendmode(bm_normal);
    if (self.focused && self.content_focused == -1) {
        draw_set_color(self.border_highlight_color);
        //gpu_set_blendmode(bm_subtract); 
        draw_roundrect(self.x, self.y, self.x + self.width, self.y + self.height, true);
    }
}

// HEADING
if (self.draw_heading) {
    draw_set_alpha(self.alpha * self.focus_modifier);
    draw_set_color(self.color);
    my_draw_set_font(self.font);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    my_draw_text(self.window_axis, self.y + self.heading_offset, self.text);
}

// debug
if (debug) {
    draw_text(self.x + 100, self.y + 100, string(self.depth));
}
