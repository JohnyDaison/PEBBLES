/// @description  ADJUST WIDTH TO MESSAGE
if (self.message != "" && !self.adjusted) {
    my_draw_set_font(big_font);
    self.width = string_width(self.message) + 96;
    self.height = string_height(self.message) + 64;
    self.x = view_get_wport(0) / 2 - self.width / 2;
    self.y = view_get_hport(0) / 2 - self.height / 2;
    self.adjusted = true;
    self.draw_border = true;
    self.draw_bg_color = true;
}

if (self.message == "") {
    self.draw_border = false;
    self.draw_bg_color = false;
}


event_inherited();

/// DRAW MESSAGE
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (self.message != "") {
    my_draw_set_font(big_font);
    // TODO: rewrite this line
    draw_set_color(c_ltgray - self.color);

    var i = 2;
    repeat(2) {
        my_draw_text(self.x + self.width / 2 + i, self.y + self.height / 2 + i, self.message, false);

        draw_set_color(self.color);
        i = 0;
    }
}

if (is_string(self.tip) && self.tip != "") {
    var xCenter = self.x + self.width / 2;
    var yCenter = self.y + self.height + self.tip_offset;
    
    var x1 = self.x + self.tip_margin;
    var y1 = yCenter - floor(self.tip_height / 2) + self.tip_margin;
    var x2 = self.x + self.width - self.tip_margin - 1;
    var y2 = yCenter + ceil(self.tip_height / 2) - self.tip_margin - 1;

    draw_set_color(self.bg_color);
    draw_set_alpha(self.bg_alpha);
    draw_roundrect(x1, y1, x2, y2, false);

    draw_set_alpha(1);
    my_draw_set_font(window_font);

    // TODO: rewrite this line
    draw_set_color(c_ltgray - self.color);

    var i = 2;
    repeat(2) {
        my_draw_text(xCenter + i, yCenter + i, "Tip: " + tip, false);

        draw_set_color(self.color);
        i = 0;
    }
}

// debug
/*
my_draw_set_font(big_font);
draw_set_color(c_white);
my_draw_text(x+width/2, y-height, string(singleton_obj.step_count));
*/
