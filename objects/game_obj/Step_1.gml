if (self.invisible)
    self.visible = false;
// TINT UPDATE

if (!self.tint_updated) {
    if (self.multicolor) {
        if (self.my_color == g_octarine) {
            if (self.octarine_phase_shift == 0) {
                self.tint = singleton_obj.octarine_tint;
            }
            else {
                self.tint = make_colour_hsv((singleton_obj.step_count * 4 + self.octarine_phase_shift) mod 256, 196, 255);
            }

            if (self.damage_tint_alpha > 0) {
                self.tint = merge_colour(self.tint, self.last_damage_tint, self.damage_tint_alpha);
                self.damage_tint_alpha = max(0, self.damage_tint_alpha - self.damage_tint_fade_step);
            }
        }
        else {
            self.new_tint = DB.colormap[? self.my_color];

            var old = self.tint;
            self.tint = merge_colour(self.tint, self.new_tint, 1 / 6);

            if (old == self.tint) {
                self.tint = self.new_tint;
            }

            if (self.tint == self.new_tint) {
                self.tint_updated = true;
            }
        }
    }
    else {
        self.tint = self.forced_tint;
    }
}

// HOLOGRAPHIC
if (self.holographic) {
    self.holo_alpha += self.holo_alpha_step;

    if (self.holo_alpha < self.holo_minalpha) {
        self.holo_alpha = self.holo_minalpha;
        self.holo_alpha_step *= -1;
    }

    if (self.holo_alpha > self.holo_maxalpha) {
        self.holo_alpha = self.holo_maxalpha;
        self.holo_alpha_step *= -1;
    }
}

if (!self.holographic && self.holo_alpha != -1) {
    self.holo_alpha = 1;
}

// OBJECT CENTER OFFSET
if (self.obj_center_offset && !self.obj_center_updated) {
    self.obj_center_dist = point_distance(0, 0, self.obj_center_xoff, self.obj_center_yoff);
    self.obj_center_angle = point_direction(0, 0, self.obj_center_xoff, self.obj_center_yoff);

    self.obj_center_updated = true;
}

// TERRAIN OPTIMIZATION

if (self.read_terrain) {
    var cur_grid_x = 0, cur_grid_y = 0;

    if (is_undefined(self.ter_list)) {
        self.ter_list = ds_list_create();
    }

    // GRID POSITION
    //if(room == alpinus_sandbox || room == tutorial || room == tutorial_backup || room == face_arena || room == mayhemburger_arena)
    if (room != chase) {
        cur_grid_x = floor((self.x - singleton_obj.grid_margin) / singleton_obj.grid_cell_size);
    }

    cur_grid_y = floor((self.y - singleton_obj.grid_margin) / singleton_obj.grid_cell_size);

    // GRID SECTION UPDATE
    if (cur_grid_x != ter_grid_x || cur_grid_y != ter_grid_y) {
        ds_list_clear(ter_list);

        var hor_min = cur_grid_x - ter_left;
        var hor_max = cur_grid_x + ter_right;
        var ver_min = cur_grid_y - ter_up;
        var ver_max = cur_grid_y + ter_down;

        // MAKE SURE EDGES ARE INSIDE GRID
        hor_min = max(0, hor_min);
        hor_min = min(hor_min, singleton_obj.grid_width - 1);

        hor_max = max(0, hor_max);
        hor_max = min(hor_max, singleton_obj.grid_width - 1);

        ver_min = max(0, ver_min);
        ver_min = min(ver_min, singleton_obj.grid_height - 1);

        ver_max = max(0, ver_max);
        ver_max = min(ver_max, singleton_obj.grid_height - 1);

        // POPULATE TERRAIN LIST
        for (var yy = ver_min; yy <= ver_max; yy += 1) {
            for (var xx = hor_min; xx <= hor_max; xx += 1) {
                var list = singleton_obj.terrain_grid[# xx, yy];
                var size = ds_list_size(list);

                for (var i = 0; i < size; i += 1) {
                    ds_list_add(self.ter_list, list[| i]);
                }
            }
        }

        self.ter_list_length = ds_list_size(self.ter_list);

        // UPDATE GRID POSITION
        self.ter_grid_x = cur_grid_x;
        self.ter_grid_y = cur_grid_y;
    }
}
