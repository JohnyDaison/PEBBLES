if (self.max_force > 0) {
    var alpha = min(1, self.force / self.max_force) * 0.6 * self.holo_alpha;
    draw_sprite_ext(self.sprite_index, self.image_index, self.x, self.y, self.scale, self.scale, 0, self.tint, alpha);

    draw_sprite_ext(self.sprite_index, self.image_index, self.x, self.y, 0.6 * self.scale, 0.6 * self.scale,
                    0, merge_color(c_white, self.tint, 0.1), alpha);
}

event_inherited();
