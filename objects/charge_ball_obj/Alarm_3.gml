/// @description ROTATE ORBS
self.orb_rot_speed = lerp(self.orb_min_rot_speed, self.orb_max_rot_speed, self.charge);
self.orb_angle_offset += self.orb_rot_speed;

if (self.orb_angle_offset >= 1) {
    self.orb_angle_offset -= 1;
}

var tau = 2 * pi;
for (var i = 0; i < self.orb_count; i++) {
    var orb = self.orbs[| i];
    orb.my_angle = tau * (self.orb_angle_offset + i / self.orb_count);
}

self.alarm[3] = 1;
