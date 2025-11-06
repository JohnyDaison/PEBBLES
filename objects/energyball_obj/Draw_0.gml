draw_sprite_ext(self.sprite_index, self.image_index, self.x, self.y, 1, 1, self.direction, self.tint, (0.4 + min(1, self.force) * 0.4) * self.holo_alpha);

draw_sprite_ext(self.sprite_index, self.image_index, self.x, self.y, 0.6, 0.6, self.direction, merge_color(c_white, self.tint, 0.1), (0.3 + min(1.5, self.force) * 0.3) * self.holo_alpha);

event_inherited();
