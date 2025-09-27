event_inherited();
var vortex = id;

with (guy_obj) {
    if (self.holographic == vortex.holographic) {
        var dist = point_distance(self.x, self.y, vortex.x, vortex.y);
        if (self.old_coef == 0) {
            self.old_coef = self.gravity_coef;
        }

        var ubershielded = is_shielded(self.id, "uber");

        if (dist < vortex.radius) {
            if (self.my_player.id != vortex.my_player.id && !self.protected) {
                if (ubershielded) {
                    self.my_shield.charge -= 0.01;
                    my_sound_play(wall_hum_sound);
                    //my_sound_play_colored(wall_hum_sound, my_shield.my_color);
                }
                else if (vortex.force != 0 && self.my_color != g_dark) {
                    // SLOT THEFT
                    /*
                    if(current_slot > 0 && !lost_control && !slots_triggered)
                    {
                        vortex.slot = ds_list_find_value(self.color_slots,0);
                        if(instance_exists(vortex.slot))
                        {
                            if(vortex.slot.color_added || vortex.slot.color_held)
                            {
                                with(vortex.slot)
                                {
                                    color_consumed = false;
                                    color_held = true;
                                    old_guy = my_guy.id;
                                    my_guy = vortex.id;
                                    speed = my_guy.speed;
                                    direction = my_guy.direction;
                                }
                                
                                ds_list_delete(color_slots,0);
                                
                                self.slots_triggered = false;
                                self.current_slot = 0;
                                self.potential_abi_name = "";
                                self.slot_number -= 1;
                                
                                for(i = 0; i < self.slot_number; i += 1)
                                {
                                    slot = ds_list_find_value(self.color_slots,i);
                                    slot.color_added = false;
                                    slot.color_held = false;
                                    slot.color_consumed = false;
                                    slot.sprite_index = no_sprite;
                                }
                                
                                alarm[3] = 1;
                                show_debug_message("Loser!");
                                
                                ds_list_add(vortex.stolen_slots,vortex.slot.id);
                                vortex.slot_count = ds_list_size(vortex.stolen_slots);
                            }
                        }
                    }
                    */

                    // THROWING AROUND

                    var dir = point_direction(self.x, self.y, vortex.x, vortex.y);
                    /*
                    if(dist < vortex.radius/6)
                    {
                        dist = vortex.radius/6;
                    }
                    */
                    var coef = (1 - dist / vortex.radius) * 8 * vortex.force;

                    /*
                    if(vspeed == 0)
                        vspeed = sign(vortex.y-y);
                    */
                    motion_add(dir, coef);

                    if (dist < (vortex.radius / 3) || self.lost_control) {
                        self.lost_control = true;
                        self.hit_handled = false;
                    }

                    if (self.lost_control && !self.hit_handled) {
                        if (sign(lengthdir_x(dist, dir)) != self.facing) {
                            self.back_hit = true;
                        }
                        else {
                            self.front_hit = true;
                        }

                        var params = create_params_map();
                        params[? "who"] = vortex.my_guy;

                        broadcast_event("vortex_knockdown", self.id, params);
                    }

                    last_attacker_update(vortex.id, "body", "dark");
                }
            }
        }
        /*
        // RETURN GRAVITY BACK TO NORMAL
        else if(gravity_coef != old_coef || gravity_direction != 270)
        {
            gravity_direction = 270;
            gravity_coef = old_coef;
            y-=1;
            airborne = false;
        }*/
    }
}


// ATTRACT ORBS
with (color_orb_obj) {
    if (self.holographic == vortex.holographic) {
        if (instance_exists(self.my_guy)) {
            if (self.my_guy.id == self.id) {
                var dist = point_distance(self.x, self.y, vortex.x, vortex.y);

                if (dist < vortex.radius) {
                    self.my_guy = vortex.id;
                    ds_list_add(vortex.stolen_slots, self.id);
                    vortex.slot_count = ds_list_size(vortex.stolen_slots);
                    self.speed = vortex.speed;
                    self.direction = vortex.direction;
                }
            }
        }
    }
}

// ATTRACT ITEMS
with (item_obj) {
    if (self.holographic == vortex.holographic) {
        if (instance_exists(self.my_guy)) {
            if (!is_shielded(self.id) && !self.collected && (
                (self.my_guy.id == self.id && self.collectable) || (self.placed && self.stuck_to == noone)
            )) {
                var dist = point_distance(self.x, self.y, vortex.x, vortex.y);

                if (dist < vortex.radius) {
                    self.my_guy = vortex.id;
                    ds_list_add(vortex.picked_pickups, self.id);
                    vortex.pickup_count = ds_list_size(vortex.picked_pickups);
                    self.speed = vortex.speed;
                    self.direction = vortex.direction;
                }
            }
        }
    }
}

// BOLT ATTRACTION

with (projectile_obj) {
    if (self.holographic == vortex.holographic) {
        if (self.id != vortex.id) {
            var dist = point_distance(self.x, self.y, vortex.x, vortex.y);
            var is_energyball = object_is_ancestor(self.object_index, energyball_obj);
            var max_force = 0;
            var max_dist = 0;

            if (is_energyball) {
                max_force = 0.75;
                max_dist = 256;
            }
            else {
                max_force = 0.5;
                max_dist = 512;
            }

            if (dist > 0 && dist < max_dist) {
                var dir = point_direction(x, y, vortex.x, vortex.y);
                var attr_force = max_force * (1 - max(dist - vortex.radius, 0) / max(max_dist - vortex.radius, 1));

                motion_add(dir, attr_force);
            }
        }
    }
}

// MOB ATTRACTION
with (mob_obj) {
    if (self.holographic == vortex.holographic && vortex.my_color != self.my_color) {
        var dist = point_distance(x, y, vortex.x, vortex.y);
        var max_force = 5;
        var max_dist = 192;

        if (dist > 0 && dist < max_dist) {
            var dir = point_direction(x, y, vortex.x, vortex.y);
            var attr_force = max_force * (1 - max(dist - vortex.radius, 0) / max(max_dist - vortex.radius, 1));

            motion_add(dir, attr_force);

            last_attacker_update(vortex.id, "body", "dark");
        }
    }
}

// RETURN TO SENDER
if (instance_exists(self.my_guy)) {
    var dist = point_distance(self.x, self.y, self.my_guy.x, self.my_guy.y);
    var dir = point_direction(self.x, self.y, self.my_guy.x, self.my_guy.y);

    motion_add(dir, self.gravity_ratio / self.force);

    if (self.gravity_ratio >= self.force) {
        self.speed *= 1 - self.orig_friction;

        if ((dist <= self.return_distance_limit
            && abs(self.hspeed - self.my_guy.hspeed) <= self.return_max_axisdelta
            && abs(self.vspeed - self.my_guy.vspeed) <= self.return_max_axisdelta)
            || self.my_guy.dead) {
            instance_destroy();
        }
    }
}
else {
    instance_destroy();
    exit;
}

// BOLT LIFECYCLE
self.force_step = 0.01 * self.force;
self.force_used += self.force_step;
self.gravity_ratio += self.force_step;
if (self.gravity_ratio > self.force)
    self.gravity_ratio = self.force;

self.trail_delay = self.min_trail_delay +
    clamp(2 - sqr(self.force_used / self.force), 0, 1) * (self.start_trail_delay - self.min_trail_delay);

if (self.alarm[2] > self.trail_delay) {
    self.alarm[2] = self.trail_delay;
}
/*if(self.force_used >= self.force)
{
    instance_destroy();
}*/
