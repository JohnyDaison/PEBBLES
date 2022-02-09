event_inherited();

// PARTICLES 
system = part_system_create();
part_system_automatic_draw(system, true);
part_system_automatic_update(system, true);
part_system_depth(system, -20);
part_system_draw_order(system, true);
pt = part_type_create();
part_type_alpha2(pt,0.8,0);
part_type_blend(pt,true);

part_type_color1(pt,c_white);
part_type_sprite(pt,part_sphere_spr,0,0,0);
part_type_size(pt,0.1,0.1,-0.01,0);
part_type_life(pt,10,10);

part_type_orientation(pt,0,0,0,0,0);
em = part_emitter_create(system);


col_group = noone; // collision group
inv_col_group = noone;

shape = shape_circle;
radius = 100;
gives_light = true;
orig_ambient_light = 0.6;
orig_direct_light = 1;
ambient_light = orig_ambient_light;
direct_light = orig_direct_light;
impact_strength = 0;
shake_range = 480;
tracked = false;
weak_force_range = 64;
strong_force_range = 6;
gui_x = 0;
gui_y = 0;
sitting_on_terrain = false;
stopped_threshold = 0.5;
wall_bounce_damping = 0;
make_particles = true;
particle_count = 1;
sound_volume = 1;

self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.4;
self.holo_maxalpha = 0.6;

x_return = 0;
y_return = 0;

gate_bounce_limit = 3;
gate_bounce_count = 0;
gate_bounced = false;
