/// @description  MOVEMENT, COLLISION, CHARGING, AUTOFIRE
if (!instance_exists(self.my_guy)) {
    instance_destroy();
    exit;
}


if (self.my_guy != id && self.my_color > -1) {
    // COPY PARAMS
    self.invisible = self.my_guy.invisible;
    self.holographic = self.my_guy.holographic;
    part_system_automatic_draw(self.system, !self.invisible);
    self.desired_angle = self.my_guy.aim_dir;
    self.desired_dist = self.my_guy.aim_dist;
    self.charging = self.my_guy.charging && !self.firing;
    self.autofire = self.my_guy.autofire;
    self.overcharge = self.my_guy.ball_overcharge;
    if (object_is_ancestor(self.my_guy.object_index, guy_obj)) {
        self.overcharge -= self.my_guy.status_left[? "weakness"] / DB.status_effects[? "weakness"].max_charge;
    }
    self.chargerate = self.my_guy.ball_chargerate;
    self.threshold = self.max_charge + self.overcharge;

    self.max_orbs = get_level(self.id, "chargeball");

    // MOVEMENT
    var des_x = lengthdir_x(self.desired_dist, self.desired_angle);
    var des_y = lengthdir_y(self.desired_dist, self.desired_angle);

    var des_dir = point_direction(self.rel_x, self.rel_y, des_x, des_y);
    self.cur_dist = point_distance(self.rel_x, self.rel_y, des_x, des_y);

    var distance_ratio = self.cur_dist / (3 * self.radius);
    self.cur_speed = min(self.cur_dist, self.base_speed * (1 + distance_ratio));

    // continue current movement
    if (self.cur_speed > 0) {
        var dir_diff = angle_difference(des_dir, self.cur_dir);
        self.cur_dir += dir_diff * max(0.01, (1 - (self.charge / self.threshold) * 0.5));
    }

    if (self.cur_speed == 0) {
        // start from center
        if ((self.rel_x == 0 && self.rel_y == 0) || !object_is_ancestor(self.my_guy.object_index, guy_obj)) {
            self.cur_dir = des_dir;
        }
        // start from main directions
        else if (self.rel_x == 0) {
            self.cur_dir = floor((des_dir + 90) / 180) * 180;
        }
        else if (self.rel_y == 0) {
            self.cur_dir = (0.5 + floor(des_dir / 180)) * 180;
        }
        // start from diagonal
        else {
            self.cur_dir = (0.5 + floor(des_dir / 90)) * 90;
        }
    }
    self.cur_dist = point_distance(self.rel_x, self.rel_y, des_x, des_y);


    self.rel_x += lengthdir_x(self.cur_speed, self.cur_dir);
    self.rel_y += lengthdir_y(self.cur_speed, self.cur_dir);

    if (object_is_ancestor(self.my_guy.object_index, guy_obj)) {
        // TERRAIN COL
        if (self.desired_dist > 0) {
            while (is_my_guy_los_blocked(self.rel_x, self.rel_y) && abs(angle_difference(self.desired_angle, point_direction(0, 0, self.rel_x, self.rel_y))) < 90) {
                self.rel_x -= lengthdir_x(5, desired_angle);
                self.rel_y -= lengthdir_y(5, desired_angle);
            }
        }

        // EXHAUSTION
        var new_orb_exhaustion_ratio = get_orb_list_power_level(self.id.orbs);

        if (new_orb_exhaustion_ratio > 0) {
            if (self.my_color != g_dark) {
                if (new_orb_exhaustion_ratio < 1 && new_orb_exhaustion_ratio > DB.orb_exhaustion_threshold) {
                    new_orb_exhaustion_ratio = 1;
                }
                else if (new_orb_exhaustion_ratio <= DB.orb_exhaustion_threshold) {
                    new_orb_exhaustion_ratio = 0.01;
                }
            }

            self.orb_exhaustion_ratio = new_orb_exhaustion_ratio;
        }

        /*
        if (object_is_ancestor(my_guy.object_index, guy_obj) && my_guy.current_slot > 0)
        {
            display_exhaustion_ratio = get_orb_list_power_level(my_guy.color_slots);
        }    
        else
        {
            display_exhaustion_ratio = orb_exhaustion_ratio;
        }*/

        self.display_exhaustion_ratio = self.orb_exhaustion_ratio;
    }
}


self.threshold = (self.max_charge + self.overcharge) * self.orb_exhaustion_ratio;
self.cur_charge_step = self.charge_step * self.chargerate * self.orb_exhaustion_ratio;

// STOP CHARGING IF NO ORBS LEFT
if (object_is_child(self.my_guy, guy_obj) && self.orb_count == 0) {
    self.charging = false;
    self.my_guy.charging = false;
}

