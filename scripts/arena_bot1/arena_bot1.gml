/// @self basic_bot
/// @param {Id.Instance} near_player
function arena_bot1(near_player) {
    if (!self.npc_active && self.phase == 0) {
        return;
    }

    // NEAR PLAYER
    var pl_dist = 0;
    var last_phase = 3;

    if (instance_exists(near_player)) {
        pl_dist = point_distance(self.x, self.y, near_player.x, near_player.y);
    }
    else {
        if (self.phase >= last_phase) {
            self.phase = last_phase;
        }
    }

    self.attack_target = near_player;

    var should_attack = false;

    if (instance_exists(self.attack_target)) {
        var targetAcquired = !self.attack_target.invisible && self.holographic == self.attack_target.holographic;

        if (targetAcquired) {
            var targetIsDead = object_is_child(self.attack_target, phys_body_obj) && self.attack_target.dead;

            if (!targetIsDead) {
                should_attack = npc_line_of_sight_instance(self.attack_target, "attack");
            }
        }
    }

    var should_shield = has_level(id, "shield", 1) && !instance_exists(self.my_shield) && self.shield_ready;

    // PHASES
    if (self.phase == 0) {
        self.wanna_channel = false;
        self.wanna_abi = false;
        self.wanna_cast = false;

        if (should_attack || should_shield) {
            var new_color = 3;

            while (new_color == 3) {
                new_color = irandom(3) + 1;
            }

            if (random(5) < 1) {
                ds_list_add(self.new_colors, new_color);
            }
        }
        else if (self.current_slot > 0) {
            self.wanna_cast = true;
        }

        if (self.current_slot > 0 && ((irandom(2) <= self.current_slot) || (self.current_slot == 2 && pl_dist > self.third_attack_range))) {
            if (should_shield) {
                self.hor_dir_held = false;
                self.desired_aim_dist = 0;
                self.wanna_cast = true;

                self.phase = 1;
            }
            else if (should_attack) {
                if (instance_exists(near_player)) {
                    self.hor_dir_held = (abs(self.x - near_player.x) > 64 || abs(self.y - near_player.y) < 32);
                }
                else {
                    self.hor_dir_held = true;
                }

                self.wanna_cast = true;

                self.phase = 1;
            }
        }
    }

    if (self.phase == 1) {
        if (self.charging && self.charge_ball != noone) {
            if (self.charge_ball.charge >= (0.75 * min(1, self.difficulty) * self.charge_ball.threshold) && random(10 / self.difficulty) < 1) {
                self.wanna_cast = false;
                self.phase = last_phase;
            }
        }
    }

    if (self.phase == 2) {
        self.wanna_channel = false;
        self.wanna_abi = false;
        self.wanna_cast = false;

        if (self.abi_cooldown[? g_dark] > 0) {
            self.phase = 0;
            self.facing_right = !self.facing_right;
        }
        else if (self.my_color == g_dark) {
            self.wanna_abi = true;
        }
        else if (!self.channeling) {
            self.wanna_channel = true;
        }
    }

    if (self.phase >= last_phase) {
        self.phase++;

        if (self.phase >= round(10 / self.difficulty)) {
            self.phase = 0;
        }
    }


    // TRY TO JUMP WHEN FALLING
    if (self.vspeed > self.gravity) {
        if (self.wanna_jump || self.have_jumped) {
            self.wanna_jump = false;
            self.have_jumped = false;
        }
        else {
            self.wanna_jump = true;
            self.wanna_run = true;
            self.looking_up = true;
        }
    }

    // WALL JUMP/CLIMB
    if (self.holding_wall) {
        //self.wanna_jump = false; //!self.have_jumped
        if (self.wanna_jump || self.have_jumped) {
            self.wanna_jump = false;
            self.have_jumped = false;
        }
        else {
            self.wanna_jump = true;
            self.wanna_run = true;
            self.looking_up = true;
        }
    }

    // USE FLASHBACK WHEN FALLING
    if (abs(self.y - room_height) < self.flashback_margin && self.abi_cooldown[? g_dark] == 0) {
        self.phase = 2;
    }

    // MOVEMENT
    if ((self.step_count - self.last_direction_change) > self.direction_change_min_time
        && self.step_count mod self.direction_change_min_time == 0)
    {
        self.looking_up = false;
        self.looking_down = false;
        self.desired_aim_dir = 0;
        self.desired_aim_dist = 0;

        // TRY TO AIM AT PLAYER
        if (instance_exists(near_player)) {
            self.facing_right = !!(sign(near_player.x - self.x));

            if (random(2 / self.difficulty) < 1) {
                self.looking_up = (self.y - near_player.y) > 48;
            }

            if (random(2 / self.difficulty) < 1) {
                self.looking_down = (near_player.y - self.y) > 48;
            }

            self.last_direction_change = self.step_count;

            if (pl_dist < self.attack_min_range) {
                self.wanna_run = false;
                //self.wanna_look = true;
            }

            self.desired_aim_dir = point_direction(self.x, self.y, near_player.x, near_player.y);
            self.desired_aim_dist = 1;
        }

        // RANDOM AIM VS RUN
        if (random(3) < 1) {
            self.wanna_run = false;
            //self.wanna_look = true;
        }

        if (random(3) < 1) {
            self.wanna_run = true;
            //self.wanna_look = false;
        }

        // RANDOM JUMPING
        if (!self.wanna_cast && random(2 / self.difficulty) < 1) {
            self.wanna_jump = !self.wanna_jump;
        }

        /* too pacifist
        if(self.phase == 2 && random(1.5) < 1)
        {
            self.phase = 0;
        }
        */

        if (!self.npc_active) {
            self.hor_dir_held = false;
            self.wanna_cast = false;
            self.wanna_run = false;
            self.wanna_look = false;
            self.wanna_jump = false;
            self.wanna_abi = false;
            self.looking_up = false;
            self.looking_down = false;

            self.phase = 0;
        }
    }
}
