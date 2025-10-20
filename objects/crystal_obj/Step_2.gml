if (instance_exists(self.my_shield)) {
    self.my_shield.x = self.x;
    self.my_shield.y = self.y - self.hover_offset - self.step;
}

if (self.my_guy.object_index == guy_spawner_obj) {
    var current_distance = self.my_distance * self.fade_counter;
    var xx = self.my_guy.x + (cos(self.my_angle) * current_distance);
    var yy = self.my_guy.y - (sin(self.my_angle) * current_distance);

    self.direction = point_direction(self.x, self.y, xx, yy);
    self.speed = self.orbiting_lerp_ratio * point_distance(self.x, self.y, xx, yy);

    self.visible = true;
}

event_inherited();
