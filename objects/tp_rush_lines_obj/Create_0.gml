action_inherited();
system = part_system_create();
part_system_automatic_draw(system, true);
part_system_automatic_update(system, true);
part_system_depth(system, 20);
part_system_draw_order(system, true);
pt = part_type_create();

part_type_alpha2(pt,0.9,0.6);
part_type_color1(pt,DB.colormap[? g_blue]);
part_type_shape(pt,pt_shape_line);
part_type_size(pt,1.2,1.2,-0.06,0);
part_type_life(pt,10,15);
part_type_speed(pt, 8, 8, 0, 0);
part_type_orientation(pt, 0,0, 0,0, true);

em = part_emitter_create(system);

my_guy=noone;

