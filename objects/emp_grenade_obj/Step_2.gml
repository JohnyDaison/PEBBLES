/// @description AIM, CONTROL, EXPLOSION
if (self.hold_mode) {
    if (instance_exists(self.my_guy.charge_ball)) {
        self.x = self.my_guy.charge_ball.x;
        self.y = self.my_guy.charge_ball.y;
    }
    else {
        self.x = self.my_guy.x + lengthdir_x(self.my_guy.aim_dist, self.my_guy.aim_dir);
        self.y = self.my_guy.y + lengthdir_y(self.my_guy.aim_dist, self.my_guy.aim_dir);
    }
}

if (self.armed && !self.done_for) {
    if (self.placed) {
        self.fuse_left -= self.fuse_tick;
    }

    if (!self.active && self.attached) {
        self.active = true;
        self.fuse_left = min(self.fuse_left, self.attached_fuse_length);

        if (!object_is_ancestor(self.stuck_to.object_index, phys_body_obj)) {
            var my_shield = instance_create(self.x, self.y, shield_obj);

            my_shield.my_guy = self.id;
            my_shield.my_source = self.object_index;
            my_shield.my_player = self.my_player;
            my_shield.my_color = self.my_color;
            my_shield.tint_updated = false;
            my_shield.charge = 5;
            my_shield.max_charge = 5;
            //my_shield.min_size = self.max_charge;

            self.my_shield = my_shield;

            my_sound_play(shield_sound);
        }
    }

    if (self.active) {
        if (instance_exists(self.my_shield)) {
            self.my_shield.x = self.x;
            self.my_shield.y = self.y;
        }
    }

    if (self.fuse_left <= 0) {
        self.speed = 0;
        self.gravity = 0;

        if (!gamemode_obj.limit_reached) {
            var inst = instance_create(self.x, self.y, slot_explosion_obj);
            inst.my_color = my_color;
            inst.my_guy = my_guy;
            inst.my_source = emp_grenade_obj;
            inst.my_player = my_player;
            inst.holographic = holographic;
        }

        if (instance_exists(self.my_shield)) {
            self.my_shield.my_guy = self.my_shield.id;
            self.my_shield.done_for = true;
        }

        with (emp_grenade_obj) {
            if (self.id != other.id && self.armed && point_distance(self.x, self.y, other.x, other.y) < self.chain_explosion_range) {
                self.fuse_left = min(self.fuse_left, 3 * self.fuse_tick);
            }
        }

        self.done_for = true;
        self.fuse_left = 0;
        self.armed = false;
        self.active = false;
    }
}

if (self.done_for) {
    self.speed = 0;
    self.gravity = 0;

    self.image_index = 1 + self.fuse_left * (self.image_number - 2);
    self.image_alpha = 1 - self.fuse_left;
    self.fuse_left += self.explode_anim_speed;

    if (self.fuse_left >= 1) {
        instance_destroy();
        exit;
    }
}

event_inherited();