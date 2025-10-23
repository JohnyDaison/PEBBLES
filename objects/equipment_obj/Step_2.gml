/// @description HANDLE GUYS

/// GRAVITATES TO GUY AND EQUIP ON TOUCH
if (self.my_guy == self.id) {
    var guy = noone;
    var guys = find_nearest_instances(self.id, guy_obj, 1600, "holographic", self.holographic);

    if (array_length(guys) > 0) {
        var result = guys[0];
        guy = result.id;
    }

    if (instance_exists(guy)) {
        var xx = guy.x;
        var yy = guy.y;

        if (self.obj_center_offset) {
            xx -= lengthdir_x(self.obj_center_dist, self.obj_center_angle + self.image_angle);
            yy -= lengthdir_y(self.obj_center_dist, self.obj_center_angle + self.image_angle);
        }
        move_towards_point(xx, yy, 1);
    }

    var body = instance_place(self.x, self.y, phys_body_obj);

    if (body != noone && body.holographic == self.holographic) {
        body_equip(body, self.id);
    }
}

// POSITIONING ON GUY
if (instance_exists(self.my_guy) && self.my_guy != self.id && self.hardpoint != -1) {
    var hardpointX = self.my_guy.hardpoint_x[? self.hardpoint];
    var hardpointY = self.my_guy.hardpoint_y[? self.hardpoint];
    var hp_dist = point_distance(0, 0, hardpointX, hardpointY);
    var hp_dir = point_direction(0, 0, hardpointX, hardpointY) + self.my_guy.image_angle;
    var rot_hp_x = lengthdir_x(hp_dist, hp_dir);
    var rot_hp_y = lengthdir_y(hp_dist, hp_dir);

    self.x = self.my_guy.x + rot_hp_x;
    self.y = self.my_guy.y + rot_hp_y;

    if (object_is_ancestor(self.my_guy.object_index, guy_obj)) {
        if (self.object_index == sprinkler_shield_obj) {
            var equip_count = ds_list_size(self.my_guy.equipment_list);
            var range = (equip_count - 1) * 90;
            var des_angle;

            if (self.my_guy.aim_dist > 0) {
                des_angle = self.my_guy.aim_dir + 180 - range / 2 + self.hardpoint * 90;
            }
            else {
                des_angle = 90 + 90 * self.my_guy.facing - range / 2 + self.hardpoint * 90;
            }

            var diff = angle_difference(des_angle, self.image_angle);

            self.rel_rotation_speed = sign(diff) * min(abs(diff), sqrt(abs(diff)));
            self.rel_rotation_angle += self.rel_rotation_speed;
        }
    }
    else if (self.my_guy.object_index == spitter_body_obj) {
        if (self.object_index == sprinkler_shield_obj) {
            //var equip_count = ds_list_size(self.my_guy.equipment_list);
            //var range = (equip_count-1)*90;
            var des_angle;

            des_angle = self.my_guy.direction; // + 180 - range/2 + hardpoint*90

            var diff = angle_difference(des_angle, self.image_angle);

            self.rel_rotation_speed = sign(diff) * min(abs(diff), sqrt(abs(diff)));
            self.rel_rotation_angle += self.rel_rotation_speed;
        }
    }
    else {
        self.rel_rotation_speed += self.rel_rotation_delta;
        self.rel_rotation_angle += self.rel_rotation_speed;
    }

    if (self.connected_base) {
        self.image_angle = self.my_guy.image_angle + self.rel_rotation_angle;
    }
    else {
        self.image_angle = self.rel_rotation_angle;
    }

    self.image_angle = self.image_angle mod 360;
}

event_inherited();
