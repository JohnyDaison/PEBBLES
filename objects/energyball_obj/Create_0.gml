event_inherited();

// PARTICLES 
self.system = part_system_create();
part_system_automatic_draw(self.system, true);
part_system_automatic_update(self.system, true);
part_system_depth(self.system, -20);
part_system_draw_order(self.system, true);

self.pt = part_type_create();
part_type_alpha2(self.pt, 0.8, 0);
part_type_blend(self.pt, true);

part_type_color1(self.pt, c_white);
part_type_sprite(self.pt, part_sphere_spr, 0, 0, 0);
part_type_size(self.pt, 0.1, 0.1, -0.01, 0);
part_type_life(self.pt, 10, 10);

part_type_orientation(self.pt, 0, 0, 0, 0, 0);
self.em = part_emitter_create(self.system);


self.col_group = noone; // collision group
self.inv_col_group = noone;

self.shape = shape_circle;
self.radius = 100;
self.gives_light = true;
self.orig_ambient_light = 0.6;
self.orig_direct_light = 1;
self.ambient_light = orig_ambient_light;
self.direct_light = orig_direct_light;
self.impact_strength = 0;
self.shake_range = 480;
self.tracked = false;
self.weak_force_range = 64;
self.strong_force_range = 6;
self.gui_x = 0;
self.gui_y = 0;
self.sitting_on_terrain = false;
self.stopped_threshold = 0.5;
self.wall_bounce_damping = 0;
self.make_particles = true;
self.particle_count = 1;
self.sound_volume = 1;

self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.4;
self.holo_maxalpha = 0.6;

self.x_return = 0;
self.y_return = 0;
self.hchange = 0;
self.vchange = 0;

self.gate_bounce_limit = 3;
self.gate_bounce_count = 0;
self.gate_bounced = false;
