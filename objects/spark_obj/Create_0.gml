event_inherited();

orig_gravity = 0.05;
jump_power = 3;
friction = 0.03;
jump_delay = 60;
image_speed = 0.1;
my_guy = id;
my_color = g_octarine;

airborne = false;
hor_dir = 0;
can_jump = false;
done_for = false;
energy = 0.1;

blocking_object = solid_terrain_obj;

self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.4;
self.holo_maxalpha = 0.6;