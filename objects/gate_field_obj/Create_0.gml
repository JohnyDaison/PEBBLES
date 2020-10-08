event_inherited();

my_color = g_white;
my_gates = ds_map_create();
tint_updated = false;
image_speed = 0;
horizontal = false;
vertical = false;
check_dist = 33;
slow_dist = 22;
stop_dist = 12;
height = 24;
width = 24;
mask_size = 32;
texture_size = 32;
alpha = 0.2;
alpha_speed = 0.005;
alpha_dir = 1;
min_alpha = 0.75;
max_alpha = 0.99;
my_sound_play(gate_on_sound);


// LIGHT
gives_light = true;
shape = shape_rect;
ambient_light = 0.25;
direct_light = 1;

light_xoffset = 0;
light_yoffset = 0;

corner_radius = 8;
