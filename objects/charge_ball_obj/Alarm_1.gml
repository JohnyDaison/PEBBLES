/// @description  BARRAGE SHOT
if (instance_exists(self.my_guy)) {
    var force = self.charge;

    if (force >= self.small_charge) {
        force = self.small_charge;
    }

    var inst = create_energy_ball(self.id, "small_bolt", self.my_color, force);
    inst.direction = point_direction(0, 0, self.rel_x, self.rel_y);

    if (object_is_ancestor(self.my_guy.object_index, guy_obj) && self.my_guy.my_player.my_guy == self.my_guy) {
        viewshake(self.my_player.my_camera, inst.direction + 180, 3);
    }

    if (self.desired_dist != 0) {
        inst.speed = 3 + 6 * self.trig_charge * point_distance(0, 0, self.rel_x, self.rel_y) / self.desired_dist;
    }
    else {
        inst.speed = 3 + 6 * self.trig_charge;
    }


    var hboost = -inst.hspeed / 50;
    var vboost = -inst.vspeed / 50;

    addSourceVelocityToProjectile(self.my_guy, inst);

    if (self.my_guy != self.id && !self.my_guy.immovable) {
        with (self.my_guy) {
            self.hspeed += hboost;

            if (vboost <= 0 || !place_meeting(self.x, self.y + 1, terrain_obj)) {
                self.vspeed += vboost;
            }
        }
    }

    if (object_is_ancestor(self.my_guy.object_index, guy_obj)) {
        inst.guided = true;
    }
    /*
    inst.my_color = self.my_color;
    inst.tint_updated = false;
    */
    self.charge -= force;
    //show_debug_message("BARRAGE left: " +string(charge));
}

if (self.charge > 0) {
    self.alarm[1] = self.shot_delay;
}
else {
    self.firing = false;
}
