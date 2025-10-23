var deenergizer = self;

with (wall_obj) {
    if (!place_meeting(self.x, self.y, deenergizer)) {
        exit;
    }

    if (deenergizer.go_dark) {
        self.energy = 0;
        self.my_next_color = g_dark;
    }
    else {
        self.energy = min(self.energy, 0.001);
    }
}

instance_destroy();
