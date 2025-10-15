if (singleton_obj.paused) {
    exit;
}

/// STATE STARTS, ORBIT BEHAVIOURS, WALL AND SLIME DRAIN
if (self.color_added && (self.sprite_index != color_slot_appear || self.invisible)) {
    self.invisible = false;
    //self.visible = true;
    self.sprite_index = color_slot_appear;
    self.image_speed = 0.4;
    self.image_index = 0;
    self.size_coef = 1;

    if (!instance_exists(self.orbit_anchor) && instance_exists(self.my_guy) && (object_is_ancestor(self.my_guy.object_index, guy_obj) || self.my_guy.object_index == charge_ball_obj)) {
        self.orbit_anchor = self.my_guy.id;
    }
}

if (self.color_held && self.sprite_index != color_slot) {
    self.sprite_index = color_slot;
}

if (self.color_consumed) {
    self.color_held = false;

    if (self.sprite_index != color_slot_disappear) {
        self.sprite_index = color_slot_disappear;
        //self.image_index = 0;
        self.image_speed = 1;
    }

    if (instance_exists(self.orbit_anchor)) {
        self.my_distance = (self.orbit_anchor.orb_dist) * (1 - (self.image_index / self.image_number));
    }

    if (object_is_ancestor(self.my_guy.object_index, guy_obj)) {
        if (self.my_guy.abi_triggered || self.my_guy.charging) {
            self.image_index = self.image_number - 2 * self.image_speed;
        }
    }
}

if (!instance_exists(self.my_guy)) {
    instance_destroy();
    show_debug_message("ERROR: ORB DIED OF LONELINESS!!!");
    exit;
}

// ORBITING
if (instance_exists(self.orbit_anchor)) {
    var xx, yy;

    self.my_distance = self.orbit_anchor.orb_dist;
    self.base_size = self.orbit_anchor.orb_base_size;

    if (!self.invisible) {
        if (object_is_child(self.orbit_anchor, guy_obj)) {
            if (self.orbit_anchor.has_tped) {
                self.x += self.orbit_anchor.x - self.orbit_anchor.pre_tp_x;
                self.y += self.orbit_anchor.y - self.orbit_anchor.pre_tp_y;
            }
        }

        xx = self.orbit_anchor.x + (cos(self.my_angle) * self.my_distance);
        yy = self.orbit_anchor.y - sin(self.my_angle) * self.my_distance;

        self.direction = point_direction(self.x, self.y, xx, yy);
        self.speed = 0.5 * point_distance(self.x, self.y, xx, yy);
    }
    else {
        self.x = self.orbit_anchor.x + (cos(self.my_angle) * self.my_distance);
        self.y = self.orbit_anchor.y - sin(self.my_angle) * self.my_distance;
        speed = 0;
    }
}
else {
    self.x = self.my_guy.x;
    self.y = self.my_guy.y;
}

if (self.my_guy == self.id) {
    self.cur_y = self.y - self.step - self.hover_offset;
    self.light_yoffset = -self.step - self.hover_offset;
}
else {
    self.cur_y = self.y;
    self.light_yoffset = 0;
}

