event_inherited();

self.image_speed = 0;
self.tick_delay = 10;
self.tick_phase = 0;
self.energy_tick = 2;
self.multicolor = true;

self.prev_block_min_energy = 0;
self.my_block_min_energy = 0;

self.prev_block_min_tick_energy = 0;
self.my_block_min_tick_energy = 0;

self.my_block_max_energy = DB.terrain_config[? "outburst_threshold"];
self.next_block_max_energy = DB.terrain_config[? "outburst_threshold"];

self.alarm[1] = 2;
