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

    var shieldSearch = {
        found: 0,
        array: [noone],
        correct: noone
    };
    
    var wallSearch = {
        found: 0,
        array: [noone],
        correct: noone
    };

    // SHIELDS
    with (shield_obj) {
        var shield = self;

        if (shield.id != last_obj && shield.my_color == beam.my_color &&
            sign(shield.x - beam_point) == beam.facing &&
            shield.y + shield.radius > beam_top &&
            shield.y - shield.radius < beam_bottom) {
                shieldSearch.array[shieldSearch.found] = self.id;
                shieldSearch.found += 1;
        }
    }
    //show_debug_message("found shields: "+string(shieldSearch.found));

    if (shieldSearch.found == 1) {
        shieldSearch.correct = shieldSearch.array[0];
    }
    else if (shieldSearch.found > 1) {
        var closest_x = self.facing * room_width;

        for (var i = 0; i < shieldSearch.found; i += 1) {
            var shield = shieldSearch.array[i];
            var shieldEdgeX = shield.x - self.facing * shield.radius;

            if (sign(closest_x - shieldEdgeX) == self.facing) {
                closest_x = shieldEdgeX;
                shieldSearch.correct = shield;
            }
        }
    }

    // WALLS
    with (terrain_obj) {
        if (self.object_index != grate_block_obj) {
            if (sign(self.x - beam_point) == beam.facing && self.y + 32 > beam_top && self.y < beam_bottom) {
                wallSearch.array[wallSearch.found] = self.id;
                wallSearch.found += 1;
            }
        }
    }
    //show_debug_message("found walls: "+string(wallSearch.found));

    if (wallSearch.found == 1) {
        wallSearch.correct = wallSearch.array[0];
    }
    else if (wallSearch.found > 1) {
        var closest_x = self.facing * room_width;

        for (var i = 0; i < wallSearch.found; i += 1) {
            var wall = wallSearch.array[i];

            if (sign(closest_x - wall.x) == self.facing) {
                closest_x = wall.x;
                wallSearch.correct = wall;
            }
        }
    }

    // FINALIZING
    //show_debug_message("final");
    if (wallSearch.correct != noone && shieldSearch.correct != noone && !step_resolved) {
        if (sign(shieldSearch.correct.x - wallSearch.correct.x) == self.facing) {
            ds_list_add(self.beam_nodes, wallSearch.correct);

            self.endpoint_reached = true;
            self.collided = true;

            step_resolved = true;
        }
    }

    if (shieldSearch.correct != noone && !step_resolved) {
        if (ds_list_find_index(self.beam_nodes, shieldSearch.correct) == -1) {
            ds_list_add(self.beam_nodes, shieldSearch.correct);

            self.facing *= -1;
            self.collided = true;

            beam_point = shieldSearch.correct.x + self.facing * shieldSearch.correct.radius;
            last_obj = shieldSearch.correct;
            step_resolved = true;
        }
        else {
            ds_list_add(self.beam_nodes, shieldSearch.correct);

            self.endpoint_reached = true;
            self.collided = true;

            step_resolved = true;
        }
    }

    if (wallSearch.correct != noone && !step_resolved) {
        ds_list_add(self.beam_nodes, wallSearch.correct);

        self.endpoint_reached = true;
        self.collided = true;

        step_resolved = true;
    }

    if (wallSearch.correct == noone && shieldSearch.correct == noone && !step_resolved) {
        self.endpoint_reached = true;
        step_resolved = true;
    }
}

self.beam_head_node_changed = true;
self.invalid = false;
self.alarm[0] = self.beam_update_delay;
