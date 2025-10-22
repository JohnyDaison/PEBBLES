if (self.fading_out || other.holographic != self.holographic) {
    exit;
}

self.has_collided = true;

var dashwave = self;
var shield = other;
var shieldHolder = other.my_guy;

if (!instance_exists(shieldHolder) || shieldHolder == shield.id) {
    exit;
}

if (shield.my_player == dashwave.my_player && dashwave.my_player != gamemode_obj.environment) {
    exit;
}

with (shieldHolder) {
    // PREVENT DUPLICATE DAMAGE
    if (place_meeting(shieldHolder.x, shieldHolder.y, dashwave)) {
        break;
    }

    if (receive_damage(dashwave.force)) {
        dashwave.dealt_damage = true;
    }
}
