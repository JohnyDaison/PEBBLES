function abi_teleport() {
    show_debug_message("teleport used");

    var abi_color = g_blue;
    var abi_level = get_level(self.id, "teleport");
    var success = false;
    var result;

    if (self.abi_cooldown_length[? abi_color] == DB.abi_cooldowns[? abi_color]) {
        self.teleport_uses_left = abi_level;
    }

    if (self.has_tp_rush || self.teleport_uses_left > 1) {
        self.abi_cooldown_length[? abi_color] = 1;
    }
    else {
        self.abi_cooldown_length[? abi_color] = DB.abi_cooldowns[? abi_color];
    }


    if (self.desired_aim_dist > 0) {
        result = compute_blink_position(self.desired_aim_dir);

        if (result[? "dist"] > 0) {
            success = true;
        }
    }

    if (!success) {
        self.abi_cooldown_length[? abi_color] = 1;
        my_sound_play(failed_sound);

        return false;
    }

    self.drop_enemy_flags();

    self.pre_tp_x = self.x;
    self.pre_tp_y = self.y;

    self.x = result[? "x"];
    self.y = result[? "y"];

    self.last_x = self.x;
    self.last_y = self.y;
    self.speed = 0;

    self.has_tped = true;
    my_sound_play(tp_sound);

    if (self.teleport_uses_left == abi_level) {
        self.teleport_first_use_step = self.step_count;
    }

    if (self.has_tp_rush) {
        self.teleport_uses_left = abi_level;
    }
    else {
        self.teleport_uses_left--;
    }

    return true;
}
