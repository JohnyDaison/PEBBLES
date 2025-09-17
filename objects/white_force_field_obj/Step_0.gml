event_inherited();

switch (shape) {
    case shape_circle:

        with (guy_obj) {
            with (other) {
                var guy = collision_circle(self.x, self.y, self.radius, other.id, false, true);

                if (instance_exists(guy)) {
                    if (guy.id != my_guy) {
                        if (guy.has_tped) {
                            guy.x = guy.pre_tp_x;
                            guy.y = guy.pre_tp_y;
                            guy.last_x = guy.x;
                            guy.last_y = guy.y;
                            guy.has_tped = false;
                        }
                        else {
                            apply_force(guy, self.repels);
                        }
                    }
                }
            }
        }

        with (projectile_obj) {
            with (other) {
                var proj = collision_circle(self.x, self.y, self.radius, other.id, false, true);

                if (instance_exists(proj)) {
                    apply_force(proj, self.repels, true);
                }
            }
        }

        with (aoe_obj) {
            with (other) {
                var aoe = collision_circle(self.x, self.y, self.radius, other.id, false, true);

                if (instance_exists(aoe)) {
                    apply_force(aoe, self.repels, true);
                }
            }
        }

        with (black_projectile_obj) {
            with (other) {
                if (point_distance(self.x, self.y, other.x, other.y) < (self.radius + other.radius)) {
                    apply_force(other, self.repels, true);
                }
            }
        }

        with (sprinkler_body_obj) {
            with (other) {
                if (point_distance(self.x, self.y, other.x, other.y) < (self.radius + other.radius)) {
                    apply_force(other, self.repels, true);
                }
            }
        }

        break;


    case shape_rect:

        var left_x = round(self.x - self.width / 2);
        var right_x = round(self.x + self.width / 2);
        var top_y = round(self.y - self.height / 2);
        var bottom_y = round(self.y + self.height / 2);

        with (guy_obj) {
            with (other) {
                var guy = collision_rectangle(left_x, top_y, right_x, bottom_y, other.id, false, true);

                if (instance_exists(guy)) {
                    if (guy.id != my_guy) {
                        if (guy.has_tped) {
                            guy.x = guy.pre_tp_x;
                            guy.y = guy.pre_tp_y;
                            guy.last_x = guy.x;
                            guy.last_y = guy.y;
                            guy.has_tped = false;
                        }
                        else {
                            apply_force(guy, self.repels);
                        }
                    }
                }
            }
        }

        with (projectile_obj) {
            with (other) {
                var proj = collision_rectangle(left_x, top_y, right_x, bottom_y, other.id, false, true);

                if (instance_exists(proj)) {
                    apply_force(proj, self.repels, true);
                }
            }
        }

        with (aoe_obj) {
            with (other) {
                var aoe = collision_rectangle(left_x, top_y, right_x, bottom_y, other.id, false, true);

                if (instance_exists(aoe)) {
                    apply_force(aoe, self.repels, true);
                }
            }
        }

        with (black_projectile_obj) {
            with (other) {
                self.x_dist = abs(self.x - other.x);
                self.y_dist = abs(self.y - other.y);

                if ((self.x_dist < self.width / 2 + other.radius) &&
                    (self.y_dist < self.height / 2 + other.radius)) {
                    apply_force(other, self.repels, true);
                }
            }
        }

        with (sprinkler_body_obj) {
            with (other) {
                self.x_dist = abs(self.x - other.x);
                self.y_dist = abs(self.y - other.y);

                if ((self.x_dist < self.width / 2 + other.radius) &&
                    (self.y_dist < self.height / 2 + other.radius)) {
                    apply_force(other, self.repels, true);
                }
            }
        }

        break;

}
