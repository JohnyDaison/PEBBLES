/// @description SMOKE
if (instance_exists(self.my_guy)) {
    var inst = instance_create(x + irandom(10) - 5, y + irandom(10) - 5, energy_smoke_obj);
    inst.my_player = self.my_guy.my_player;
    inst.my_guy = self.my_guy.id;
    inst.my_source = self.object_index;
    inst.holographic = self.holographic;
    inst.direction = point_direction(0, 0, self.rel_x, self.rel_y);

    if (charge >= smoke_charge) {
        inst.force = smoke_charge;
    } else {
        inst.force = charge;
    }

    inst.max_force = inst.force;

    var distance_ratio = 1;
    if (self.desired_dist != 0) {
        distance_ratio = point_distance(0, 0, self.rel_x, self.rel_y) / self.desired_dist;
    }

    inst.speed = 5 + 3 * self.trig_charge * distance_ratio;

    inst.hspeed += self.my_guy.hspeed;
    inst.vspeed += self.my_guy.vspeed;

    inst.my_color = g_octarine;
    inst.tint_updated = false;
    self.charge -= inst.force;
}

if (self.charge > 0) {
    self.alarm[4] = self.smoke_delay;
}
else {
    self.firing = false;
}
