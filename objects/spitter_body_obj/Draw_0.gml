draw_sprite_ext(sprite_index,0, x+x_offset,y+y_offset, image_xscale,image_yscale,image_angle, tint, alpha_ratio*image_alpha);
draw_sprite_ext(sprite_index,1, x+x_offset,y+y_offset, image_xscale,image_yscale,image_angle, gun_tint, alpha_ratio*image_alpha);
/*
draw_set_color(c_red);
draw_set_alpha(1);
draw_text(x,y, debug_str);
*/
event_inherited();
//draw_sprite(sprite_index, image_index, x, y);
/*
hp_str = string(ceil( (hp-damage)*100 ));
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
*/

// debug
/*
draw_set_color(c_red);
if(instance_exists(attack_target))
{
    draw_line(x,y-5, attack_target.x, attack_target.y + 5);   
}

draw_set_color(c_yellow);
if(instance_exists(follow_target))
{
    draw_line(x,y+ 5, follow_target.x, follow_target.y - 5);   
}
*/