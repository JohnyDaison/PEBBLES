///@description COLLAPSE, PARTICLES, POSITION, SIZE

// COLLAPSE
if (self.charge > self.threshold) {
    if (instance_exists(self.my_guy)) {
        if (object_is_ancestor(self.my_guy.object_index, guy_obj)) {
            with (self.my_guy) {
                self.charging = false;
                status_left[? "frozen"] += 30;
                spec_effect_to_guy(other.charge, "damage");
            }
        }

        // IMPLOSION
        if (self.my_color == g_dark) {
            var inst = instance_create(self.x, self.y, black_aoe_obj);
            inst.my_player = self.my_guy.my_player;
            inst.force = self.charge / 2;
            inst.my_color = self.my_color;
            inst.my_guy = inst.id;
            inst.my_source = self.object_index;
        }
        // EXPLOSION
        else {
            var inst = instance_create(self.x, self.y, slot_explosion_obj);
            inst.my_color = self.my_color;
            inst.my_player = self.my_guy.my_player;
            inst.my_guy = self.my_guy;
            inst.my_source = self.object_index;
            inst.holographic = self.holographic;

            if (self.my_guy != id) {
                self.my_guy.lost_control = true;
                self.my_guy.front_hit = true;
                if (self.rel_x != 0)
                    self.my_guy.hspeed -= (self.radius / self.rel_x) * self.charge;
                if (self.rel_y != 0)
                    self.my_guy.vspeed -= (self.radius / self.rel_y) * self.charge;
            }
        }
    }
    self.charge = 0;
}


// PARTICLES, POSITION, SIZE
self.sprite_size = self.size_coef * (0.25 + 0.50 * self.charge / self.max_charge);

if (instance_exists(self.my_guy) && self.sprite_index != no_sprite && self.my_color != -1) {
    if (self.desired_dist > 0) {
        var desired_rel_x = self.rel_x;

        self.visual_rel_x = lerp(self.visual_rel_x, desired_rel_x, self.rest_ratio);
    } else if (self.cur_dist < self.centered_dist) {
        var rest_rel_x = self.my_guy.facing * self.rest_x_offset;
        var desired_rel_x = rest_rel_x;

        if (is_my_guy_los_blocked(self.visual_rel_x, self.rel_y)) {
            self.visual_rel_x -= lengthdir_x(5, point_direction(0, 0, self.visual_rel_x, self.rel_y));
        } else {
            var next_visual_rel_x = lerp(self.visual_rel_x, desired_rel_x, self.rest_ratio);

            if (!is_my_guy_los_blocked(next_visual_rel_x, self.rel_y)) {
                self.visual_rel_x = next_visual_rel_x;
            }
        }
    }

    self.x = self.my_guy.x + self.center_offset_x + self.visual_rel_x;
    self.y = self.my_guy.y + self.center_offset_y + self.rel_y;
}

self.image_xscale = self.sprite_size;
self.image_yscale = self.sprite_size;
self.radius = self.base_radius * self.sprite_size;
self.orb_dist = self.radius;

part_emitter_region(self.system, self.em,
    self.x - self.radius, self.x + self.radius,
    self.y - self.radius, self.y + self.radius,
    ps_shape_ellipse, ps_distr_gaussian);
part_emitter_burst(self.system, self.em, self.pt, power(ceil(self.sprite_size), 2));

event_inherited();
