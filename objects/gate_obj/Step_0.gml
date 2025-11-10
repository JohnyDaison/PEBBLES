if (!instance_exists(self.my_block)) {
    exit;
}

// COPY BLOCK COLOR ON CHANGE
if (self.my_last_color != self.my_block.my_color && self.my_color != self.my_block.my_color) {
    self.my_color = self.my_block.my_color;

    if (self.my_last_color == g_nothing || self.my_color == g_octarine) {
        self.my_last_color = self.my_color;
    }
    self.tint_updated = false;
}

// WHILE STABLE
if (self.tint_updated && self.my_last_color == self.my_block.my_color) {
    for (var sideIndex = 0; sideIndex < 4; sideIndex++) {
        if (!instance_exists(self.field[? sideIndex])) {
            continue;
        }

        var other_gate = self.field[? sideIndex].my_gates[? sideIndex];

        if (!instance_exists(other_gate) || other_gate.my_block.object_index != wall_obj) {
            continue;
        }

        var other_block = other_gate.my_block;

        if (self.my_block.energy > other_block.energy
            && self.my_block.energy >= (DB.terrain_config[? "active_threshold"] + self.transfer_packet_size)) {
            self.my_block.energy -= self.transfer_packet_size;
            other_block.direct_input_buffer += self.transfer_packet_size;

            if (other_block.my_color == g_dark) {
                other_block.my_next_color = self.my_block.my_next_color;
            }
        }
    }
}

if (self.my_last_color != self.my_color) {
    // AT COLOR CHANGE START
    if (self.desired_disc_angle == 0
        && self.my_color > g_dark && self.my_color < g_white
        && self.my_last_color > g_dark && self.my_last_color < g_white) {
        var old_dir = DB.colordirs[? self.my_last_color];
        var new_dir = DB.colordirs[? self.my_color];
        var rotation = ((round(new_dir - old_dir + 2) mod 4) +4) mod 4 - 2;

        self.desired_disc_angle = rotation * 90;
        self.rotation_acc = self.rotation_acc_coef * sqr(rotation);
    }

    // WHEN COLOR CHANGE FINISHES
    if (self.tint_updated && self.my_color > g_dark && self.my_color < g_white) {
        if (self.my_last_color > g_dark && self.my_last_color < g_white) {
            // EXECUTE COMMAND
            var old_dir = DB.colordirs[? self.my_last_color];
            var new_dir = DB.colordirs[? self.my_color];
            self.rotate_by += ((round(new_dir - old_dir + 2) mod 4) +4) mod 4 - 2;
        }

        // DISCARD COLOR
        self.my_last_color = self.my_color;
        self.my_color = g_dark;
        self.tint_updated = false;
    }
}

// DISC ROTATION
var angle_diff = angle_difference(self.desired_disc_angle, self.disc_angle);
var reverse_coef = 1;

if (abs(self.rotation_speed) > 0) {
    var too_fast = abs(2 * angle_diff / self.rotation_speed) <= abs(self.rotation_speed / self.rotation_acc);
    var wrong_direction = sign(angle_diff) != sign(self.rotation_speed);

    if (too_fast && !wrong_direction) {
        reverse_coef = -0.25;
    }

    if (wrong_direction) {
        reverse_coef = 1.5;
    }
}

var current_acc = reverse_coef * self.rotation_acc;
var stop_limit = abs(current_acc);

if (abs(angle_diff) <= stop_limit && abs(self.rotation_speed) <= stop_limit) {
    self.rotation_speed = 0;
    self.disc_angle = self.desired_disc_angle;
} else {
    self.rotation_speed += current_acc * sign(angle_diff);
    self.disc_angle += self.rotation_speed;
}

// RESET FIELDS
if (abs(self.rotate_by) > 0) {
    for (var sideIndex = 0; sideIndex < 4; sideIndex++) {
        if (instance_exists(self.field[? sideIndex])) {
            instance_destroy(self.field[? sideIndex]);
        }
    }
}

// ROTATE
var rotate_failed = false;
var orig_rotate_by = self.rotate_by;
var done = false;

