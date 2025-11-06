if ((self.my_color != other.my_color || self.my_color == g_octarine) || (self.xstart == self.x && self.ystart == self.y)) {
    self.collided = true;

    if (!self.wallhit_played) {
        my_sound_play(shot_wallhit_sound, false, self.sound_volume);
        self.wallhit_played = true;
    }
}

if (!self.bounced && !self.collided) {
    var orig_x = self.x;
    var orig_y = self.y;

    self.x_return = self.xprevious - orig_x;
    self.y_return = self.yprevious - orig_y;

    var h_diff = self.xprevious - (other.x + other.obj_center_xoff);
    var v_diff = self.yprevious - (other.y + other.obj_center_yoff);

    var h_bounced = false;
    var v_bounced = false;

    self.orig_speed = self.speed;

    self.speed_delta = (other.energy / other.bounce_threshold - 1) * other.bounce_speedchange_ratio;
    self.energy_delta = self.speed_delta * -other.bounce_speedenergy_ratio;
    self.last_wall_hit = other.id;

    if (abs(h_diff) <= 16 || abs(v_diff) <= 16) {
        if (abs(v_diff) >= abs(h_diff)) {
            if (sign(v_diff) == -sign(self.vspeed)) // abs(hspeed) > abs(vspeed) && 
            {
                self.vspeed *= -1;
                self.bounced = true;
                v_bounced = true;
                self.corner_bounced = false;
                //show_debug_message("vert bounce");
            }
        }

        if (abs(h_diff) >= abs(v_diff)) {
            if (sign(h_diff) == -sign(self.hspeed)) // abs(hspeed) < abs(vspeed) && 
            {
                self.hspeed *= -1;
                self.bounced = true;
                h_bounced = true;
                self.corner_bounced = false;
                //show_debug_message("hor bounce");
            }
        }
    }
    else {
        h_diff -= sign(h_diff) * 12;
        v_diff -= sign(v_diff) * 12;

        //show_debug_message("corner h_diff: "+string(h_diff));
        //show_debug_message("corner v_diff: "+string(v_diff));

        var normal_size = point_distance(0, 0, h_diff, v_diff);
        var coef = self.speed / normal_size;

        //show_debug_message("coef: "+string(coef));

        self.hchange = coef * h_diff;
        self.vchange = coef * v_diff;

        self.corner_bounced = true;
        //show_debug_message("corner bounce found");
    }

    if (self.bounced) {
        var bounce_coef = max(0, 1 - self.wall_bounce_damping);

        if (self.orig_speed + self.speed_delta > 0.2) {
            self.speed = self.orig_speed + self.speed_delta;

            if (self.holographic == other.holographic) {
                other.energy += self.energy_delta;
            }
        }

        if (h_bounced && v_bounced) {
            self.speed *= bounce_coef;
        } else if (h_bounced) {
            self.hspeed *= bounce_coef;
        } else if (v_bounced) {
            self.vspeed *= bounce_coef;
        }

        if (abs(self.hspeed) <= 0.1 && h_bounced) {
            self.hspeed = 0;
        }

        if (abs(self.vspeed) <= self.gravity_coef && v_bounced) {
            self.vspeed = 0;
            self.gravity = 0;
        }

        if (self.speed > self.stopped_threshold) {
            my_sound_play_colored(shot_bounce_sound, self.my_color, false, self.sound_volume);
        }
    }
    else {
        if (!self.corner_bounced) {
            self.collided = true;

            if (!self.wallhit_played) {
                my_sound_play(shot_wallhit_sound, false, self.sound_volume);
                self.wallhit_played = true;
            }
        }
    }
}

if (self.collided && self.holographic == other.holographic) {
    var power_ratio = get_power_ratio(self.my_color, other.my_color);

    if (power_ratio != 0) {
        var body_dmg = self.force * power_ratio;

        other.scale_buffer += body_dmg;
        other.my_next_color = self.my_color;
        other.damage += body_dmg;

        if (!(other.color_locked && other.my_color == g_dark)) {
            other.energy += abs(body_dmg);
        }

        other.last_dmg = body_dmg;

        with (other) {
            last_attacker_update(other.id, "body", "damage");
        }

        if ((body_dmg > 1.5 || (other.unstable && body_dmg > 0.5)) && other.cover != cover_indestr) {
            other.falling = true;
        }

        self.impact_strength = body_dmg;

        if (body_dmg != 0) {
            create_damage_popup(body_dmg, self.my_color, other.id);
        }
    }
}
