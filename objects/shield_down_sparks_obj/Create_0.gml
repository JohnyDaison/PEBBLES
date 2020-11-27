event_inherited();

color = DB.colormap[? g_white];

system = part_system_create();
part_system_automatic_draw(system, true);
part_system_automatic_update(system, true);
part_system_depth(system, -20);
part_system_draw_order(system, true);
pt = part_type_create();

part_type_alpha2(pt, 0.8, 0.2);
part_type_color1(pt, color);
part_type_shape(pt,pt_shape_spark);
part_type_size(pt,0.3,0.3,-0.005,0);
part_type_life(pt,25,35);
part_type_speed(pt, 6, 9, 0, 0);
part_type_direction(pt, 15, 165, 0, 0.2);
part_type_orientation(pt, 0,0, 0,0, false);
part_type_gravity(pt, 0.5, 270);

em = part_emitter_create(system);

my_guy = noone;

lightning_steps = 3;
lightning_thickness = 3;
lightning_width = 16;
lightning_range = 64;
