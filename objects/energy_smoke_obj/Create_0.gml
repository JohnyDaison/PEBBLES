event_inherited();

shape = shape_circle;
orig_friction = 0.4;
normal_radius = 20;
core_radius = 12;
scale = 0.1;
scale_speed = 0.1;
radius = scale*normal_radius;
gives_light = true;
orig_ambient_light = 0.35;
orig_direct_light = 0;
ambient_light = orig_ambient_light;
direct_light = orig_direct_light;
max_force = 0;
gui_x = 0;
gui_y = 0;
fall_gravity = 0.1;
is_resting = true;
force_decay = 0.00001;
force_usage = 0.001;
consolidated = false;
image_index = irandom(image_number-1);
image_speed = 0;

// holo
self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.4;
self.holo_maxalpha = 0.6;

col_group = noone; // collision group
inv_col_group = noone;

if(y > 0)
{
    my_sound_play(jump_sound);
}

self.name = "Gas Cloud";

