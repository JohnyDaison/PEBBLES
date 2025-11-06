/// @description WALLHIT RESOLUTION, ORB-ORB FORCE, FALLING START

// EXPLODE
if (self.collided) {
    if (!self.shield_hit) {
        var explo = instance_create(self.x, self.y, slot_explosion_obj);
        explo.my_color = self.my_color;
        explo.my_player = self.my_player;
        explo.my_guy = explo;
        explo.my_source = self.object_index;
        explo.fire_projectiles = false;
        explo.create_sparks = false;
        explo.energy = self.force;
        explo.holographic = self.holographic;
    }

    instance_destroy();
    exit;
}


// BOUNCE
if (self.bounced || self.corner_bounced) {
    self.x += self.x_return;
    self.y += self.y_return;
}

if (place_free(self.x, self.y)) {
    self.bounced = false;
}


// COLOR ATTRACTION/REPULSION
with (energyball_obj) {
    if (self.id != other.id && self.object_index != slime_ball_obj && self.holographic == other.holographic) {
        var dist = point_distance(self.x, self.y, other.x, other.y);

        if (dist > 0 && dist < self.weak_force_range) {
            var dir = point_direction(self.x, self.y, other.x, other.y);

            if (dist < self.strong_force_range)
                dist = 2 * (dist - self.strong_force_range / 2);

            if (dist < 0)
                dist = (dist - self.strong_force_range) * (self.weak_force_range / self.strong_force_range);

            if (dist != 0) {
                /*
                if(abs(dist) < 0.1)
                   dist = sign(dist)*0.1;
                   */

                var ratio = get_power_ratio(other.my_color, self.my_color);

                if (other.my_color == self.my_color) {
                    motion_add(dir, sign(dist) * min(0.15 * other.radius / abs(dist / 2), other.radius / 2));  //-0.015*other.radius/sqrt(abs(dist/2))
                }
                else {
                    motion_add(dir + 180, 0.1 * ratio * other.radius / (dist * (2 - ratio)));
                }
            }
        }
    }
}

var on_terrain = place_meeting(self.x, self.y + 1, solid_terrain_obj);

if (on_terrain) {
    self.friction = self.orig_friction * self.ground_friction_multiplier;
} else {
    self.friction = self.orig_friction;
}

// FALLING START IF STOPPED
if (self.speed <= self.stopped_threshold) {
    self.was_stopped = true;
    self.sitting_on_terrain = on_terrain;

    if (self.sitting_on_terrain) {
        self.speed = 0;
        self.gravity = 0;

        if (instance_exists(self.col_group)) {
            self.col_group.sitting_on_terrain = true;
        }
    }
}
else {
    self.sitting_on_terrain = false;
}

if (self.was_stopped && !on_terrain) {
    self.gravity = self.gravity_coef;

    if (self.speed <= self.stopped_threshold) {
        var ball = instance_place(self.x, self.y, energyball_obj);

        if (instance_exists(ball) && ball.speed < ball.stopped_threshold) {
            if (abs(self.x - ball.x) <= 1) {
                self.x += choose(-2, 2);
            }

            if (ball.y > self.y && ball.sitting_on_terrain) {
                self.speed = 0;
                self.gravity = 0;
            }
        }

        if (instance_exists(self.col_group) && self.col_group.sitting_on_terrain) {
            self.speed = 0;
            self.gravity = 0;
        }
    }
}


// LIGHT BOOST
self.ambient_light = self.orig_ambient_light * self.light_boost;
self.direct_light = self.orig_direct_light * self.light_boost;
self.light_boost = 1;


// GATE BOUNCE
if (!self.gate_bounced) {
    self.gate_bounce_count = 0;
}

self.gate_bounced = false;


// EMIT PARTICLES
part_emitter_region(self.system, self.em, self.x - self.radius, self.x + self.radius, self.y - self.radius, self.y + self.radius, ps_shape_ellipse, ps_distr_linear);

event_inherited();
