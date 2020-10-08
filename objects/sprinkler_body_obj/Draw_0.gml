draw_sprite_ext(sprite_index,0, x+x_offset,y+y_offset, image_xscale,image_yscale,image_angle, body_tint, alpha_ratio*image_alpha);

event_inherited();
//draw_sprite(sprite_index, image_index, x, y);

// TODO: this should go to GUI, but needs x,y recalculated
var hp_str = string(ceil( (hp-damage)*100 ));

draw_set_alpha(alpha_ratio);
my_draw_set_font(label_font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
my_draw_text(x-1, y-1, hp_str);
my_draw_text(x+1, y+1, hp_str);
draw_set_color(c_black);
my_draw_text(x, y, hp_str);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

