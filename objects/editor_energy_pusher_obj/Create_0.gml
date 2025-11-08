var near_pusher = instance_nearest(self.x, self.y, energy_pusher_obj);

if (near_pusher == noone || !(near_pusher.x == self.x && near_pusher.y == self.y)) {
    var new_pusher = instance_create(self.x, self.y, energy_pusher_obj);

    new_pusher.direction = self.image_angle;
    new_pusher.image_angle = self.image_angle;
    new_pusher.tick_phase = 2 * (floor(self.image_angle / 90));
}

instance_destroy();
