/// BOUNCE, FALLING

// BOUNCE
if (self.bounced || self.corner_bounced) {
    self.x += self.x_return;
    self.y += self.y_return;
}

/*if(!place_meeting(x,y, solid_terrain_obj))
{*/
self.bounced = false;
//}


// START FALLING IF STOPPED
if (self.speed < 0.5) {
    self.was_stopped = true;
    self.is_resting = false;

    var ter = instance_nearest(self.x - 16, self.y, solid_terrain_obj);

    if (!self.is_resting && instance_exists(ter)
        && place_meeting(self.x, self.y + 1, ter) && !place_meeting(self.x, self.y - self.core_radius, ter)) {
        self.is_resting = true;
    }

    if (!self.is_resting) {
        var other_smoke = instance_place(self.x, self.y + 1, energy_smoke_obj);

        if (instance_exists(other_smoke) && other_smoke.y > self.y) {
            self.is_resting = true;
        }
    }
}

if (!self.is_resting) {
    self.gravity = self.fall_gravity;
}
else {
    self.gravity = 0;
}

if (singleton_obj.step_count mod 10 == 0 && random(1) < 0.2) {
    self.image_index = irandom(self.image_number - 1);
}

// LIGHT BOOST
self.ambient_light = self.orig_ambient_light * self.light_boost;
self.direct_light = self.orig_direct_light * self.light_boost;
self.light_boost = 1;


self.consolidated = false;

event_inherited();
