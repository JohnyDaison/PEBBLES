/// @description  BEAM UPDATE
if (instance_exists(self.my_ball)) {
    self.x = self.my_ball.x;
    self.y = self.my_ball.y;
    //self.facing_right = self.my_guy.facing_right;
}

ds_list_clear(self.beam_nodes);

var last_obj = self.my_holder;

if (!instance_exists(self.my_holder)) {
    last_obj = self.my_ball;
}

// ADD LAST OBJ
if (instance_exists(last_obj))
    ds_list_add(self.beam_nodes, last_obj.id);
else {
    instance_destroy();
    exit;
}

// FACING
self.updateFacing();

// BEAM EDGES
var beam_top = self.y - self.beam_small_core_size / 2;
var beam_bottom = self.y + self.beam_small_core_size / 2;

if (self.beam_head_fired) {
    beam_top = self.y - self.beam_big_core_size / 2;
    beam_bottom = self.y + self.beam_big_core_size / 2;
}

var beam_point = last_obj.x;
var beam = self;

self.endpoint_reached = false;
self.collided = false;

while (!self.endpoint_reached) {
    var step_resolved = false;

    var shields_found = 0;
    var shields = [noone];
    var correct_shield = noone;

    var walls_found = 0;
    var walls = [noone];
    var correct_wall = noone;

    // SHIELDS
    with (shield_obj) {
        var shield = self;

        if (shield.id != last_obj && shield.my_color == beam.my_color &&
            sign(shield.x - beam_point) == beam.facing &&
            shield.y + shield.radius > beam_top &&
            shield.y - shield.radius < beam_bottom) {
                shields[shields_found] = self.id;
                shields_found += 1;
        }
    }
    //show_debug_message("found shields: "+string(shields_found));

    if (shields_found == 1) {
        correct_shield = shields[0];
    }
    else if (shields_found > 1) {
        var closest_x = self.facing * room_width;

        for (var i = 0; i < shields_found; i += 1) {
            var shield = shields[i];

            if (sign(closest_x - (shield.x - self.facing * shield.radius)) == self.facing) {
                closest_x = shield.x - self.facing * shield.radius;
                correct_shield = shield;
            }
        }
    }

    // WALLS
    with (terrain_obj) {
        if (self.object_index != grate_block_obj) {
            if (sign(self.x - beam_point) == beam.facing && self.y + 32 > beam_top && y < beam_bottom) {
                walls[walls_found] = self.id;
                walls_found += 1;
            }
        }
    }
    //show_debug_message("found walls: "+string(walls_found));

    if (walls_found == 1) {
        correct_wall = walls[0];
    }
    else if (walls_found > 1) {
        var closest_x = self.facing * room_width;

        for (var i = 0; i < walls_found; i += 1) {
            var wall = walls[i];

            if (sign(closest_x - wall.x) == self.facing) {
                closest_x = wall.x;
                correct_wall = wall;
            }
        }
    }

    // FINALIZING
    //show_debug_message("final");
    if (correct_wall != noone && correct_shield != noone && !step_resolved) {
        if (sign(correct_shield.x - correct_wall.x) == self.facing) {
            ds_list_add(self.beam_nodes, correct_wall);

            self.endpoint_reached = true;
            self.collided = true;

            step_resolved = true;
        }
    }

    if (correct_shield != noone && !step_resolved) {
        if (ds_list_find_index(self.beam_nodes, correct_shield) == -1) {
            ds_list_add(self.beam_nodes, correct_shield);

            self.facing *= -1;
            collided = true;

            beam_point = correct_shield.x + facing * correct_shield.radius;
            last_obj = correct_shield;
            step_resolved = true;
        }
        else {
            ds_list_add(self.beam_nodes, correct_shield);

            self.endpoint_reached = true;
            collided = true;

            step_resolved = true;
        }
    }

    if (correct_wall != noone && !step_resolved) {
        ds_list_add(self.beam_nodes, correct_wall);

        self.endpoint_reached = true;
        self.collided = true;

        step_resolved = true;
    }

    if (correct_wall == noone && correct_shield == noone && !step_resolved) {
        self.endpoint_reached = true;
        step_resolved = true;
    }
}

self.beam_head_node_changed = true;
self.invalid = false;
self.alarm[0] = self.beam_update_delay;
