event_inherited();

tint = DB.colormap[? g_blue];
depth = -5;

system = part_system_create();
part_system_automatic_draw(system, true);
part_system_automatic_update(system, true);
part_system_depth(system, -1);
part_system_draw_order(system, true);
pt = part_type_create();

part_type_alpha2(pt,0.9,0.6);
part_type_color1(pt,tint);
part_type_sprite(pt,part_snowflake_spr, false, false, false);
part_type_size(pt,0.8,0.8,-0.01,0);
part_type_life(pt,10,25);
part_type_gravity(pt,0.1,270);

em = part_emitter_create(system);

my_guy = noone;
