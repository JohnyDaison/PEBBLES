action_inherited();
system = part_system_create();
part_system_automatic_draw(system, true);
part_system_automatic_update(system, true);
part_system_depth(system, -1);
part_system_draw_order(system, true);

min_dir = 0;
max_dir = 0;
max_life = 25;
charge_ratio = 1;
particle_count = 10;
alarm[0] = 1;

