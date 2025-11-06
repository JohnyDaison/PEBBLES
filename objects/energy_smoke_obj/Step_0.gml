/// HAS_LEFT_INST, PUFF UP, PUSH OTHER, DECAY
event_inherited();

has_left_step();

// PUFF UP
if (self.scale < 1) {
    self.scale = min(1, self.scale + self.scale_speed);
}

self.radius = self.scale * self.normal_radius;


// PUSH OTHER SMOKE
with (energy_smoke_obj) {
    if (other.id != self.id) {
        var dist = point_distance(other.x, other.y, self.x, self.y);
        var dir = point_direction(other.x, other.y, self.x, self.y);
        var boost = 0.05;
        var coef = 1 - (dist / (2 * self.radius));
        var base_xx = lengthdir_x(coef * boost, dir);
        var base_yy = lengthdir_y(coef * boost, dir);

        var full_xx = lengthdir_x(self.friction + coef * boost, dir);
        var full_yy = lengthdir_y(self.friction + coef * boost, dir);

        if (dist > 0 && dist < 2 * radius
            && !place_meeting(self.x + self.hspeed + 2 * full_xx, self.y + self.vspeed + 2 * full_yy, solid_terrain_obj)) {
            //motion_add(dir, friction + coef*boost);
            self.x += base_xx;
            self.y += base_yy;

            self.hspeed += full_xx;
            self.vspeed += full_yy;

            if (self.speed > self.max_speed) {
                self.speed = self.max_speed;
            }
        }
    }
}

// DECAY
self.force -= self.force_decay;

if (self.force <= 0) {
    instance_destroy();
}
