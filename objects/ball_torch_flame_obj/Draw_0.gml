if (instance_exists(self.my_guy)) {
    draw_sprite_ext(self.my_guy.sprite_index, 0, self.x, self.y, 1, 1, self.my_guy.image_angle, self.my_guy.tint, 0.3);
}

event_inherited();
