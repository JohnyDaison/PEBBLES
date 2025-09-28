draw_set_alpha(1);

if (instance_exists(self.charge_ball)) {
    var dir = point_direction(self.x, self.y, self.charge_ball.x, self.charge_ball.y);
    draw_sprite_ext(cannon_barrel2_spr, self.barrel_anim_index,
        self.x + lengthdir_x(self.barrel_dist, dir),
        self.y + lengthdir_y(self.barrel_dist, dir),
        1, 1, dir, self.charge_ball.tint, 0.9);
}

draw_set_colour(c_white);
draw_sprite(self.sprite_index, 0, self.x, self.y);
draw_sprite_ext(self.sprite_index, 1, self.x, self.y, 1, 1, 0, DB.colormap[? shot_color], 1);

draw_set_colour(c_white);
draw_sprite(platform_spr, 0, self.x, self.y + 40);

// HP
if (self.damage < self.hp) {
    var hp_ratio = (self.hp - self.damage) / self.hp;
    var hpbar_xx = self.hpbar_x1 + hp_ratio * self.hpbar_width;

    // BG
    draw_set_colour(c_dkgray);
    draw_rectangle(self.x + self.hpbar_x1, self.y + self.hpbar_y1, self.x + self.hpbar_x2, self.y + self.hpbar_y2, false);

    // BAR
    draw_set_colour(self.hpbar_tint);
    draw_rectangle(self.x + self.hpbar_x1, self.y + self.hpbar_y1, self.x + hpbar_xx, self.y + self.hpbar_y2, false);

    // COVER
    draw_sprite(cannon_hpbar_cover_spr, 0, self.x, self.y);
}

event_inherited();
