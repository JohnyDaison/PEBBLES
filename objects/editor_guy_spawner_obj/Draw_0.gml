draw_set_color(c_white);
draw_sprite(sprite_index,image_index,x,y);

my_draw_set_font(big_font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_black);
my_draw_text(x+1,y+1,string_hash_to_newline(string(player_number)));

draw_set_color(c_yellow);
my_draw_text(x,y,string_hash_to_newline(string(player_number)));

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);


action_inherited();
