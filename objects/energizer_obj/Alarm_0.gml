with (wall_obj) {
    if (!place_meeting(self.x, self.y, other)) {
        continue;
    }

    if (other.custom_energy) {
        self.energy = other.energy;
    }
    else {
        self.energy = max(self.energy, self.outburst_threshold);
    }
}

instance_destroy();