while (!done) {
    while (self.rotate_by != 0) {
        if (self.rotate_by > 0) {
            var orig_last_active = self.active[? 3];

            for (var sideIndex = 3; sideIndex > 0; sideIndex--) {
                self.active[? sideIndex] = self.active[? sideIndex - 1];
            }

            self.active[? 0] = orig_last_active;
            self.rotate_by--;
        }

        if (self.rotate_by < 0) {
            var orig_first_active = self.active[? 0];

            for (var sideIndex = 0; sideIndex < 3; sideIndex++) {
                self.active[? sideIndex] = self.active[? sideIndex + 1];
            }

            self.active[? 3] = orig_first_active;
            self.rotate_by++;
        }

        self.has_rotated = true;
    }

    rotate_failed = false;

    for (var sideIndex = 0; sideIndex < 4; sideIndex++) {
        if (self.active[? sideIndex] && !self.enabled[? sideIndex]) {
            rotate_failed = true;
            self.has_rotated = false;
        }
    }

    if (rotate_failed) {
        self.rotate_by = -orig_rotate_by;
        self.desired_disc_angle = 0;
    }
    else {
        if (self.desired_disc_angle != 0) {
            self.disc_angle -= orig_rotate_by * 90;
            self.desired_disc_angle = 0;
        }

        done = true;
    }
}

// MANAGE FIELDS
var has_field = false;

for (var sideIndex = 0; sideIndex < 4; sideIndex++) {
    var inv = (sideIndex + 2) mod 4; // inverted

    if (!self.enabled[? sideIndex] || !self.active[? sideIndex]) {
        continue;
    }

    if (instance_exists(self.field[? sideIndex])) {
        has_field = true;

        continue;
    }

    var found = false;

    with (gate_obj) {
        if (other.id == self.id) {
            continue;
        }

        if (!self.enabled[? inv] || !self.active[? inv] || instance_exists(self.field[? inv])) {
            continue;
        }

        var hor = false;
        var vert = false;
        var width = 0;
        var height = 0;

        //horizontal
        if (sideIndex mod 2 == 0 && self.y == other.y) {
            var dir = sign(self.x - other.x);

            // same dir
            if (dir == -sideIndex + 1) {
                if (!collision_line(other.x + dir * 16, other.y, self.x - dir * 16, self.y, gate_blocking_terrain_obj, false, false)) {
                    width = abs(self.x - other.x) - 32;
                    hor = true;
                    found = true;
                }
            }
        }
        //vertical
        else if (sideIndex mod 2 == 1 && self.x == other.x) {
            var dir = sign(self.y - other.y);

            // same dir
            if (dir == sideIndex - 2) {
                if (!collision_line(other.x, other.y + dir * 16, self.x, self.y - dir * 16, gate_blocking_terrain_obj, false, false)) {
                    height = abs(self.y - other.y) - 32;
                    vert = true;
                    found = true;
                }
            }
        }

        if (!found) {
            continue;
        }

        var field_inst = instance_create(ceil((self.x + other.x) / 2) + 1, ceil((self.y + other.y) / 2) + 1, gate_field_obj);

        self.field[? inv] = field_inst;
        other.field[? sideIndex] = field_inst;

        if (self.my_player == other.my_player) {
            field_inst.my_player = self.my_player;
        }

        field_inst.my_gates[? inv] = other.id;
        field_inst.my_gates[? sideIndex] = self.id;

        field_inst.horizontal = hor;
        field_inst.vertical = vert;

        if (width > 0) {
            field_inst.width = width;
        }

        if (height > 0) {
            field_inst.height = height;
        }

        field_inst.radius = max(width, height);
        break;
    }
}

if (self.my_color == g_dark && has_field) {
    self.my_color = g_white;
    self.tint_updated = false;
}
else if (self.my_color == g_white && !has_field) {
    self.my_color = g_dark;
    self.tint_updated = false;
}

// RECALCULATE TINTS
if (!self.has_rotated) {
    exit;
}

for (var sideIndex = 0; sideIndex < 4; sideIndex++) {
    var list = self.tints[? sideIndex];
    ds_list_clear(list);

    if (!self.enabled[? sideIndex]) {
        continue;
    }

    if (self.active[? sideIndex]) {
        ds_list_add(list, DB.colormap[? g_white]);
    }
    else if (self.my_last_color <= g_dark || self.my_last_color >= g_white) {
        ds_list_add(list, DB.colormap[? g_dark]);
    }
    else {
        for (var ii = 0; ii < 4; ii++) {
            if (!self.active[? ii]) {
                continue;
            }

            for (var col = g_red; col <= g_cyan; col++) {
                if (col == self.my_last_color)
                    continue;

                var dir_diff = (sideIndex - ii + 4) mod 4;
                var col_diff = round(DB.colordirs[? col] - DB.colordirs[? self.my_last_color] + 4) mod 4;

                if (dir_diff == col_diff) {
                    ds_list_add(list, DB.colormap[? col]);
                }
            }
        }
    }
}

self.has_rotated = false;
