if (!self.done_for && instance_exists(self.my_guy) && !position_meeting(self.x, self.y, solid_terrain_obj)) {
    if (!self.my_guy.tint_updated) {
        self.my_color = self.my_guy.my_color;
        self.tint_updated = false;
    }

    // this should be constant
    // energy = my_guy.energy / ( (my_guy.burst_count + my_guy.spread_count) * 4 );

    if (!self.my_guy.bursting) {
        self.done_for = true;
    }
}
else {
    self.done_for = true;
}

event_inherited();
