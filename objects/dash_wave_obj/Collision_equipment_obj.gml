if (self.fading_out || other.holographic != self.holographic) {
    exit;
}

self.has_collided = true;

var dashWave = self;
var equipment = other;

// TODO: this logic should be in equipment_obj
with (equipment) {
    if (!equipment.unhittable && receive_damage(dashWave.force)) {
        dashWave.dealt_damage = true;
    }
}

if (equipment.object_index == sprinkler_shield_obj && equipment.my_player != dashWave.my_player) {
    dashWave.my_guy.charge_ball.dash_interrupted = true;
}
