draw_set_color(c_white);
draw_sprite(sprite_index,image_index,x,y);
draw_sprite_ext(jump_pad_top_spr,1,x,y,1,jump_power/max_power,0,self.tint,image_alpha);
draw_sprite_ext(jump_pad_top_spr,0,x,y,1,1,0,self.tint,image_alpha);

event_inherited();
