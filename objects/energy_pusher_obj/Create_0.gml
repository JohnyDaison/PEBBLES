event_inherited();

image_speed = 0;
tick_delay = 10;
tick_phase = 0;
energy_tick = 2;
multicolor = true;

prev_block_min_energy = 0;
my_block_min_energy = 0;

prev_block_min_tick_energy = 0;
my_block_min_tick_energy = 0;

my_block_max_energy = DB.terrain_config[? "outburst_threshold"];
next_block_max_energy = DB.terrain_config[? "outburst_threshold"];

alarm[1] = 2;

