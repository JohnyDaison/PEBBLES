for (var sideIndex = 0; sideIndex < 4; sideIndex++) {
    if (self.enabled[? sideIndex]) {
        var xx = 1, xcor = 0,
            yy = 1, ycor = 0;

        if (sideIndex == 1) {
            ycor = 1;
        }
        else if (sideIndex == 2) {
            xcor = 1;
        }

        if (sideIndex > 1) {
            xx = -1;
        }

        var sprite = gate_enabled_spr;
        var cur_tint = DB.colormap[? g_dark];

        if (self.active[? sideIndex]) {
            sprite = gate_active_spr;
            cur_tint = DB.colormap[? g_white];
        }

        if (!self.tint_updated) {
            sprite = gate_changing_spr;
        }

        var cover_tint = DB.colormap[? g_dark];
        
        if (instance_exists(self.my_block)) {
            cover_tint = self.my_block.tint;
        }

        draw_sprite_ext(sprite, 0, self.x + xcor, self.y + ycor, xx, yy, sideIndex mod 2 * 90, cover_tint, 1);
        draw_sprite_ext(sprite, 1, self.x + xcor, self.y + ycor, xx, yy, sideIndex mod 2 * 90, cur_tint, 1);
    }
}

draw_sprite_ext(gate_disc_spr, 0, self.x, self.y, 1, 1, 0, self.disc_tint, self.disc_alpha);

draw_sprite_ext(gate_axle_spr, 0, self.x, self.y, 1, 1, 0, self.tint, 1);

for (var sideIndex = 0; sideIndex < 4; sideIndex++) {
    if (self.active[? sideIndex]) {
        var xx = lengthdir_x(self.dot_distance, sideIndex * 90 + self.disc_angle);
        var yy = lengthdir_y(self.dot_distance, sideIndex * 90 + self.disc_angle);
        var dot_tint = DB.colormap[? g_white];

        draw_sprite_ext(gate_dot_spr, 0, self.x + xx, self.y + yy, 1, 1, 0, dot_tint, 1);
    }
}

event_inherited();
