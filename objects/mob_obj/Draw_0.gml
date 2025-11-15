if (!self.custom_sprite) {
    draw_sprite_ext(self.sprite_index, self.image_index, self.x + self.x_offset, self.y + self.y_offset, self.image_xscale, self.image_yscale, self.image_angle, self.tint, self.alpha_ratio * self.image_alpha);
}

event_inherited();
