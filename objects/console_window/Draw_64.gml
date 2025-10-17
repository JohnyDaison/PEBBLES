self.window_axis = self.x + self.width / 2;

if (self.focused) {
    self.focus_modifier = 1;
}
else {
    self.focus_modifier = 0.5;
}


if (self.draw_bg_color) {
    var x2 = self.x + self.width;
    var y2 = self.y + self.height;

    draw_set_alpha(self.alpha * self.bg_alpha * self.focus_modifier);
    draw_set_color(self.bg_color);
    draw_rectangle(self.x, self.y, x2, y2, false);
}

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
my_draw_set_font(label_font);

my_draw_text(self.x + 1, self.y, string(fps));
my_draw_text(self.x + 64, self.y, string(round(fps_real)));
