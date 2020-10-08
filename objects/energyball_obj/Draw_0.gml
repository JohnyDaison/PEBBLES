draw_sprite_ext(sprite_index,image_index,x,y,1,1,direction,self.tint,(0.4 + min(1,force)*0.4)*self.holo_alpha);

draw_sprite_ext(sprite_index,image_index,x,y,0.6,0.6,direction,merge_color(c_white,self.tint,0.1), (0.3 + min(1.5,force)*0.3)*self.holo_alpha);

event_inherited();
