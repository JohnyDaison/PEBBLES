if (!instance_exists(self.my_block)) {
    if (self.my_block != noone) {
        instance_destroy();
    }

    exit;
}

if (singleton_obj.step_count <= self.tick_delay || (singleton_obj.step_count mod self.tick_delay) != self.tick_phase) {
    exit;
}

var prev = self.my_block.near_walls[? ((self.direction + 180) mod 360)/90];
var next = self.my_block.near_walls[? self.direction / 90];

push_block_energy(self.my_block, next,
    self.my_block_min_tick_energy, self.energy_tick,
    self.my_block_min_energy, self.next_block_max_energy);

if (instance_exists(prev) && !prev.has_pusher) {
    push_block_energy(prev, self.my_block,
        self.prev_block_min_tick_energy, self.energy_tick,
        self.prev_block_min_energy, self.my_block_max_energy);
}

if (self.my_block.my_color > g_dark || self.my_block.my_next_color > g_dark) {
    self.my_color = g_white;
}
else {
    self.my_color = g_dark;
}

self.tint_updated = false;
