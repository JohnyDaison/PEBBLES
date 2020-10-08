event_inherited();

system = part_system_create();
part_system_automatic_draw(system, true);
part_system_automatic_update(system, true);
part_system_depth(system, 20);
part_system_draw_order(system, true);
pt = part_type_create();

part_type_alpha2(pt,0.9,0.1);
part_type_color1(pt,DB.colormap[? g_red]);
part_type_shape(pt,pt_shape_smoke);
part_type_size(pt,0.7,0.7, -0.03,0);
part_type_life(pt,10,25);
part_type_speed(pt, 5,5, -0.2, 0.2);
part_type_direction(pt, 90,90, 0, 1);

em = part_emitter_create(system);

my_guy=noone;

