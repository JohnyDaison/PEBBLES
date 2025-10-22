if (self.start_step != singleton_obj.step_count || self.has_collided) {
    self.fading_out = true;
}

if (self.fading_out) {
    self.fade_ratio -= self.fade_speed;

    if (self.fade_ratio <= 0) {
        instance_destroy();
        exit;
    }
}

event_inherited();
