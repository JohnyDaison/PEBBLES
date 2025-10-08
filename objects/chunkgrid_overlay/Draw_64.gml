event_inherited();

draw_set_halign(fa_left);
draw_set_valign(fa_top);
my_draw_set_font(ter_font);

draw_set_color(c_dkgray);
my_draw_text(self.x + 9, self.y + 9, self.heading);
draw_set_color(c_white);
my_draw_text(self.x + 8, self.y + 8, self.heading);

for (var yy = 0; yy < self.grid_height; yy += 1) {
    draw_set_color(c_dkgray);
    my_draw_text(self.x + 9, self.y + 48 + (yy * 32) + 9, self.ter_text[yy]);
    draw_set_color(c_white);
    my_draw_text(self.x + 8, self.y + 48 + (yy * 32) + 8, self.ter_text[yy]);
}
