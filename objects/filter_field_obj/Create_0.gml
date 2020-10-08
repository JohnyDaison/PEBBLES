event_inherited();

my_projectors = ds_map_create();

border_size = 8;
corner_radius = border_size*2;
check_dist = 33;
stop_dist = 12;
speedlimit = 5;

mask_size = 32;
texture_size = 32;

image_speed = 0;
height = 24;
width = 24;
ready = false;
x1 = 0;
y1 = 0;
x2 = 0;
y2 = 0;

alpha = 0.2;
alpha_speed = 0.003; // 0.005
alpha_dir = 1;
min_alpha = 0.35;
max_alpha = 0.6;

my_sound_play(gate_on_sound);

name = "Filter field";

// LIGHT
gives_light = true;
shape = shape_rect;
ambient_light = 0.25;
direct_light = 1;
/*
light_xoffset = 0;
light_yoffset = 0;
*/