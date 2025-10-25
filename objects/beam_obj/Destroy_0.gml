ds_list_destroy(self.beam_nodes);

if (instance_exists(self.beam_end)) {
    instance_destroy(self.beam_end);
}

var shooter = self.my_guy;

if (instance_exists(shooter) && !instance_exists(self.my_holder)) {
    if (object_is_ancestor(shooter.object_index, guy_obj)) {
        self.finishCasting(shooter);
    }

    if (shooter.object_index == beam_turret_mount_obj) {
        shooter.charging = true;
    }
}

if (instance_exists(self.my_ball)) {
    self.my_ball.firing = false;
}

event_inherited();
