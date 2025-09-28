event_inherited();

// FALLING
if (!self.immovable) {
    self.gravity_direction = 270;
    self.gravity = 0;
    self.friction = 0;
    self.speed = min(self.speed, self.max_speed);

    if (self.airborne) {
        self.gravity = 0.04;
        self.friction = 0.01;

        if (self.y > self.room_height + 32) {
            instance_destroy();
        }

        if (place_meeting(self.x + self.hspeed, self.y + self.vspeed, terrain_obj)) {
            if (abs(self.speed) >= 1) {
                my_move_bounce(terrain_obj);
                self.vspeed *= 0.25;
                self.hspeed *= 0.6;
                /*
                if(hspeed == 0)
                {
                    hspeed += (sign(random(2)-1)*(random(0.4)+0.2)*speed);
                }
                */
                var nearest_guy = instance_nearest(self.x, self.y, player_guy);
                if (nearest_guy != noone) {
                    if (point_distance(self.x, self.y, nearest_guy.x, nearest_guy.y) < DB.sound_cutoff_dist) {
                        my_sound_play(hit_ground_sound, true);
                        // TODO: Add structure_bounce_sound
                    }
                }
            }
            else {
                self.y -= 32;
                self.speed = 0;
                self.gravity = 0;
                self.airborne = false;
                self.immovable = true;
            }
        }
    }
    else {
        if (!place_meeting(self.x, self.y + 2, terrain_obj)) {
            self.airborne = true;
        }
    }
}

// ADD CHARGEBALL
if (!instance_exists(self.charge_ball)) {
    self.my_guy = self.my_player.my_guy;

    if (instance_exists(self.my_guy)) {
        var inst = instance_create(self.x, self.y - 128, charge_ball_obj);
        inst.my_guy = id;
        inst.my_player = self.my_player;
        inst.bar_height = 8;
        self.charge_ball = inst;
    }
}

// MAIN CYCLE
if (!self.destroyed && instance_exists(self.my_guy)) {
    self.my_camera = self.my_guy.my_player.my_camera;
    if (self.my_camera == noone) {
        self.my_camera = main_camera_obj.id;
    }

    // POSITION GUI RELATIVE TO CAMERA
    if (instance_exists(self.my_camera) && self.my_camera.on) {
        self.gui_x = self.my_camera.view_x + self.my_camera.width - 112; //144
        self.gui_y = self.my_camera.view_y + 136;
    }

    // GUY INTERACTION
    if (position_meeting(self.x, self.y, self.my_guy) && self.immovable
        && !(self.my_guy.looking_down && !self.my_guy.wanna_cast)
        && !self.my_guy.jumping_down) {
        self.draw_label = false;

        // LOADING ORBS
        var sound_played = false, full_count = 0;
        for (var i = g_red; i <= g_blue; i++) {
            if (i == g_yellow) continue;

            if (self.orbs[? i] >= 99) {
                full_count++;
            }

            if (self.my_guy.orb_reserve[? i] >= 1 && orbs[? i] < 99) {
                self.orbs[? i] += 1;
                self.my_guy.orb_reserve[? i] -= 1;
                self.orb_light[? i] = 1;
                self.my_player.stats[? "total_orbs"] += 1;

                if (!sound_played) {
                    my_sound_play(slot_absorbed_sound);
                    sound_played = true;
                }

                switch (i) {
                    case g_red:
                        self.my_player.stats[? "red_orbs"] += 1;
                        break;
                    case g_green:
                        self.my_player.stats[? "green_orbs"] += 1;
                        break;
                    case g_blue:
                        self.my_player.stats[? "blue_orbs"] += 1;
                        break;
                }

                // RECOVER FROM NO AMMO
                if (self.shot_color == g_dark) {
                    self.shot_color = i;
                    self.slots_absorbed = 4;
                    self.charge_ball.my_color = i;
                    self.charge_ball.tint_updated = false;
                }
            }
        }

        // CANNON EASTER EGG 
        if (full_count >= 3 && self.immovable) {
            if (self.my_guy.orb_reserve[? g_red] > 0 || self.my_guy.orb_reserve[? g_green] > 0 || self.my_guy.orb_reserve[? g_blue] > 0) {
                self.immovable = false;
                self.vspeed = -1;
                self.my_guy.seated = false;

                var inst = instance_create(self.x, self.y, slot_explosion_obj);
                inst.my_color = self.my_color;
                inst.my_source = self.object_index;

                my_sound_play(wall_crumble_sound);
                viewshake(self.my_player.my_camera, 270, 15);
            }
        }

        // AIMING
        if (self.my_guy.seated && self.my_guy.aim_dist > 0 && self.my_guy.wanna_cast) {
            var base_rel_dir = (self.aim_dir - self.base_angle + 180) mod 360 - 180;
            var rel_dir = (self.my_guy.aim_dir - self.aim_dir + 180) mod 360 - 180;
            var cur_aim_speed = self.aim_speed * ((rel_dir div 45) + sign(rel_dir));

            if (cur_aim_speed > abs(rel_dir)) {
                cur_aim_speed = rel_dir;
            }

            if (abs(base_rel_dir + cur_aim_speed) <= (self.angle_range / 2)) {
                self.aim_dir += cur_aim_speed;
                self.aim_dir = self.aim_dir mod 360;
            }
        }
    }
    else {
        // THROW GUY OUT AND RETURN TO NORMAL CAMERA
        self.my_guy.seated = false;
        var camera = self.my_player.my_camera;
        if (camera != noone && camera.follow_shot) {
            camera.follow_shot = false;
            camera.follow_guy = true;
        }
    }

    // CHARGING START
    if (!self.draw_label && self.charge_ball.charge == 0 && self.shot_color != g_dark) {
        self.charging = true;
    }

    // FIRING   
    if (self.my_guy.fire_cannon) {
        if (self.shot_color == g_dark) {
            var inst = instance_create(self.x, self.y, text_popup_obj);
            inst.str = "OUT OF AMMO!";
            inst.my_color = g_red;
            self.ammo_popup = inst;

            my_sound_play(cannon_no_ammo_sound);

            self.my_guy.fire_cannon = false;
        }

        self.autofire = my_guy.fire_cannon;
    }
    else {
        self.autofire = false;
    }

    // SHIELD RECHARGE
    if (!instance_exists(self.my_shield) && self.shield_ready) {
        var my_shield = instance_create(self.x, self.y, shield_obj);
        my_shield.my_guy = self.id;
        my_shield.my_source = self.object_index;
        my_shield.max_charge = self.shield_power - self.shield_overcharge;
        my_shield.charge = self.shield_power;
        my_shield.size_coef = 1.2;
        my_shield.low_charge_ratio = 0.5;
        my_shield.field_power = 2;
        my_shield.my_color = self.shield_color;
        my_shield.my_player = self.my_player;
        self.my_shield = my_shield;

        my_sound_play(shield_ready_sound);
    }
}
else {
    // DON'T FIRE WHEN NOT VALID
    self.autofire = false;
}

// BARREL ANIM
if (self.shot_color > g_dark && self.charging) {
    self.barrel_anim_index = (self.barrel_anim_index + self.barrel_anim_speed) mod self.barrel_anim_length;
}
else {
    self.barrel_anim_index = 0;
}

// ORB FADING
for (var col = g_red; col <= g_blue; col++) {
    if (col == g_yellow) continue;

    if (self.orb_light[? col] > 0)
        self.orb_light[? col] -= 0.01;
}

// DESTRUCTION
if (self.damage >= self.hp && !self.destroyed) {
    self.destroyed = true;
    instance_destroy();
}
