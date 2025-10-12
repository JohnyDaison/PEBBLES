event_inherited();

self.system = part_system_create();
part_system_automatic_draw(self.system, true);
part_system_automatic_update(self.system, true);
part_system_depth(self.system, 20);
part_system_draw_order(self.system, true);
self.pt = part_type_create();

part_type_alpha2(self.pt, 0.9, 0.6);
part_type_color1(self.pt, DB.colormap[? g_blue]);
part_type_sprite(self.pt, part_snowflake_spr, false, false, false);
part_type_size(self.pt, 0.8, 0.8, -0.01, 0);
part_type_life(self.pt, 10, 25);
part_type_gravity(self.pt, 0.1, 270);

self.em = part_emitter_create(self.system);

self.my_guy = noone;
