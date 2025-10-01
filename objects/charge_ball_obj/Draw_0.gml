draw_sprite_ext(charge_ball2_spr, image_index, x, y, image_xscale, image_yscale, image_angle, self.glow_tint, image_alpha * self.holo_alpha);
//draw_sprite_ext(charge_ball3_highlight,image_index,x,y,sprite_size,sprite_size,0,c_white,image_alpha*0.5);

if (instance_exists(self.my_guy) && (self.charging || self.firing)) {
    draw_set_color(self.glow_tint);
    draw_set_alpha(self.lightning_alpha);

    var start_x = self.my_guy.x + self.center_offset_x;
    var start_y = self.my_guy.y + self.center_offset_y;

    draw_lightning_width(start_x, start_y, self.x, self.y,
        2 * self.lightning_width * charge, self.lightning_steps, self.lightning_thickness);
}

event_inherited();
