my_draw_set_font(font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(fade_ratio);
draw_set_color(tint-c_gray);
my_draw_text(x-1,y-1,str);
my_draw_text(x+1,y+1,str);
draw_set_color(tint);
my_draw_text(x,y,str);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

event_inherited();
