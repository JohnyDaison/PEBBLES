event_inherited();

system = part_system_create();
part_system_automatic_draw(system, true);
part_system_automatic_update(system, true);
part_system_depth(system, -6);
part_system_draw_order(system, true);
pt = part_type_create();
part_type_alpha3(pt,0.5,1,0.5);
part_type_blend(pt,1);

part_type_colour1(pt, c_black);
part_type_sprite(pt, part_pixel_spr, false, false, false);
part_type_size(pt, 1, 3, -0.25, 0.25);
part_type_life(pt, 4, 12);
part_type_gravity(pt, 0, 90);
part_type_orientation(pt, 0, 0, 0, 0, 0);

em = part_emitter_create(system);

radius = 128;
max_pt = 100;

my_guy = noone;

