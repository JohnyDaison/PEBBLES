if (!instance_exists(self.my_block)) {
    if (self.my_block != noone) {
        instance_destroy();
    }

    exit;
}

var block_color = self.my_block.my_next_color;
var update_potential_targets = true;
var update_targets = true;
var do_drain = true;
var has_target = false;

// UPDATE POTENTIAL TARGETS
if (update_potential_targets) {
    chunks_content(self.potential_targets, chunkgrid_obj.id, self.chunkgrid_x - 1, self.chunkgrid_y - 1,
        self.chunkgrid_x + 1, self.chunkgrid_y + 1, true);
    ds_list_clear(self.potential_drain_rods);

    var count = ds_list_size(self.potential_targets);

    // FILTER THE LIST
    for (var i = count - 1; i >= 0; i--) {
        var target = self.potential_targets[| i];

        if (is_undefined(target) || !instance_exists(target)) {
            ds_list_delete(self.potential_targets, i);
            continue;
        }

        if (point_distance(target.x, target.y, self.x, self.y) > self.radius) {
            ds_list_delete(self.potential_targets, i);
            continue;
        }

        if (ds_list_find_index(self.drainables, target.object_index) == -1) {
            ds_list_delete(self.potential_targets, i);
            continue;
        }

    }

    update_targets = true;
}

// UPDATE ACTUAL TARGETS
if (update_targets) {
    var count = ds_list_size(self.potential_targets);
    ds_list_clear(self.potential_drain_rods);

    // UPDATE POTENTIAL DRAIN RODS
    for (var i = 0; i < count; i++) {
        var target = self.potential_targets[| i];
        self.potential_drain_rods[| i] = -1;
        var nearest_dist = -1;

        for (var dir = 0; dir < 4; dir++) {
            self.nearest_drain_target[? i] = noone;

            if (!self.enabled[? dir]) {
                continue;
            }

            var xx = 0;
            var yy = 0;

            if (dir mod 2 == 0) {
                xx = -(dir - 1) * self.drain_point_dist;
            }
            else {
                yy = (dir - 2) * self.drain_point_dist;
            }

            var dist = point_distance(self.x + xx, self.y + yy, target.x, target.y);

            if (dist <= range && target.energy > self.energy_tick && (self.potential_drain_rods[| i] == -1 || nearest_dist > dist)) {
                self.potential_drain_rods[| i] = dir;
                nearest_dist = dist;
            }
        }
    }

    // RESET NEAREST TARGETS
    for (var dir = 0; dir < 4; dir++) {
        self.nearest_drain_target[? dir] = noone;
    }

    has_target = false;

    // FIND NEAREST VALID TARGETS
    for (var i = 0; i < count; i++) {
        var target = self.potential_targets[| i];
        var dir = self.potential_drain_rods[| i];
        var is_nearest = false;

        if (dir != -1 && (target.my_color & block_color || block_color == g_dark)) {
            var xx = 0;
            var yy = 0;

            if (dir mod 2 == 0) {
                xx = -(dir - 1) * self.drain_point_dist;
            }
            else {
                yy = (dir - 2) * self.drain_point_dist;
            }

            var dist = point_distance(self.x + xx, self.y + yy, target.x, target.y);

            if (instance_exists(self.nearest_drain_target[? dir])) {
                var nearest = self.nearest_drain_target[? dir];

                if (point_distance(self.x + xx, self.y + yy, nearest.x, nearest.y) > dist) {
                    is_nearest = true;
                }

            }
            else {
                is_nearest = true;
            }

            if (is_nearest) {
                self.nearest_drain_target[? dir] = target;
            }

            has_target = true;
        }
    }

    // CLEAR THE ACTUAL DRAIN TARGETS
    for (var dir = 0; dir < 4; dir++) {
        var list = self.drain_target_list[? dir];

        ds_list_clear(list);
    }

    if (has_target) {
        // DECIDE ON NEW COLOR IF DARK
        if (block_color == g_dark) {
            // EITHER COMBINE COLORS OF NEAREST TARGETS
            for (var dir = 0; dir < 4; dir++) {
                var target = self.nearest_drain_target[? dir];

                if (instance_exists(target)) {
                    if (target.my_color == g_octarine) {
                        block_color = target.my_color;
                        break;
                    }
                    else {
                        block_color = block_color & target.my_color;
                    }
                }
            }

            // IF THAT FAILED JUST TAKE THE FIRST NON-DARK COLOR
            if (block_color == g_dark) {
                for (var i = 0; i < count; i++) {
                    var target = self.potential_targets[| i];
                    var dir = self.potential_drain_rods[| i];

                    if (dir != -1 && target.my_color > g_dark) {
                        block_color = target.my_color;
                        break;
                    }
                }
            }

            self.my_block.my_next_color = block_color;
        }

        // ASSIGN THE ACTUAL DRAIN TARGETS
        for (var i = 0; i < count; i++) {
            var target = self.potential_targets[| i];
            var dir = self.potential_drain_rods[| i];

            if (dir != -1 && (target.my_color & block_color)) {
                var list = self.drain_target_list[? dir];

                ds_list_add(list, target);
            }
        }
    }

}

// DRAIN THE ENERGY
if (do_drain) {
    for (var dir = 0; dir < 4; dir++) {
        var list = self.drain_target_list[? dir];
        var count = ds_list_size(list);

        for (var i = 0; i < count; i++) {
            var target = list[| i];

            if (instance_exists(target)) {
                if (target.object_index == color_orb_obj) {
                    //available_energy = min(self.energy_tick, target.energy);

                    if (target.energy > self.energy_tick) {
                        target.energy -= self.energy_tick;
                        self.my_block.direct_input_buffer += self.energy_tick;
                    }
                }
                else if (target.object_index == slime_mob_obj) {
                    var available_energy = min(self.energy_tick, target.energy);

                    if (available_energy > 0) {
                        target.energy -= available_energy;
                        self.my_block.direct_input_buffer += available_energy;
                    }
                }
                else if (target.object_index == shield_obj) {
                    target.charge -= self.energy_tick;
                    self.my_block.direct_input_buffer += self.energy_tick;
                }
            }
        }
    }
}

self.my_color = block_color;
self.tint_updated = false;
self.lightning_tint = self.tint;
