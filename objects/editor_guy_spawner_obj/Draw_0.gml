draw_set_color(c_white);
draw_sprite(self.sprite_index, self.image_index, self.x, self.y);

my_draw_set_font(big_font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_black);
my_draw_text(self.x + 1, self.y + 1, string(self.player_number));

draw_set_color(c_yellow);
my_draw_text(self.x, self.y, string(self.player_number));

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);


event_inherited();
