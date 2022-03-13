event_inherited();

hp = 9;
radius = 31;
flight_speed = 2;
max_speed = 3;
//ammo_drop_count = 2;
crystal_drop_count = 0;
walkable = true;
lockon_range = 2048;
weapon_distance = 24;
gun_count = choose(2,2,2,2,2,3,3,4);
ammo_drop_count = gun_count;
my_score_value = 40;
body_tint = c_ltgray;
incoming_lockon_range = 208;
smoke_resistant = true;
airborne = true;
refire_time = 20;
gun_rotation_speed = 120/refire_time;

min_terrain_dist = 24;
min_burst_dist = 52;

alarm[1] = 1;

direction = 90;
speed = 0.2;
rotation_speed = -3;
tracking_acc = 0.1;
avoiding_acc = 0.09;
breaking_acc = 0.1;
gravity = 0.001;
friction = 0.01;
image_speed = 0;
image_index = 1;

blocking_object = terrain_obj;

// TERRAIN OPTIMIZATION
read_terrain = true;
self.ter_right = 1;
self.ter_left = 1;
self.ter_up = 1;
self.ter_down = 1;

// LIGHT
self.gives_light = true;
shape = shape_circle;
self.ambient_light = 0.6;
self.direct_light = 0.1;

name = "Sprinkler";
