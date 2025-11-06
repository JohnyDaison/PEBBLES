if (self.holographic != other.holographic) {
    exit;
}

if (other.my_color == self.my_color) {
    if (instance_exists(self.col_group)) {
        if (self.col_group.resolved) {
            self.col_group = noone;
        }
    }

    if (!instance_exists(self.col_group)) {
        if (instance_exists(other.col_group)) {
            self.col_group = other.col_group;
        }
        else {
            self.col_group = instance_create(self.x, self.y, collision_group_obj);
        }

        ds_list_add(self.col_group.members, self.id);
    }
}

if (object_index == slime_ball_obj) {
    exit;
}

if (self.my_color > g_dark && self.my_color < g_white && (other.my_color + self.my_color) == g_white) {
    if (instance_exists(self.inv_col_group)) {
        if (self.inv_col_group.resolved) {
            self.inv_col_group = noone;
        }
    }

    if (!instance_exists(self.inv_col_group)) {
        if (instance_exists(other.inv_col_group)) {
            if (other.inv_col_group.force[? self.my_color] <= other.inv_col_group.force[? g_white - self.my_color]) {
                self.inv_col_group = other.inv_col_group;
            }
        }
        else {
            self.inv_col_group = instance_create(self.x, self.y, collision_group_obj);
            self.inv_col_group.annihilate = true;
        }

        if (instance_exists(self.inv_col_group)) {
            ds_list_add(self.inv_col_group.members, self.id);
            self.inv_col_group.force[? self.my_color] += self.force;
            self.inv_col_group.ratio_updated = false;
        }
    }
}
