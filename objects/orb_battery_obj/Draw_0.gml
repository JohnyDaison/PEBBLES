var cur_y = y-step-hover_offset;

draw_sprite_ext(sprite_index,0, x, cur_y, 1,1,image_angle, tint, bg_alpha*fade_counter*image_alpha);
draw_sprite_ext(sprite_index,1, x, cur_y, 1,1,image_angle, red_tint, colors_alpha*fade_counter*image_alpha);
draw_sprite_ext(sprite_index,2, x, cur_y, 1,1,image_angle, green_tint, colors_alpha*fade_counter*image_alpha);
draw_sprite_ext(sprite_index,3, x, cur_y, 1,1,image_angle, blue_tint, colors_alpha*fade_counter*image_alpha);
draw_sprite_ext(sprite_index,4, x, cur_y, 1,1,image_angle, c_white, fade_counter*image_alpha);

event_inherited();
