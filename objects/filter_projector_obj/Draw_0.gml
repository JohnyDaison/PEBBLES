//draw_set_color(c_white);
//draw_sprite(sprite_index,direction/90,x,y);
draw_sprite_ext(sprite_index,image_index,floor(x),floor(y),1,1,image_angle, merge_colour(tint, c_white, 0.5), 1);

event_inherited();
