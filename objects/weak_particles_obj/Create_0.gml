event_inherited();

system = part_system_create();
part_system_automatic_draw(system, true);
part_system_automatic_update(system, true);
part_system_depth(system, 20);
part_system_draw_order(system, true);
pt = part_type_create();
part_type_alpha2(pt,1,0.8);

part_type_color1(pt, DB.colormap[? g_purple]);
part_type_shape(pt,pt_shape_ring);
part_type_size(pt,0.5,0.5,0,0);
part_type_life(pt,40,40);
part_type_gravity(pt,0.03,90);
/*
part_type_direction(pt, 90, 90, 0, 0);
part_type_speed(pt, 2,2, 0,0);
*/
part_type_orientation(pt,0,0,0,0,0);
em = part_emitter_create(system);

my_guy=noone;

/* */
/*  */
