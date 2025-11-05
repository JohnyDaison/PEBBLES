for (var dir = 0; dir < 4; dir++) {
    if (!self.enabled[? dir]) {
        continue;
    }

    var xx = 1, xcor = 0;
    var yy = 1, ycor = 0;

    if (dir == 1) {
        ycor = 1;
    }
    else if (dir == 2) {
        xcor = 1;
    }

    if (dir > 1) {
        xx = -1;
    }

    draw_sprite_ext(self.sprite_index, self.image_index, self.x + xcor, self.y + ycor, xx, yy, (dir mod 2) * 90, self.tint, 1);

    draw_set_colour(self.lightning_tint);
    draw_set_alpha(self.lightning_alpha);

    var list = self.drain_target_list[? dir];
    var count = ds_list_size(list);

    var hdir = 0;
    var vdir = 0;

    if (dir mod 2 == 0) {
        hdir = -(dir - 1);
    }
    else {
        vdir = (dir - 2);
    }


    for (var i = 0; i < count; i++) {
        var target = list[| i];

        if (!instance_exists(target)) {
            continue;
        }

        var dist = point_distance(self.x + hdir * self.drain_point_dist, self.y + vdir * self.drain_point_dist, target.x, target.y);

        draw_lightning_width(self.x + hdir * self.drain_point_dist, self.y + vdir * self.drain_point_dist,
                    target.x, target.y,
                    self.lightning_width, self.lightning_steps * dist / self.grid_size, self.lightning_thickness);
    }

    draw_set_alpha(1);
}

event_inherited();
