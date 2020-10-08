event_inherited();

draw_set_color(c_yellow);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
my_draw_set_font(score_font);

draw_set_alpha(self.alpha*1);

my_draw_text(x+16,y+16, string(fps));
my_draw_text(x+32,y+48, string(round(fps_real)));

my_draw_text(x+80,y+16, string(round(average_fps)));
my_draw_text(x+96,y+48, string(round(average_fps_real)));