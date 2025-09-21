if (self.sprite_index == no_sprite) {
    self.sprite_index = black_aoe;
    self.image_index = 0;
    self.image_speed = 0.5;
    self.image_alpha = 0.8;
}
else {
    if (self.my_guy != noone) {
        self.x = self.my_guy.x;
        self.y = self.my_guy.y;
    }

    if (self.image_index + self.image_speed < self.image_number)
        draw_sprite_ext(self.sprite_index, self.image_index, self.x, self.y, 1, 1, 0, c_ltgray, self.image_alpha);
    else
        instance_destroy();
}

event_inherited();
