my_draw_set_font(little_font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(1);
draw_set_color(tint-c_gray);
energy_str = string(round(100*energy));
my_draw_text(x-1,y-1,string_hash_to_newline(energy_str));
my_draw_text(x+1,y+1,string_hash_to_newline(energy_str));
draw_set_color(tint);
my_draw_text(x,y,string_hash_to_newline(energy_str));
draw_set_halign(fa_left);
draw_set_valign(fa_top);

action_inherited();