// ORB-ORB INTERACTIONS
if (!self.invisible && self.sprite_index != no_sprite && self.my_color > 0 && instance_exists(self.orbit_anchor)) {
    // GUY
    if (object_is_ancestor(self.orbit_anchor.object_index, guy_obj)) {
        with (color_orb_obj) {
            // how the fuck could have "other" been "antenna_obj" here??
            if (self.id != other.id && self.orbit_anchor == other.orbit_anchor && !self.invisible && self.sprite_index != no_sprite && self.my_guy != self.id) {
                // LIGHTNING
                if (self.my_color > g_dark) // !other.draw_lightning && 
                {
                    if (self.lightning_target != other.id && self.my_color != other.my_color) {
                        with (other) {
                            var dist = point_distance(self.x, self.y, other.x, other.y);

                            if (dist < 96 && !self.invisible && self.sprite_index != no_sprite) {
                                self.draw_lightning = true;
                                self.lightning_target = other.id;
                                self.lightning_x = other.x;
                                self.lightning_y = other.y;
                                self.lightning_color = self.my_guy.potential_color;
                                other.receives_lightning = true;
                            }
                        }
                    }
                }

                // RESONANCE
                /*
                if(my_color == other.my_color)
                {
                    with(other)
                    {
                        resonance_level += 0.5;
                    }
                }
                */
            }
        }

        // EXTRA ENERGY DISTRIBUTION
        if (self.orbit_anchor.channeling) {
            var orb_count = ds_list_size(self.orbit_anchor.color_slots);

            if (orb_count > 1) {
                for (var i = 0; i < orb_count; i++) {
                    var orb = self.orbit_anchor.color_slots[| i];

                    if (!is_undefined(orb) && instance_exists(orb) && orb.id != self.id && orb.my_color == self.my_color) {
                        if (self.energy > 1 && orb.energy < 1) {
                            var diff = self.energy - orb.energy;

                            if (diff >= 2 * self.distribution_step) {
                                orb.direct_input_buffer += self.distribution_step;
                                self.energy -= self.distribution_step;
                            }
                        }
                    }
                }
            }
        }

    }
    // CHARGE BALL
    else if (self.orbit_anchor.object_index == charge_ball_obj) {
        // LIGHTNING
        if (self.my_color > 0 && self.orbit_anchor.charging) // !other.draw_lightning && 
        {
            var dist = point_distance(self.x, self.y, self.orbit_anchor.x, self.orbit_anchor.y);

            if (dist < 96 && !self.invisible && self.sprite_index != no_sprite) {
                self.draw_lightning = true;
                self.lightning_target = self.orbit_anchor.id;
                self.lightning_x = self.orbit_anchor.x;
                self.lightning_y = self.orbit_anchor.y;
                self.lightning_color = self.my_color;
                //self.orbit_anchor.receives_lightning = true;
            }
        }

        // EXTRA ENERGY DISTRIBUTION
        var orb_count = ds_list_size(self.orbit_anchor.orbs);

        if (orb_count > 1) {
            for (var i = 0; i < orb_count; i++) {
                var orb = self.orbit_anchor.orbs[| i];

                if (!is_undefined(orb) && instance_exists(orb) && orb.id != self.id && orb.my_color == self.my_color) {
                    if (self.energy > 1 && orb.energy < 1) {
                        var diff = self.energy - orb.energy;

                        if (diff >= 2 * self.distribution_step) {
                            orb.direct_input_buffer += self.distribution_step;
                            self.energy -= self.distribution_step;
                        }
                    }
                }
            }
        }

    }
}

// OBJECT DRAIN
if (instance_exists(self.drained_object)) {
    var stop_drain = false;

    /*
    if(!(self.drained_object.my_color & self.my_color))
    {
        stop_drain = true;
    }
    */

    var drain_efficiency = self.min_drain_efficiency;
    if (self.energy < self.base_energy) {
        drain_efficiency = self.max_drain_efficiency;
    }

    if (!stop_drain) {
        if (self.drained_object.object_index == wall_obj) {
            if (self.holographic == self.drained_object.holographic) {
                if (self.drained_object.energy > self.drain_energy_step) {
                    self.drained_object.energy -= self.drain_energy_step;
                    self.energy += drain_efficiency * self.drain_energy_step;
                }
                else if (self.drained_object.energy > 0) {
                    self.energy += drain_efficiency * self.drained_object.energy;
                    self.drained_object.energy = 0;
                    self.drained_object.my_next_color = g_dark;

                    stop_drain = true;
                }
            }
        }
        else if (self.drained_object.object_index == slime_mob_obj) {
            if (self.holographic == self.drained_object.holographic) {
                if (self.drained_object.energy > self.drain_energy_step) {
                    self.drained_object.energy -= self.drain_energy_step;
                    self.energy += drain_efficiency * self.drain_energy_step;
                }
                else {
                    stop_drain = true;
                }
            }
        }
    }

    if (stop_drain) {
        self.drained_object = noone;
        self.alarm[6] = self.drain_quick_update_delay;
    }
}
// DRAINED OBJECT DESTROYED
else if (self.drained_object != noone) {
    self.drained_object = noone;
    self.alarm[6] = self.drain_quick_update_delay;
}


// RESONANCE
/*
if(resonance_level == 0 || draw_lightning)
{
    temp = 0;
    resonance_step = 0;
    resonance_size_boost = 1;
}
else
{
    var temp = arctan((resonance_step/resonance_cycle - 0.5)*10)/arctan(5);
    resonance_size_boost = 1 + (resonance_level + (temp+1)/2) *resonance_size_coef;
    resonance_step += resonance_stepdir;
    if(resonance_step <= 0)
    {
        resonance_stepdir = 1;
    }
    if(resonance_step >= resonance_cycle)
    {
        resonance_stepdir = -1;
    }
}
*/

self.size = self.base_size * self.size_coef * (0.2 + 0.8 * self.energy / self.base_energy); // * resonance_size_boost

// PARTICLES

if (!self.invisible) {
    part_type_colour1(self.part_type, self.tint);
    part_type_size(self.part_type, 0, self.size, -0.025, 0);
    part_type_alpha1(self.part_type, self.holo_alpha);
    part_particles_create(self.part_system, self.x, self.cur_y, self.part_type, 1);
}

event_inherited();
