event_inherited();

self.energy_tick = 0.5;

self.prev_block_min_energy = DB.terrain_config[? "status_threshold"];
self.my_block_min_energy = DB.terrain_config[? "status_threshold"];

self.prev_block_min_tick_energy = 0.1;
self.my_block_min_tick_energy = 0.1;
