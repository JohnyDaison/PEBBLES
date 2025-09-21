event_inherited();

system = part_system_create();
part_system_automatic_draw(system, true);
part_system_automatic_update(system, true);
part_system_depth(system, 20);
part_system_draw_order(system, true);
pt = part_type_create();
part_type_alpha3(pt, 1, 1, 1);
part_type_blend(pt, 0);
part_type_color3(pt, 255, 16777215, 2572525);
part_type_shape(pt, pt_shape_flare);
part_type_size(pt, 0.08, 0.34, 0, 0);
part_type_life(pt, 8, 10);
part_type_gravity(pt, 0.36, 90);
part_type_orientation(pt, 0, 0, 0, 0, 0);
em = part_emitter_create(system);

my_guy = noone;
