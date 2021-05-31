event_inherited();

my_color = g_white;
hp = 0.15;
radius = 13;
min_flight_speed = 3;
max_flight_speed = 5;
max_speed = 24;
attack_hover_dist = 320;
//ammo_drop_count = 2;
crystal_drop_count = 0;
walkable = true;
lockon_range = 1216;
lockoff_range = 1536;
weapon_distance = 9;
gun = noone;
gun_count = 1;
my_score_value = 6;
gun_color = g_red;
gun_tint = c_dkgray;
incoming_lockon_range = 160;
smoke_resistant = false;
airborne = true;
custom_sprite = true;
follow_target = id;
follow_x = x;
follow_y = y;
attack_target = noone;
/*
last_follow_target = noone;
last_attack_target = noone;
*/

alarm[1] = 1;

image_angle = 90;
direction = 90;
speed = 0.2;

rotation_speed = 0;
max_rotation_speed = 3;
//rotation_acc = 0.2;
//avoid_acc = 0.1;
tracking_acc = 0.1;
gravity = 0.01;
friction = 0.01;
image_speed = 0;
//image_index = 1;

//debug_str = "";

blocking_object = terrain_obj;

// LIGHT
self.gives_light = true;
shape = shape_circle;
self.ambient_light = 0.2;
self.direct_light = 0.1;

name = "Spitter";
