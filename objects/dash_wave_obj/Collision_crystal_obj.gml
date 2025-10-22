if (self.fading_out || other.holographic != self.holographic) {
    exit;
}

self.has_collided = true;

var dashWave = self;

with (other) {
    if (receive_damage(dashWave.force)) {
        dashWave.dealt_damage = true;
    }
}
