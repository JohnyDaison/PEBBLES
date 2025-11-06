if (self.sprite_index == wall_burst_end_spr) {
    instance_destroy();
}

if (self.sprite_index == wall_burst_loop_spr) {
    if (self.done_for) {
        self.sprite_index = wall_burst_end_spr;
    }
}

if (self.sprite_index == wall_burst_start_spr) {
    if (!self.done_for) {
        self.sprite_index = wall_burst_loop_spr;
    }
    else {
        self.sprite_index = wall_burst_end_spr;
    }
}
