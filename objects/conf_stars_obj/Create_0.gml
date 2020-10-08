action_inherited();
system = part_system_create();
part_system_automatic_draw(system, true);
part_system_automatic_update(system, true);
part_system_depth(system, 20);
part_system_draw_order(system, true);
pt = part_type_create();
part_type_sprite(pt,part_star_spr, false,false,false);
part_type_alpha1(pt,0.8);

part_type_color1(pt,DB.colormap[? g_yellow]);
part_type_size(pt,0.6,0.6,0,0);
part_type_life(pt,12,12);
part_type_gravity(pt,0,90);

part_type_orientation(pt,0,0,0,0,0);
em = part_emitter_create(system);

my_guy=noone;

