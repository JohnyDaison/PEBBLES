draw_sprite_ext(black_bolt_spr, self.image_index, self.x, self.y, 1, 1, 0, c_white, self.image_alpha);
draw_sprite_ext(black_bolt_highlight, self.image_index, self.x, self.y, 1, 1, 0, self.tint, self.highlight_alpha);
self.facing = 0;

event_inherited();
