if (self.fading_out) {
    exit;
}

self.has_collided = true;

var dashWave = self;

// TODO: this logic should be on artifact_obj
with (other) {
    if (receive_damage(dashWave.force)) {
        event_perform(ev_other, ev_user1);
        self.speed = (5 / 6) * self.speed;

        dashWave.dealt_damage = true;
    }
}
