//draw_set_color(c_white);
//draw_sprite(sprite_index,direction/90,x,y);
draw_sprite_ext(self.sprite_index, self.image_index, floor(self.x), floor(self.y), 1, 1, self.image_angle, merge_color(self.tint, c_white, 0.5), 1);

event_inherited();
