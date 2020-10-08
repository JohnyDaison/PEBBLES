if(max_force > 0)
{
    var alpha = min(1,force/max_force)*0.6*self.holo_alpha;
    draw_sprite_ext(sprite_index,image_index, x,y, scale,scale, 0, self.tint, alpha);
    
    draw_sprite_ext(sprite_index,image_index, x,y, 0.6*scale, 0.6*scale,
                    0, merge_color(c_white, self.tint, 0.1), alpha);
}

event_inherited();
