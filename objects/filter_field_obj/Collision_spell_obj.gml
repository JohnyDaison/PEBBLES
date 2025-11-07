if (!self.isValidCollision(other, true)) {
    exit;
}

var filterable = (other.my_color & self.my_color) == self.my_color;

if (object_is_ancestor(other.object_index, energyball_obj)) {
    if (filterable) {
        other.my_color = self.my_color;
        other.tint_updated = false;
        other.force *= 0.5;
    }
    else {
        other.collided = true;
    }
}
else if (other.object_index == shield_obj) {
    if (filterable) {
        other.my_color = self.my_color;
        other.tint_updated = false;
        other.charge *= 0.5;
    }
    else {
        other.charge -= 0.01;
    }
}
else if (other.object_index == dash_wave_obj) {
    if (filterable) {
        other.my_color = self.my_color;
        other.tint_updated = false;
        other.force *= 0.5;
    }
    else {
        other.dealt_damage = true;
        other.fading_out = true;
    }
}
else if (other.object_index == energy_smoke_obj) {
    if (filterable) {
        other.my_color = self.my_color;
        other.tint_updated = false;
        other.force *= 0.5;
    }
    else {
        other.force -= 4 * other.force_decay;
        other.force = max(0, other.force);
    }
}
