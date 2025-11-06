/// @description DETECT LEAVING GUY'S COLLISION, DESTROY ITSELF IF OUTSIDE OF PLACE, CORNER BOUNCE, PARTICLE BURST
has_left_step();

// TODO: optimize, place_obj should always exist
// DESTROY ITSELF IF OUTSIDE OF PLACE
if (instance_exists(gamemode_obj.world) && instance_exists(gamemode_obj.world.current_place)) {
    var place = gamemode_obj.world.current_place;

    if (self.x + self.radius < place.x //|| y+radius < place.y
        || self.x - self.radius > place.x + place.width
        || self.y - self.radius > place.y + place.height) {
        self.collided = true;
        //my_console_log("Energy ball out of bounds DESTROYED");
    }
}
else {
    if (self.x + self.radius < 0 //|| y+radius < 0
        || self.x - self.radius > room_width
        || self.y - self.radius > room_height) {
        self.collided = true;
        //my_console_log("Energy ball out of bounds DESTROYED");
    }
}


// CORNER BOUNCE
if (self.corner_bounced) {
    if (!self.collided && !self.bounced) {
        if (!place_meeting(self.x + self.hspeed + self.hchange, self.y + self.vspeed + self.vchange, solid_terrain_obj)) {
            //self.orig_speed = self.speed;
            self.hspeed += self.hchange;
            self.vspeed += self.vchange;

            if (self.orig_speed + self.speed_delta > 0.2) {
                self.speed = self.orig_speed + self.speed_delta;

                if (instance_exists(self.last_wall_hit) && self.holographic == self.last_wall_hit.holographic) {
                    self.last_wall_hit.energy += self.energy_delta;
                }
            }
            else {
                self.vspeed = 0;
                self.gravity = 0;
            }

            my_sound_play_colored(shot_bounce_sound, self.my_color, false, self.sound_volume);
            //show_debug_message("corner bounce applied");
        }
        else {
            if (self.speed + self.speed_delta > 0.2) {
                self.speed += self.speed_delta;

                if (instance_exists(self.last_wall_hit) && self.holographic == self.last_wall_hit.holographic) {
                    self.last_wall_hit.energy += self.energy_delta;
                }
            }
            else {
                self.vspeed = 0;
                self.gravity = 0;
            }
        }
    }

    self.corner_bounced = false;
}


// PARTICLE BURST
if (self.make_particles) {
    part_emitter_burst(self.system, self.em, self.pt, self.particle_count);
    part_system_automatic_draw(self.system, !self.invisible);
}
