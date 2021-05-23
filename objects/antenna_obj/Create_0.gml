event_inherited();

var i;
enabled = ds_map_create();
lightning_dist = ds_map_create();
light_emitter = ds_map_create();
for(i=0; i<4; i++)
{
    enabled[? i] = false;
    lightning_dist[? i] = 0;
    light_emitter[? i] = noone;
}
image_speed = 0;
my_last_color = g_nothing;
range = 15;
grid_size = 32;
energy = 0;
activation_threshold = 0.1;
radius = range*grid_size;

lightning_color = g_dark;
lightning_tint = c_black;
lightning_steps = 2;
lightning_thickness = 4;
lightning_width = 16;
lightning_alpha = 1;
lightning_reset = true;

alarm[1] = 2;
