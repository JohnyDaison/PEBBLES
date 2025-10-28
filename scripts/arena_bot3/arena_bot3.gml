/// @self basic_bot
/// @param {Id.Instance} requested_attack_target
function arena_bot3(requested_attack_target) {
    if (!self.npc_active && self.next_phase == 0) {
        return;
    }

    // TODO: pl_dist is probably used in many places it shouldn't be
    var pl_dist = 0;

    var last_phase = 5;
    var opponent_color = g_white;

    var npc_wanna_shield = false;
    var npc_wanna_dive = false;
    var use_abi = false;
    var abi_color = g_nothing;

    if (instance_exists(requested_attack_target)) {
        pl_dist = point_distance(self.x, self.y, requested_attack_target.x, requested_attack_target.y);
        opponent_color = requested_attack_target.my_color;
        if (instance_exists(requested_attack_target.my_shield)) {
            opponent_color = requested_attack_target.my_shield.my_color;
        }
    }
    else {
        if (self.phase >= last_phase) {
            self.next_phase = last_phase;
        }
    }

    self.phase = self.next_phase;

    if (self.dead) {
        self.phase = 0;
        self.next_phase = 0;
    }

    var backDist = self.facing * 15;
    var frontDist = self.facing * 17;
    var above_pit = collision_line(self.x - backDist, self.y, self.x - backDist, room_height, terrain_obj, false, false) == noone
                 && collision_line(self.x, self.y, self.x, room_height, terrain_obj, false, false) == noone
                 && collision_line(self.x + frontDist, self.y, self.x + frontDist, room_height, terrain_obj, false, false) == noone;
    var near_room_edge = abs(self.x) < (self.flashback_margin / 2) || abs(self.x - room_width) < (self.flashback_margin / 2) || abs(self.y - room_height) < self.flashback_margin;

    // MATCH BURST COLOR
    var burst = instance_place(self.x, self.y, energy_burst_obj);

    if (instance_exists(burst)) {
        if (!self.slots_triggered && self.my_color != burst.my_color) {
            if (self.current_slot == 0) {
                for (var col = g_red; col <= g_blue; col++) {
                    if (col == g_yellow)
                        continue;

                    if (col & burst.my_color) {
                        ds_list_add(self.new_colors, col);
                    }
                }

                self.auto_chosen_orbs = true;
            }

            self.wanna_cast = true;
            self.wanna_channel = false;
            self.wanna_abi = false;
        }

        self.color_chosen = true;
        self.phase = 1;
        self.next_phase = 1;
    }

    // INVALIDATE WAYPOINTS DURING FLASHBACK
    if (self.flashing_back) {
        self.npc_destination_reached = false;
        self.npc_waypoint = "";
        self.npc_last_waypoint = "";
    }

    var can_shoot = status_left[? "suppressed"] == 0 && instance_exists(self.charge_ball);
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

    // TODO: implement logic for this variable
    var can_go_magenta = false;

    var can_shield = self.status_left[? "shield_down"] == 0 && self.shield_ready && has_level(self.id, "shield", 1) && instance_exists(self.charge_ball);
    var should_shield = self.potential_color != g_dark
        && (!instance_exists(self.my_shield)
            || self.status_left[? "suppressed"] > 0
            || (instance_exists(self.my_shield) && self.my_shield.energy < self.my_shield.max_charge / 2));


    // try to get out of Suppresion when you can't Shield
    if (self.phase == 1 && self.status_left[? "suppressed"] > 0 && self.my_color != g_magenta && !can_shield) {
        if (can_go_magenta) {
            self.phase = 0;
        }

        if (self.npc_destination_reached) {
            // TODO: find some neighbour waypoint in the nav graph
        }
    }

    // PHASES

    // choose color and charge phase
    if (self.phase == 0) {
        self.wanna_cast = false;
        self.wanna_channel = false;
        self.wanna_abi = false;
        self.npc_wanna_shoot_dark_decided = false;
        var npc_wanna_cast = false;

        if (self.prev_phase != self.phase || self.potential_color == g_dark || self.channeling || self.auto_chosen_orbs) {
            self.color_chosen = false;
        }

        if (!self.auto_chosen_orbs) {
            // GENERAL PROBLEM SOLVING

            /*
            if(!can_shoot && !can_shield && current_slot > 0)
            {
                wanna_cast = true;
            }
            */

            if (!self.color_chosen) {
                // NON ATTACK COLOR CHOICE
                var ready_for_new_color = (self.current_slot == 0 && !self.slots_triggered);
                var npc_wanna_new_color = false;

                // STATUS EFFECTS
                if ((self.status_left[? "frozen"] > 0 || self.sliding || self.wall_sliding) && self.my_color != g_blue) {
                    npc_wanna_new_color = true;
                    if (ready_for_new_color) {
                        ds_list_add(self.new_colors, g_blue);
                    }
                }
                else if (self.status_left[? "suppressed"] > 0 && self.my_color != g_magenta) {
                    npc_wanna_new_color = true;
                    if (ready_for_new_color) {
                        ds_list_add(self.new_colors, g_red, g_blue);
                    }
                }
                else if (self.status_left[? "slow"] > 0 && my_color != g_green) {
                    npc_wanna_new_color = true;
                    if (ready_for_new_color) {
                        ds_list_add(self.new_colors, g_green);
                    }
                    wanna_jump = !wanna_jump;
                }
                else if (self.status_left[? "burn"] > 0 && my_color != g_red) {
                    npc_wanna_new_color = true;
                    if (ready_for_new_color) {
                        ds_list_add(self.new_colors, g_red);
                    }
                }

                // PASS THROUGH FILTER
                if (!npc_wanna_new_color) {
                    //my_console_log("start filter check");
                    var spd = max(self.speed, self.running_maxspeed);

                    var x_offset = lengthdir_x(spd, self.direction);
                    var y_offset = lengthdir_y(spd, self.direction);

                    var meeting_filter = instance_place(self.x + x_offset + self.facing, self.y + y_offset, filter_field_obj);

                    if (instance_exists(meeting_filter) && meeting_filter.my_color != self.my_color) {
                        my_console_log("filter detected");
                        npc_wanna_new_color = true;

                        if (ready_for_new_color) {
                            var comp = color_to_components(filter_field_obj.my_color);

                            for (var col = g_red; col <= g_blue; col++) {
                                if (col == g_yellow) {
                                    continue;
                                }

                                if (comp[col]) {
                                    ds_list_add(self.new_colors, col);
                                    my_console_log("color added " + string(col));
                                }
                            }
                        }
                    }
                }

                // WANNA NEW COLOR
                if (npc_wanna_new_color) {
                    self.auto_chosen_orbs = true;
                    self.wanna_cast = true;
                }

            }

            // ATTACK OR SHIELD
            if (can_shoot || can_shield) {
                // if already trying to cast don't change color
                if (self.wanna_cast) {
                    self.color_chosen = true;
                }

                // ATTACK OR SHIELD COLOR CHOICE
                if (!self.color_chosen && !self.slots_triggered) {
                    // DARK ATTACK
                    if (self.potential_color == g_dark && !self.npc_wanna_shoot_dark_decided && pl_dist < self.vortex_range * get_orb_list_power_level(self.orbs_in_use[? g_dark])) {
                        self.npc_wanna_shoot_dark = random(2) < self.difficulty / 10;
                        self.npc_wanna_shoot_dark_decided = true;
                        if (self.npc_wanna_shoot_dark) {
                            self.color_chosen = true;
                        }
                    }


                    if (self.potential_color > g_dark && self.current_slot > 0) {
                        // COLOR ATTACKS
                        switch (self.current_slot) {
                            case 1:
                                if (random(3) < 1) {
                                    if (has_level(self.id, "blast_mode", 1)) {
                                        color_chosen = true;
                                    }
                                }
                                break;

                            case 2:
                                if (pl_dist >= third_attack_range || random(3) < 1) {
                                    if (has_level(self.id, "barrage_mode", 1)) {
                                        color_chosen = true;
                                    }
                                }
                                break;

                            case 3:
                                if (has_level(self.id, "dashwave_mode", 1) && npc_line_of_sight(self.x, self.y, "move") && pl_dist < self.third_attack_range * get_orb_list_power_level(self.color_slots)) {
                                    color_chosen = true;
                                }
                                else {
                                    wanna_cast = true;
                                }
                                break;
                        }
                    }
                }

                // ADD NEW COLOR ORB
                if (!self.color_chosen && !self.slots_triggered) {
                    var new_color = 3;

                    while (new_color == 3) {
                        new_color = irandom(3) + 1;
                    }

                    var weight = get_power_ratio(self.potential_color | new_color, opponent_color);

                    if (weight < 0) {
                        weight = 0.25;
                    }

                    if (random(3 * (self.current_slot + 1)) < weight) {
                        ds_list_add(self.new_colors, new_color);
                        self.auto_chosen_orbs = true;
                    }

                    /*
                    if(random(6 * (self.current_slot + 1)) < 1)
                    {
                        ds_list_add(self.new_colors, new_color);
                        self.auto_chosen_orbs = true;
                    }
                    else if(!(opponent_color & new_color) && random(4 * (self.current_slot + 1)) < 1)
                    {
                        ds_list_add(self.new_colors, new_color);
                        self.auto_chosen_orbs = true;
                    }
                    */
                }

                // COLOR CHOSEN
                if (self.color_chosen) {
                    if (should_shield && can_shield) {
                        // SHIELD
                        npc_wanna_cast = true;
                        npc_wanna_shield = true;
                        self.attack_mode = false;
                    }
                    else if (should_attack && can_shoot) {
                        // ATTACK
                        npc_wanna_cast = true;
                        self.attack_mode = true;

                        if (DB.console_mode == CONSOLE_MODE.DEBUG) // DB.console_mode == CONSOLE_MODE.TEST ||
                        {
                            if (self.potential_color == g_dark) {
                                speech_instant("DARK ATTACK");
                            }
                        }
                    }
                    /*
                    else
                    {
                        self.wanna_cast = true;
                        self.npc_wanna_shield = false;
                        self.attack_mode = false;
                        self.color_chosen = false;
                    }
                    */
                }
            }
            /*
            if(self.color_chosen && !self.auto_chosen_orbs)
            {
                if(!self.wanna_cast)
                {
                    self.wanna_cast = true;
                }
                else
                {
                    self.wanna_cast = false;
                    self.color_chosen = false;
                }
            }
            */

            // GO TO NEXT PHASE
            if (npc_wanna_cast) {
                self.wanna_cast = true;
                self.next_phase = 1;
            }
        }
    }

    // chargeball trigger phase
    else if (self.phase == 1) {
        self.wanna_abi = false;
        /*
        if(my_color == g_dark && !npc_wanna_shoot_dark_decided)
        {
            npc_wanna_shoot_dark = random(1) < difficulty/5;
            npc_wanna_shoot_dark_decided = true;
        }
        */

        if (!self.wanna_cast || (self.my_color == g_dark && !(self.npc_wanna_shoot_dark && self.npc_wanna_shoot_dark_decided && self.attack_mode))) {
            self.next_phase = 0;
        }

        if (self.charging && self.charge_ball != noone) {
            if (should_shield && can_shield) {
                // SHIELD
                npc_wanna_shield = true;
                self.attack_mode = false;
            }

            // fire
            if (self.charge_ball.charge >= (0.75 * min(1, self.bot_aggressiveness) * self.charge_ball.threshold) && random(10 / self.bot_speed) < 1) {
                //if(!self.attack_mode || !instance_exists(requested_attack_target) || (self.status_left[? "suppressed"] == 0 && !requested_attack_target.protected && !requested_attack_target.invisible && self.holographic == requested_attack_target.holographic))
                if (!self.attack_mode || !instance_exists(self.attack_target) || (self.status_left[? "suppressed"] == 0 && !self.attack_target.protected && !self.attack_target.invisible && self.holographic == self.attack_target.holographic)) {
                    self.wanna_cast = false;
                    next_phase = 3;
                }
            }
        }
        else if (!self.slots_triggered && self.current_slot == 0) {
            // got interrupted
            self.wanna_cast = false;
            self.next_phase = 3;
        }
    }

    // flashback / teleport execution phase
    else if (self.phase == 2) {
        self.wanna_channel = false;
        self.wanna_abi = false;
        self.wanna_cast = false;

        var possible = false;

        if (near_room_edge && rule_get_state("abilities")) {
            if (rule_get_state("dark_color") && has_level(self.id, "rewind", 1) && self.abi_cooldown[? g_dark] == 0) {
                possible = true;
                abi_color = g_dark;
            }
            else if (!lost_control && has_level(self.id, "base_teleport", 1) && self.abi_cooldown[? g_white] == 0) {
                possible = true;
                abi_color = g_white;
            }
        }

        if (possible) {
            use_abi = true;
        }
        else {
            self.next_phase = 0;
            set_guy_facing(!self.facing_right);
        }

        self.npc_destination_reached = false;
        self.npc_waypoint = "";
        self.npc_last_waypoint = "";
    }

    // support abi execution phase
    else if (self.phase == 3) {
        self.wanna_channel = false;
        self.wanna_abi = false;
        //wanna_cast = false;

        var support_abi_mode = false;
        abi_color = g_dark;

        if (rule_get_state("abilities")) {
            if ((self.damage - self.min_damage) > 1.5 && (has_level(self.id, "heal", 1) && self.abi_cooldown[? g_green] == 0)) {
                support_abi_mode = true;
                abi_color = g_green;
            }

            if (self.damage > (self.hp - self.min_damage) * 0.6 && (has_level(self.id, "base_teleport", 1) && self.abi_cooldown[? g_white] == 0)
                && base_has_crystals()) {
                support_abi_mode = true;
                abi_color = g_white;
            }
        }

        //show_debug_message("Arena bot 2, Phase 3: sup_abi_mode=" + string(support_abi_mode) + " abi_color=" + string(abi_color));

        if (support_abi_mode) {
            use_abi = true;
        }
        else {
            self.next_phase = last_phase;
        }
    }

    // blink execution phase
    else if (self.phase == 4) {
        self.wanna_channel = false;
        self.wanna_abi = false;
        self.wanna_cast = false;

        var possible = false;

        if (rule_get_state("abilities")) {
            if (!self.lost_control && has_level(self.id, "teleport", 1) && self.abi_cooldown[? g_blue] == 0) {
                var tp_dist = 256;

                var dist = point_distance(self.x, self.y, self.npc_waypoint_x, self.npc_waypoint_y);
                var dir = point_direction(self.x, self.y, self.npc_waypoint_x, self.npc_waypoint_y);

                self.desired_aim_dist = 1;

                if (dist <= tp_dist) {
                    var offset = 0;
                    var done = false;

                    while (!done) {
                        dist = point_distance(self.x, self.y, self.npc_waypoint_x, self.npc_waypoint_y - offset);
                        dir = point_direction(self.x, self.y, self.npc_waypoint_x, self.npc_waypoint_y - offset);

                        if (dist > tp_dist) {
                            done = true;
                            break;
                        }

                        var result = compute_blink_position(dir);

                        var above_wp = abs(result.x - self.npc_waypoint_x) < 16 && result.y < self.npc_waypoint_y;

                        if (above_wp) {
                            done = true;
                        }
                        else {
                            offset += 32;
                        }
                    }

                    self.desired_aim_dir = dir;
                }
                else {
                    self.desired_aim_dir = point_direction(0, 0, self.facing, -1);
                }

                possible = true;
                abi_color = g_blue;
            }
        }

        if (possible) {
            use_abi = true;
        }
        else {
            self.next_phase = 0;
        }

        self.npc_destination_reached = false;
        self.npc_waypoint = "";
        self.npc_last_waypoint = "";
    }

    // channelling phase
    else if (self.phase >= last_phase) {
        self.wanna_cast = false;
        self.wanna_channel = false;
        self.wanna_abi = false;

        if (!self.holding_wall) {
            self.wanna_channel = true;
        }

        if (self.channeling) {
            // choose colors
            var new_color = 3;

            if (random(5) < 1) {
                while (new_color == 3) {
                    new_color = irandom(3) + 1;
                }

                // Look at which orb will be picked for that color
                // this copies heavily from HANDLE SLOT FILLING
                var belt = self.orb_belts[? new_color];
                if (!is_undefined(belt) && ds_exists(belt, ds_type_list)) {
                    var orb = belt[| 0];
                    if (!is_undefined(orb) && instance_exists(orb)) {
                        if (orb.energy < (orb.max_energy - 3 * self.channel_maxboost)) {
                            ds_list_add(self.new_colors, new_color);
                            self.auto_chosen_orbs = true;
                            //my_console_log("Bot "+ string(self.my_player.number) + " added color from belt c:" + string(new_color) + " e:" + string(orb.energy) + " max:" + string(orb.max_energy));
                        }
                        else {
                            //my_console_log("Bot "+ string(self.my_player.number) + " avoided color c:" + string(new_color));
                        }
                    }
                    else {
                        orb = noone;
                        if (instance_exists(self.charge_ball)) {
                            for (var chbi = self.charge_ball.orb_count - 1; chbi >= 0; chbi--) {
                                orb = self.charge_ball.orbs[| chbi];
                                if (instance_exists(orb) && orb.my_color == new_color) {
                                    if (orb.energy < (orb.max_energy - 3 * self.channel_maxboost)) {
                                        ds_list_add(self.new_colors, new_color);
                                        self.auto_chosen_orbs = true;
                                        //my_console_log("Bot "+ string(self.my_player.number) + " added color from chargeball c:" + string(new_color) + " e:" + string(orb.energy) + " max:" + string(orb.max_energy));
                                    }
                                    else {
                                        //my_console_log("Bot "+ string(self.my_player.number) + " avoided color c:" + string(new_color));
                                        continue;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        self.next_phase = self.phase + 1;

        if (self.total_orb_extra_energy >= (self.max_channeled_energy - 3 * self.channel_maxboost)) {
            //my_console_log("Bot "+ string(self.my_player.number) + " interrupted channeling - extra total");
            self.wanna_channel = false;
            self.next_phase = 0;
        }

        if (self.wanna_channel) {
            for (var i = 0; i < self.slot_number; i++) {
                var orb = self.color_slots[| i];
                if (orb.energy >= (orb.max_energy - 3 * self.channel_maxboost)) {
                    //my_console_log("Bot "+ string(self.my_player.number) + " interrupted channeling c:" + string(orb.my_color));
                    self.wanna_channel = false;
                    self.next_phase = 0;
                }
            }
        }

        if (self.phase >= (round(10 / self.bot_speed) + last_phase) || rule_get_state("color_orbs_energy_lock")) {
            self.next_phase = 0;
        }
    }

    // TRY TO PREVENT FALLING OUT OF ARENA - USE FLASHBACK OR BASE TP WHEN FALLING
    if (near_room_edge && rule_get_state("abilities")
        && ((has_level(self.id, "rewind", 1) && self.abi_cooldown[? g_dark] == 0)
            || (!self.lost_control && has_level(self.id, "base_teleport", 1) && self.abi_cooldown[? g_white] == 0))) {
        self.next_phase = 2;
    }


    // TRY TO PREVENT FALLING OUT OF ARENA - USE BLINK TO FINISH JUMPS, ALSO WHEN STUCK FOR LONGER
    var npc_stuck_long = self.npc_stuck && self.npc_stuck_start < self.npc_last_stuck_check;
    var pitfall_danger = above_pit && self.doublejump_count >= max_doublejumps && !instance_exists(self.landing_terrain) && (self.y - self.npc_waypoint_y) > 16;
    var can_blink = rule_get_state("abilities") && (!self.lost_control && has_level(self.id, "teleport", 1) && self.abi_cooldown[? g_blue] == 0);

    if ((pitfall_danger || npc_stuck_long) && can_blink) {
        self.next_phase = 4;
    }


    if (use_abi) {
        //show_debug_message("AB 2, P 3: slots_triggered=" + string(slots_triggered) + " casting=" + string(casting));
        if (!self.slots_triggered && !self.casting) {
            //show_debug_message("AB 2, P 3: potential_color=" + string(self.potential_color) + " current_slot=" + string(self.current_slot));
            //show_debug_message("AB 2, P 3: channeling=" + string(self.channeling) + " wanna_cast=" + string(self.wanna_cast));

            if ((self.my_color == abi_color && self.current_slot == 0) || (self.potential_color == abi_color && self.current_slot > 0)) {
                self.wanna_abi = true;
            }
            else if (self.current_slot > 0 && !self.channeling) {
                if (!self.holding_wall && !self.wanna_cast) {
                    self.wanna_channel = true;
                }
            }
            else {
                var col;

                for (col = g_red; col <= g_blue; col++) {
                    if (col == g_yellow)
                        continue;

                    if (abi_color & col) {
                        if (ds_list_find_index(self.new_colors, col) == -1) {
                            ds_list_add(self.new_colors, col);
                            self.auto_chosen_orbs = true;
                        }
                    }
                }
            }

            //show_debug_message("AB 2, P 3: wanna_abi=" + string(self.wanna_abi) + " wanna_channel=" + string(self.wanna_channel));
        }
    }
    else {
        self.wanna_abi = false;
    }

    // WALL HOLD FIX
    if (self.holding_wall || self.climbing_up) {
        self.wanna_channel = false;
    }


    // FIND TARGET
    var attack_waypoint = noone, waypoint = noone;
    var attack_target = noone;
    var move_target = noone;
    var move_target_y_offset = 0;
    ds_list_clear(self.attack_targets);

    if (instance_exists(requested_attack_target)) {
        if (requested_attack_target.dead) {
            waypoint = find_nearest_visible_waypoint("move");
            self.attack_mode = false;
        }

        if (!requested_attack_target.dead && !requested_attack_target.invisible) {
            if (!npc_wanna_shield) //  && instance_exists(charge_ball)
            {
                self.attack_mode = true;
                self.desired_aim_dir = point_direction(self.x, self.y, requested_attack_target.x, requested_attack_target.y);
                self.desired_aim_dist = 1;

                if (status_left[? "confusion"] > 0 && !self.npc_counter_confusion) {
                    //self.desired_aim_dir += random(360);
                    self.desired_aim_dir = point_direction(0, 0, -lengthdir_x(self.desired_aim_dir, 1), lengthdir_y(self.desired_aim_dir, 1))
                }

                // THROW GRENADE
                if (self.attack_target == requested_attack_target && (pl_dist < 100 || (self.held_item[? 2] != noone && pl_dist < 200))) {
                    if (self.held_item[? 2] != noone) {
                        if (npc_line_of_sight(requested_attack_target.x, requested_attack_target.y, "move")
                            && abs(angle_difference(point_direction(0, 0, self.charge_ball.rel_x, self.charge_ball.rel_y), self.desired_aim_dir)) < 1) {
                            self.stop_holding[? 2] = true;
                        }
                    }
                    else {
                        use_inv_item(2);
                    }
                }

                attack_target = requested_attack_target;
                ds_list_add(self.attack_targets, attack_target);

                /*
                var attack_target_str = string(attack_target);
                if(instance_exists(attack_target))
                {
                    attack_target_str = attack_target.name;
                }
                my_console_log("FIND TARGET => " + (attack_target_str));
                */
            }

            with (requested_attack_target) {
                waypoint = find_nearest_visible_waypoint("attack");
            }

            if (!instance_exists(npc_waypoint_obj)) {
                npc_destination_reached = false;
                npc_destination_x = requested_attack_target.x;
                npc_destination_y = requested_attack_target.y;
                npc_waypoint_x = requested_attack_target.x;
                npc_waypoint_y = requested_attack_target.y;
                npc_destination = requested_attack_target;
            }
        }
    }
    else {
        waypoint = find_nearest_visible_waypoint("move");
        self.attack_mode = false;
    }

    attack_waypoint = waypoint;

    if (!self.attack_mode || npc_wanna_shield) {
        //self.hor_dir_held = false;
        self.desired_aim_dir = 0;
        self.desired_aim_dist = 0;
    }

    if (!npc_wanna_shield) {
        // DESTROY ENEMY BASE
        var enemy_base = noone;
        var nearest_distance = 0;
        with (guy_spawner_obj) {
            var dist = point_distance(self.x, self.y, other.x, other.y);
            if (iff_check("attack_target_valid", other, self.id)) {
                var nearest = false;
                if (enemy_base == noone || dist < nearest_distance) {
                    nearest = true;
                }

                if (nearest) {
                    enemy_base = id;
                    nearest_distance = dist;
                }
            }
        }

        if (instance_exists(enemy_base) && nearest_distance < pl_dist && nearest_distance < 240) {
            with (enemy_base) {
                waypoint = find_nearest_visible_waypoint("attack");
            }
            self.desired_aim_dir = point_direction(self.x, self.y, enemy_base.x, enemy_base.y);

            if (self.status_left[? "confusion"] > 0 && !self.npc_counter_confusion) {
                self.desired_aim_dir = random(360);
            }

            self.desired_aim_dist = 1;

            attack_target = enemy_base;
            ds_list_add(self.attack_targets, attack_target);

            // my_console_log("BASE TARGET: " + string(attack_target));

            self.attack_mode = true;
        }

        // DESTROY TURRETS
        var enemy_turret = noone;
        nearest_distance = 0;
        with (turret_obj) {
            var dist = point_distance(self.x, self.y, other.x, other.y);
            if (iff_check("attack_target_valid", other, self.id)) {
                var nearest = false;
                if (enemy_turret == noone || dist < nearest_distance) {
                    nearest = true;
                }

                if (nearest) {
                    enemy_turret = id;
                    nearest_distance = dist;
                }
            }
        }

        if (instance_exists(enemy_turret) && (nearest_distance < (pl_dist - 64) || attack_target == noone) && nearest_distance < 280) {
            var block = noone;

            if (instance_exists(enemy_turret.my_block)) {
                block = enemy_turret.my_block;
            }

            if (instance_exists(block)) {
                with (block) {
                    waypoint = find_nearest_visible_waypoint("attack");
                }
                self.desired_aim_dir = point_direction(self.x, self.y, block.x + 15, block.y + 15);

                if (self.status_left[? "confusion"] > 0 && !self.npc_counter_confusion) {
                    self.desired_aim_dir = random(360);
                }

                self.desired_aim_dist = 1;

                attack_target = enemy_turret;
                ds_list_add(self.attack_targets, attack_target);

                // my_console_log("TURRET TARGET: " + string(attack_target));

                self.attack_mode = true;
            }
        }


        // SHOOT CLOSED GATES (only VERTICAL)
        // TODO: why it's not working?? wrong priority? problem with sight still not fixed?
        var target_gate = noone;
        nearest_distance = 0;
        var gate_fields = find_nearest_instances(self.id, gate_field_obj);
        var count = array_length(gate_fields);
        var gate1, gate2, gate1_valid, gate2_valid, dist1, dist2;
        var gate1_enabled_count, gate2_enabled_count;

        for (var i = 0; i < count; i++) {
            var result = gate_fields[i];
            var field = result.id;

            if (field.vertical) {
                gate1_valid = false;
                gate2_valid = false;
                gate1 = field.my_gates[? 1];
                gate2 = field.my_gates[? 3];
                gate1_enabled_count = 0;
                gate2_enabled_count = 0;

                dist1 = point_distance(self.x, self.y, gate1.x, gate1.y);
                dist2 = point_distance(self.x, self.y, gate2.x, gate2.y);

                for (var dir_i = 0; dir_i < 4; dir_i++) {
                    gate1_enabled_count += gate1.enabled[? dir_i];
                    gate2_enabled_count += gate2.enabled[? dir_i];
                }

                if (instance_exists(gate1.my_block)) {
                    if (gate1.my_block.object_index == wall_obj && npc_line_of_sight_instance(gate1.my_block, "attack") && gate1_enabled_count > 1) {
                        gate1_valid = true;
                    }
                }

                if (instance_exists(gate2.my_block)) {
                    if (gate2.my_block.object_index == wall_obj && npc_line_of_sight_instance(gate1.my_block, "attack") && gate2_enabled_count > 1) {
                        gate2_valid = true;
                    }
                }

                if ((dist1 < dist2 || !gate2_valid) && gate1_valid) {
                    if (target_gate == noone || dist1 < nearest_distance) {
                        target_gate = gate1;
                        nearest_distance = dist1;
                    }
                }
                else if (gate2_valid) {
                    if (target_gate == noone || dist2 < nearest_distance) {
                        target_gate = gate2;
                        nearest_distance = dist2;
                    }
                }
            }
        }

        if (instance_exists(target_gate)
            && (nearest_distance < (pl_dist + 64) || attack_target == noone) && nearest_distance < 280) {
            var block = noone;

            if (instance_exists(target_gate.my_block)) {
                block = target_gate.my_block;

                self.desired_aim_dir = point_direction(self.x, self.y, block.x + 15, block.y + 15);

                if (self.status_left[? "confusion"] > 0 && !self.npc_counter_confusion) {
                    self.desired_aim_dir = random(360);
                }

                self.desired_aim_dist = 1;

                attack_target = block;
                ds_list_add(self.attack_targets, attack_target);

                // my_console_log("GATE BLOCK TARGET: " + string(attack_target));

                self.attack_mode = true;
            }
        }


        // SHOOT ITEM SPAWNER
        var item_spawner = noone;
        nearest_distance = 0;
        with (item_spawner_obj) {
            var dist = point_distance(self.x, self.y, other.x, other.y);

            var nearest = false;
            if ((item_spawner == noone || dist < nearest_distance) && !self.invisible && self.holographic == other.holographic) {
                nearest = true;
            }

            if (nearest) {
                item_spawner = id;
                nearest_distance = dist;
            }
        }

        //if(instance_exists(item_spawner) && nearest_distance < ((pl_dist-(160 * clamp(2*self.charge_ball.orb_exhaustion_ratio -1, -1, 1)) || attack_target == noone)) && nearest_distance < 96 * clamp(1/self.charge_ball.orb_exhaustion_ratio, 1, 3))
        if (instance_exists(item_spawner) && instance_exists(self.charge_ball)
            && (nearest_distance < (pl_dist - 160) || attack_target == noone)
            && nearest_distance < clamp(96 / self.charge_ball.orb_exhaustion_ratio, 96, 240)) {
            var block = noone;

            if (instance_exists(item_spawner.my_block)) {
                block = item_spawner.my_block;
            }

            if (instance_exists(block)) {
                self.desired_aim_dir = point_direction(self.x, self.y, block.x + 15, block.y + 15);

                if (self.status_left[? "confusion"] > 0 && !self.npc_counter_confusion) {
                    self.desired_aim_dir = random(360);
                }

                self.desired_aim_dist = 1;

                attack_target = item_spawner;
                ds_list_add(self.attack_targets, attack_target);

                // my_console_log("ITEM SPAWNER TARGET: " + string(attack_target));

                self.attack_mode = true;
            }
        }
    }

    if (instance_exists(waypoint)) {
        attack_waypoint = waypoint;
    }


    // MOVE TARGET RESET
    if (self.npc_stuck && !self.npc_unstuck_done) {
        //my_console_log("reset move target because stuck");
        self.move_target = noone;
    }

    var move_dist = 0;
    if (instance_exists(self.move_target)) {
        move_dist = point_distance(x, y, self.move_target.x, self.move_target.y);
    }

    // MOVE TARGET
    if ((!instance_exists(self.move_target) || move_dist > 960 || move_dist > pl_dist)) //  && self.move_target != my_base
    {
        // COLLECT HEALTH KITS
        if (move_target == noone && (self.damage - self.min_damage) > 1) {
            var near_health = noone;
            var nearest_distance = 0;
            with (health_obj) {
                var dist = point_distance(self.x, self.y, other.x, other.y);
                if (self.my_player != other.my_player && (self.for_player == -1 || self.for_player == other.my_player.number)) {
                    var nearest = false;
                    if (near_health == noone || dist < nearest_distance) {
                        nearest = true;
                    }

                    if (nearest && !self.invisible && self.holographic == other.holographic) {
                        near_health = self.id;
                        nearest_distance = point_distance(self.x, self.y, other.x, other.y);
                    }
                }
            }

            if (instance_exists(near_health) && nearest_distance < pl_dist && nearest_distance < 640) {
                with (near_health) {
                    waypoint = find_nearest_visible_waypoint("move");
                    if (waypoint != noone) {
                        move_target = self.id;
                    }
                }
            }
        }


        // COLLECT BATTERIES
        if (move_target == noone && instance_exists(self.charge_ball)) {
            var near_battery = noone;
            var nearest_distance = 0;
            with (orb_battery_obj) {
                if (self.my_player != other.my_player && (self.for_player == -1 || self.for_player == other.my_player.number) && !self.invisible && self.holographic == other.holographic) {
                    var dist = point_distance(self.x, self.y, other.x, other.y);

                    var nearest = false;
                    if (near_battery == noone || dist < nearest_distance) {
                        nearest = true;
                    }

                    if (nearest) {
                        near_battery = self.id;
                        nearest_distance = point_distance(self.x, self.y, other.x, other.y);
                    }
                }
            }

            if (instance_exists(near_battery) && (nearest_distance < pl_dist / self.charge_ball.orb_exhaustion_ratio)
                && nearest_distance < 640 * clamp(1 / self.charge_ball.orb_exhaustion_ratio, 1, 2)) {
                with (near_battery) {
                    waypoint = find_nearest_visible_waypoint("move");
                    if (waypoint != noone) {
                        move_target = self.id;
                    }
                }
            }
        }


        // COLLECT GRENADES
        var grenades = find_in_inventory(emp_grenade_obj);
        if (instance_exists(grenades)) {
            var grenade_space = grenades.max_stack_size - grenades.stack_size;

            if (move_target == noone && grenade_space > 0) {
                var near_grenade = noone;
                var nearest_distance = 0;
                with (emp_grenade_obj) {
                    if (self.my_player != other.my_player && (self.for_player == -1 || self.for_player == other.my_player.number)
                        && !self.collected && !used && !self.invisible && self.holographic == other.holographic) {
                        var dist = point_distance(self.x, self.y, other.x, other.y);

                        var nearest = false;
                        if (near_grenade == noone || dist < nearest_distance) {
                            nearest = true;
                        }

                        if (nearest) {
                            near_grenade = self.id;
                            nearest_distance = point_distance(self.x, self.y, other.x, other.y);
                        }
                    }
                }

                if (instance_exists(near_grenade) && nearest_distance < pl_dist && nearest_distance < 640) {
                    with (near_grenade) {
                        waypoint = find_nearest_visible_waypoint("move");
                        if (waypoint != noone) {
                            move_target = self.id;
                        }
                    }
                }
            }
        }


        // COLLECT SHARDS

        var inventory_space = free_inv_slot_count();

        if (move_target == noone && (inventory_space > 0 || crystal_will_be_consumed())) {
            var near_crystal = noone;
            var nearest_distance = 0;
            with (crystal_obj) {
                if (self.my_player != other.my_player && (self.for_player == -1 || self.for_player == other.my_player.number)
                    && !self.collected && !self.used && !self.invisible && self.holographic == other.holographic && !is_shielded(self.id)) {
                    var dist = point_distance(self.x, self.y, other.x, other.y);

                    var nearest = false;
                    if (near_crystal == noone || dist < nearest_distance) {
                        nearest = true;
                    }

                    if (nearest) {
                        near_crystal = self.id;
                        nearest_distance = point_distance(self.x, self.y, other.x, other.y);
                    }
                }
            }

            if (instance_exists(near_crystal) && nearest_distance < pl_dist && nearest_distance < self.shard_pickup_range) {
                with (near_crystal) {
                    waypoint = find_nearest_visible_waypoint("move");
                    if (waypoint != noone) {
                        move_target = self.id;
                    }
                }
            }
        }


        self.move_target = move_target;
    }

    // GO TO BASE
    // if (you have crystals in inventory OR (your health is low AND there are already crystals at base)) - see condition in support abi phase (3)

    var crystal = find_in_inventory(crystal_obj);
    if (!self.npc_stuck &&
        (instance_exists(crystal)
            || (base_can_heal_me() && (self.damage > (self.hp - self.min_damage) / 2 || (self.hp - self.min_damage) < 5)))) {
        with (self.my_base) {
            waypoint = find_nearest_visible_waypoint("move");
        }

        self.move_target = self.my_base;
    }
    else {
        if (self.move_target == self.my_base) {
            self.move_target = noone;
            self.npc_waypoint_reached = true;
        }
    }


    //my_console_log("unarmed attack_target: " + string(attack_target));

    /*
    var target, t_i, targets_log = "Targets: ";
    var count = ds_list_size(attack_targets);
    for(t_i = 0; t_i < count; t_i++)
    {
        target = attack_targets[| t_i];
        targets_log += string(target) + ", ";
    }

    my_console_log(targets_log);
    */

    // UNARMED COMBAT
    if (instance_exists(attack_target) && !instance_exists(charge_ball)) {
        //my_console_log("unarmed move_target: " + string(self.move_target));
        // IF NO MOVE TARGET OR SAME AS ATTACK TARGET
        if (!instance_exists(self.move_target) || self.move_target == attack_target) {
            // VS SLIME MOB
            if (object_is_child(attack_target, slime_mob_obj)) {
                var head_stomp_height_max = 256;
                var head_stomp_height_min = head_stomp_height_max - 32;
                var min_dive_height = head_stomp_height_min - 32;
                var x_stomp_range = 48;
                var in_platform = false;
                with (attack_target) {
                    in_platform = place_meeting(self.x, self.y, platform_obj);
                }
                var los_to_stomp_point = npc_line_of_sight(attack_target.x, attack_target.y - head_stomp_height_max, "move");

                if (!in_platform && los_to_stomp_point) {
                    var sideways_correct = abs(x - attack_target.x) < x_stomp_range;
                    var above_target = sideways_correct && y < (attack_target.y - head_stomp_height_min);
                    var can_dive = sideways_correct && y < (attack_target.y - min_dive_height);

                    with (attack_target) {
                        waypoint = find_nearest_visible_waypoint("move");
                    }

                    if (!above_target) {
                        move_target_y_offset = -head_stomp_height_max;
                    }

                    if (can_dive) {
                        npc_wanna_dive = true;
                    }

                    self.move_target = attack_target;
                }
            }
        }
    }

    // IF NO MOVE WAYPOINT, USE ATTACK WP
    if (!instance_exists(waypoint) && instance_exists(attack_waypoint)) {
        waypoint = attack_waypoint;
    }

    // HAS MOVE TARGET
    if (instance_exists(self.move_target)) {
        // GO TO MOVE TARGET
        if (self.npc_destination != self.move_target) {
            self.npc_destination = self.move_target;
        }

        if (instance_exists(waypoint)) {
            self.npc_final_waypoint = waypoint.waypoint_id;
        }

        if (!self.destination_mode && self.npc_destination_reached) {
            self.destination_mode = true;
            self.npc_destination_reached = false;
        }

        //npc_waypoint_reached = false;
        //npc_destination_reached = false;
        self.npc_destination_x = self.move_target.x;
        self.npc_destination_y = self.move_target.y + move_target_y_offset;
    }
    // HAS WAYPOINT
    else if (instance_exists(waypoint)) {
        // KEEP DISTANCE FROM ATTACK TARGET
        if (instance_exists(attack_target) && attack_target.object_index != item_spawner_obj) {
            var waypoints = find_nearest_instances(attack_target, npc_waypoint_obj, 480, "visible", "attack");
            var count = array_length(waypoints);
            var att_dist = point_distance(self.x, self.y, attack_target.x, attack_target.y);
            var min_dist = -1;
            var stay_still = (self.charging || self.casting) && self.npc_destination_reached;

            for (var i = count - 1; i >= 0; i--) {
                var result = waypoints[i];
                var wp = result.id;
                var wp_dist = point_distance(self.x, self.y, wp.x, wp.y);
                var isGoodPosition = is_wp_good_attack_pos(wp, result.distance, att_dist);
                var isClosest = min_dist == -1 || wp_dist < min_dist;
                var isInRange = isClosest && wp_dist < att_dist + 90;

                if (isGoodPosition && (!stay_still || isInRange)) {
                    waypoint = wp;
                    min_dist = wp_dist;

                    if (!stay_still) {
                        break;
                    }
                }
            }

            // debug
            if (object_is_child(requested_attack_target, guy_obj)) {
                for (var i = 0; i < count; i++) {
                    var wp = waypoints[i];
                    requested_attack_target.attack_waypoints[| i] = wp.id;
                }
            }
        }

        // GO TO WAYPOINT
        if (self.npc_final_waypoint != waypoint.waypoint_id) {
            self.npc_final_waypoint = waypoint.waypoint_id;

            self.npc_destination_reached = false;
            self.npc_destination_x = waypoint.x;
            self.npc_destination_y = waypoint.y;
            self.npc_destination = waypoint;
        }
    }

    npc_guy2_step();

    // WANNA DIVE
    if (npc_wanna_dive && !self.have_dived) {
        self.looking_down = true;
        self.wanna_jump = true;
        self.doublejump_count = max(self.doublejump_count, self.max_doublejumps - 1);
    }

    // PHASES 
    self.prev_phase = self.phase;

    if (!self.npc_active) {
        //self.hor_dir_held = false;
        self.wanna_cast = false;
        self.wanna_run = false;
        self.wanna_look = false;
        self.wanna_jump = false;
        self.wanna_abi = false;
        self.looking_up = false;
        self.looking_down = false;

        self.next_phase = 0;
        self.phase = -1;
    }

    self.prev_phase = self.phase;

    // ATTACK TARGET
    self.attack_target = attack_target;

    if (DB.console_mode == CONSOLE_MODE.DEBUG) {
        var att_name = "", move_name = "";

        if (instance_exists(self.attack_target)) {
            att_name = self.attack_target.name;
        }

        if (instance_exists(self.move_target)) {
            move_name = self.move_target.name;
        }

        self.name = "P: " + string(self.phase) + " " + string(self.next_phase) + " " + string(self.color_chosen) + " " + string(self.auto_chosen_orbs); /*"AT:" + att_name + " WP:" + self.npc_final_waypoint + " MO:" + move_name*/
        //name = string(self.phase) + " " + string(self.next_phase) + " A:" + string(self.airborne) + " S:" + string(self.npc_stuck) + " NJ:" + string(self.npc_wanna_jump) + " J:" + string(self.wanna_jump) + " DJ:" + string(self.is_doublejumping) + " CA:" + string(self.wanna_cast);
        //name = string(self.phase) + " " + string(self.next_phase) + " C:" + string(self.status_left[? "confusion"] > 0) + " CC:" + string(self.npc_counter_confusion);
    }
    else {
        if (self.my_player.my_guy == self.id) {
            self.name = self.my_player.name;
        }
    }
}