// CHARGING
if (self.charging && !self.firing) {
    if (!self.started) {
        self.started = true;
        if (object_is_ancestor(self.my_guy.object_index, guy_obj)) {
            self.my_charge_sound = my_sound_play(charge_sound);
            //my_color = my_guy.my_color;
            //tint_updated = false;
        }
    }

    //audio_sound_pitch(my_charge_sound, DB.colorpitch[? my_color]);

    // CHARGE STEP
    self.cur_charge_step = min(self.cur_charge_step, max(0, self.threshold - self.charge));

    var orb_drain_step = 0;
    if (self.orb_count != 0) {
        orb_drain_step = self.orb_exhaustion_rate * self.cur_charge_step / self.orb_count;
    }

    for (var i = 0; i < self.orb_count; i++) {
        var orb = self.orbs[| i];
        var diff = orb.energy - orb_drain_step;
        var missing_energy = max(0, -diff);
        self.cur_charge_step -= missing_energy / self.orb_exhaustion_rate;
        orb.energy = max(0, diff);
    }

    self.charge = min(self.charge + self.cur_charge_step, self.threshold);

    // FULL CHARGE
    if (self.charge >= self.threshold) {
        // STRUCTURES
        if (self.started && object_is_ancestor(self.my_guy.object_index, structure_obj)) {
            my_sound_stop(self.my_charge_sound);
            self.started = false;
            self.my_guy.charging = false;
        }
    }

    if (self.desired_dist == 0 && self.cur_dist < self.centered_dist) {
        // SHIELD CHANNELING

        self.channeling = false;
        if (instance_exists(self.my_guy) && self.my_guy != id) {
            if (object_is_ancestor(self.my_guy.object_index, guy_obj) && has_level(self.my_guy, "shield", 1)) {
                if (self.my_color > g_dark && self.charge >= threshold && self.my_guy.shield_ready) {
                    var shield = self.my_guy.my_shield;
                    if (instance_exists(shield)) {
                        if (shield.my_color == self.my_color) {
                            var channel_step = self.charge_step * self.channelrate;
                            //var channel_step = cur_charge_step*channelrate;

                            if (shield.threshold > shield.charge) {
                                channel_step = max(0, channel_step - sign(shield.diff) * shield.cur_step);
                            }

                            var diff = (shield.threshold + shield.channel_maxboost) * self.orb_exhaustion_ratio - shield.charge;

                            channel_step = min(channel_step, max(diff, 0));

                            if (channel_step > 0) {
                                shield.charge += channel_step;
                                //self.charge -= cur_charge_step;
                                self.charge -= channel_step;
                            }

                            if (diff >= 0) {
                                shield.channeled = true;
                                self.channeling = true;
                            }
                        }
                    }
                    else {
                        trigger(self.id);
                    }
                }
            }
        }
    }
}
else {
    if (self.started) {
        my_sound_stop(self.my_charge_sound);
        self.started = false;
    }

    // FIRING
    if (self.firing) {
        // STOP ON LOST CONTROL
        if (object_is_ancestor(self.my_guy.object_index, guy_obj)) {
            if (self.my_guy.lost_control) {
                self.firing = false;
                self.dash_steps_left = 0;
                self.my_guy.air_dashing = false;
                self.alarm[1] = -1;
            }
        }

        // DASHWAVE
        if (self.dash_steps_left > 0 && self.firing) {
            var dir = point_direction(0, 0, self.rel_x, self.rel_y);
            var xx = lengthdir_x(self.dash_dist, dir);
            var yy = lengthdir_y(self.dash_dist, dir);
            var safe = false;

            self.charge = 0;

            with (self.my_guy) {
                var next_x = self.x + self.hspeed + xx;
                var next_y = self.y + self.vspeed + yy;
                var sprinkler_shield = instance_place(next_x, next_y, sprinkler_shield_obj);
                var energy_shield = instance_place(next_x, next_y, shield_obj);

                if (!place_meeting(next_x, next_y, terrain_obj)
                    && !place_meeting(next_x, next_y, gate_field_obj)
                    && (sprinkler_shield == noone || sprinkler_shield.my_guy == self.id)
                    && (energy_shield == noone || !iff_check("shield_will_push_me", self.id, energy_shield))) {
                    safe = true;
                }
            }

            if (safe && !self.dash_interrupted) {
                if (self.my_guy.airborne) {
                    self.my_guy.vspeed -= self.my_guy.gravity;
                    self.my_guy.y -= self.my_guy.gravity;
                }

                self.my_guy.x += xx;
                self.my_guy.y += yy;

                self.x += xx;
                self.y += yy;

                self.dash_steps_left--;

                var inst = instance_create(self.x, self.y, dash_wave_obj);
                inst.image_angle = dir;
                inst.my_player = self.my_player;
                inst.dash_dist = self.dash_dist;
                inst.my_color = self.my_color;
                inst.tint_updated = false;
                inst.my_guy = self.my_guy.id;
                inst.my_source = self.object_index;
                inst.holographic = self.holographic;

                if (self.dash_steps_left == 0) {
                    inst.force = self.trig_charge * self.dash_end_ratio;
                    inst.knockback = true;
                }
                else {
                    inst.force = self.trig_charge * self.dash_step_ratio;
                    inst.image_xscale = 0.5;
                    inst.image_yscale = 0.5;
                }
            }

            if (!safe || self.dash_interrupted) {
                self.dash_steps_left = 0;
            }

            if (self.dash_steps_left <= 0) {
                self.firing = false;
                self.my_guy.air_dashing = false;

                self.my_guy.hspeed += xx * self.trig_charge / 4;
                self.my_guy.vspeed += yy * self.trig_charge / 4;
            }
        }
    }
    else {
        // ALL BUT STRUCTURES LOSE CHARGE
        if (!object_is_ancestor(self.my_guy.object_index, structure_obj)) {
            if (self.charge > 0) {
                self.charge -= self.cur_charge_step;
                /*
                for(i = 0; i < orb_count; i++) 
                {
                    var orb = orbs[| i];
                    orb.direct_input_buffer += cur_charge_step / orb_count;
                }
                */
            }
        }
    }
}

if (self.charge < 0)
    self.charge = 0;

if (self.my_guy != id) {
    self.charge = min(self.charge, self.threshold);
}

// AUTOFIRE
if (self.charge >= self.threshold && self.autofire) {
    trigger(self.id);
}

self.energy = self.charge;
self.dash_interrupted = false;
