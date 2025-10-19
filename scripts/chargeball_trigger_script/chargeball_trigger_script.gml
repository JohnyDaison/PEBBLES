/// @self charge_ball_obj
/// @returns {Bool} did it fire successfully?
function chargeball_trigger_script() {
    var ret = false;
    //show_debug_message("TRIGGER chargeball");
    if (instance_exists(self.my_guy) && self.my_color >= g_dark && !self.firing && self.charge > 0) {
        var aim_direction = point_direction(0, 0, self.rel_x, self.rel_y);

        self.trig_charge = self.charge;

        self.my_guy.casting = false;
        self.my_guy.casting_hor = false;
        self.my_guy.casting_shield = false;
        self.my_guy.casting_up = false;
        self.my_guy.casting_down = false;

        var orb_count = 0;
        var is_guy = false;
        var is_player_guy = false;

        if (object_is_ancestor(self.my_guy.object_index, guy_obj)) {
            orb_count = self.orb_count;
            is_guy = true;

            if (self.my_guy.id == self.my_player.my_guy) {
                is_player_guy = true;
            }
            // show_debug_message("orb_count: " + string(orb_count) + " my_color: " + string(my_color));
        }
        else {
            orb_count = self.my_guy.slots_absorbed;
        }

        if (self.my_color == g_dark) {
            if (orb_count > 0 && (!is_guy || has_level(self.my_guy, "dark_mode", 1))) {
                if (self.desired_dist == 0) {
                    // DARK AOE
                    var inst = instance_create(self.x, self.y, black_aoe_obj);

                    inst.my_player = self.my_player;
                    inst.force = self.charge;
                    inst.my_color = self.my_color;
                    inst.my_guy = self.my_guy.id;
                    inst.my_source = self.object_index;
                    inst.holographic = self.holographic;

                    if (self.my_guy != self.id && !self.my_guy.immovable) {
                        self.my_guy.speed /= self.my_guy.running_maxspeed * 2;
                    }

                    ret = true;

                    if (is_player_guy) {
                        increase_stat(self.my_guy.my_player, "implosion_count", 1, false);
                    }
                }
                else {
                    // VORTEX
                    var inst = instance_create(self.x, self.y, black_projectile_obj);

                    inst.my_player = self.my_player;
                    inst.force = self.charge;
                    inst.holographic = self.holographic;

                    inst.direction = aim_direction;
                    inst.speed = 5 + 9 * self.charge;
                    inst.my_color = self.my_color;
                    inst.my_guy = self.my_guy.id;
                    inst.my_source = self.object_index;

                    if (self.my_guy != id && !self.my_guy.immovable) {
                        self.my_guy.hspeed /= 4;
                        self.my_guy.vspeed /= 4;
                    }

                    ret = true;

                    if (is_player_guy) {
                        increase_stat(self.my_guy.my_player, "vortex_count", 1, false);
                    }
                }
            }
        }
        else {
            if (self.desired_dist == 0) {
                // SHIELD
                if (object_is_ancestor(self.my_guy.object_index, guy_obj)) {
                    if (has_level(self.my_guy, "shield", 1) && !self.my_guy.berserk && self.my_guy.shield_ready) {
                        var play_shield_sound = false;

                        if (self.my_guy.my_shield == noone) {
                            var inst = instance_create(self.my_guy.x, self.my_guy.y, shield_obj);

                            inst.my_guy = self.my_guy.id;
                            inst.my_source = self.object_index;
                            inst.my_player = self.my_player;
                            inst.charge = self.charge;
                            inst.max_charge = self.my_guy.shield_max_charge;
                            inst.channel_maxboost = self.my_guy.shield_channel_maxboost;
                            inst.size_coef = self.my_guy.shield_size;
                            inst.my_color = self.my_color;
                            inst.holographic = self.holographic;

                            self.my_guy.my_shield = inst.id;

                            play_shield_sound = true;

                            ret = true;
                        }
                        else {
                            self.my_guy.my_shield.charge += self.charge * self.channelrate;
                            play_shield_sound = true;

                            if (self.my_guy.my_shield.my_color != self.my_color) {
                                self.my_guy.my_shield.my_color = self.my_color;
                                self.my_guy.my_shield.tint_updated = false;
                            }

                            ret = true;
                        }

                        if (ret) {
                            if (is_player_guy) {
                                increase_stat(self.my_guy.my_player, "shield_count", 1, false);
                            }

                            if (play_shield_sound) {
                                my_sound_play(shield_sound);
                            }

                            self.my_guy.casting_shield = true;
                        }
                    }
                    else {
                        my_sound_play(failed_sound);
                    }
                }
            }
            else if (!is_guy || self.my_guy.status_left[? "suppressed"] == 0) {
                // BIG BOLT
                if (orb_count == 1 && (!is_guy || has_level(self.my_guy, "blast_mode", 1))) {
                    var inst = create_energy_ball(id, "big_bolt", self.my_color, self.charge);

                    inst.direction = aim_direction;
                    inst.speed = 3 + 7 * self.charge;

                    if (is_player_guy) {
                        viewshake(self.my_player.my_camera,
                            point_direction(inst.hspeed, inst.vspeed, 0, 0), 5);
                    }

                    var hboost = -inst.hspeed / 10;
                    var vboost = -inst.vspeed / 10;

                    addSourceVelocityToProjectile(self.my_guy, inst);

                    if (self.my_guy != self.id && !self.my_guy.immovable) {
                        with (self.my_guy) {
                            self.hspeed += hboost;

                            if (vboost <= 0 || !place_meeting(self.x, self.y + 1, terrain_obj)) {
                                self.vspeed += vboost;
                            }
                        }
                    }

                    ret = true;

                    if (is_player_guy) {
                        increase_stat(self.my_guy.my_player, "blast_count", 1, false);
                    }
                }

                // BARRAGE
                if (orb_count == 2 && (!is_guy || has_level(self.my_guy, "barrage_mode", 1))) {
                    self.firing = true;
                    event_perform(ev_alarm, 1);

                    ret = true;

                    if (is_player_guy) {
                        increase_stat(self.my_guy.my_player, "barrage_count", 1, false);
                    }
                }

                // DASHWAVE

                if (orb_count == 3 && (!is_guy || has_level(self.my_guy, "dashwave_mode", 1))) {
                    if (!self.my_guy.airborne) {
                        self.my_guy.y -= 1;
                        self.y -= 1;
                    }

                    var inst = instance_create(self.x, self.y, dash_wave_obj);

                    inst.image_angle = aim_direction;
                    inst.image_xscale = 0.5;
                    inst.image_yscale = 0.5;
                    inst.dash_dist = self.dash_dist;
                    inst.my_player = self.my_player;
                    inst.force = self.charge * self.dash_step_ratio;
                    inst.my_color = self.my_color;
                    inst.tint_updated = false;
                    inst.my_guy = self.my_guy.id;
                    inst.my_source = self.object_index;
                    inst.holographic = self.holographic;

                    self.my_guy.air_dashing = true;
                    self.my_guy.speed *= 0.5;

                    self.firing = true;
                    self.dash_steps_left = ceil(min(self.charge + 0.25, 1.25) * self.dash_base_steps);

                    ret = true;

                    if (is_player_guy) {
                        increase_stat(self.my_guy.my_player, "dashwave_count", 1, false);
                    }
                }


                // BEAM

                if (orb_count == 5) {
                    var inst = instance_create(self.x, self.y, beam_obj);

                    inst.facing_right = self.my_guy.facing_right;
                    inst.my_player = self.my_player;
                    inst.force = self.charge;
                    inst.orig_force = self.charge;
                    inst.my_color = self.my_color;
                    inst.my_guy = self.my_guy.id;
                    inst.my_source = self.object_index;
                    inst.my_ball = self.id;
                    inst.holographic = self.holographic;

                    self.my_guy.my_beam = inst;
                    self.my_guy.casting_beam = true;
                    self.firing = true;

                    ret = true;
                }

                // ARTILLERY SHOT
                if (orb_count == 4) {
                    var inst = create_energy_ball(self.id, "artillery_shot", self.my_color, self.max_charge + self.overcharge);

                    inst.hspeed = self.rel_x;
                    inst.vspeed = self.rel_y;
                    inst.speed = 5 + 7 * self.charge;
                    inst.tracked = true;

                    if (self.my_guy != self.id && !self.my_guy.immovable) {
                        self.my_guy.hspeed -= inst.hspeed / 10;
                        self.my_guy.vspeed -= inst.vspeed / 10;
                    }

                    if (self.my_guy.object_index == cannon_base_obj) {
                        increase_stat(self.my_guy.my_player, "cannon_shots", 1, false);

                        if (self.my_guy.my_guy.seated) {
                            var cam = self.my_guy.my_player.my_camera;
                            if (instance_exists(cam)) {
                                cam.follow_shot = true;
                                cam.follow_guy = false;
                                cam.my_shot = inst.id;
                            }
                        }
                    }

                    ret = true;
                }
            }
        }

        if (ret) {
            self.my_guy.casting = true;
            if (!self.my_guy.casting_shield) {
                if (abs(self.rel_x) > abs(self.rel_y)) {
                    self.my_guy.casting_hor = true;
                } else {
                    self.my_guy.casting_up = self.rel_y < 0;
                    self.my_guy.casting_down = self.rel_y > 0;
                }
            }

            if (is_player_guy) {
                increase_stat(self.my_guy.my_player, "spells", 1, false);
                increase_stat(self.my_guy.my_player, "spells" + string(self.my_color), 1, false);
                increase_stat(self.my_guy.my_player, "spellstreak", 1, false);
                increase_stat(self.my_guy.my_player, "combo", 1, false);
            }

            // CANNON COLOR CYCLING
            if (self.my_guy.object_index == cannon_base_obj) {
                with (self.my_guy) {
                    if (self.shot_color > g_dark) {
                        self.orbs[? self.shot_color] -= 1;
                    }

                    // NEXT SHOT COLOR
                    var next_shot_color = self.shot_color,
                        orb_found = false, colors_tried = 0;

                    do {
                        next_shot_color--;
                        if (next_shot_color == g_yellow) next_shot_color = g_green;
                        if (next_shot_color < g_red)
                            next_shot_color = g_blue;

                        if (self.orbs[? next_shot_color] >= 1) {
                            self.shot_color = next_shot_color;
                            self.slots_absorbed = 4;
                            orb_found = true;
                        }
                        colors_tried++;
                    }
                    until(orb_found || colors_tried >= 3)
                
                    if (!orb_found) {
                        self.shot_color = g_dark;
                        self.slots_absorbed = 0;
                    }
                }

                self.my_color = self.my_guy.shot_color;
                self.tint_updated = false;
            }
        }

        if (!self.firing) {
            self.charge = 0;
        }

        self.my_guy.charging = false;
        my_sound_stop(self.my_charge_sound);
        self.started = false;
    }

    return ret;
}
