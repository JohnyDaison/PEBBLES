action_inherited();
var i;
enabled = ds_map_create();
for(i=0; i<4; i++)
{
    enabled[? i] = false;
}
image_speed = 0;
my_last_color = g_nothing;
range = 15;
grid_size = 32;
powered = false;
energy = 0;
max_energy = 1;
energy_drain_step = 0.001;
energy_use_step = 0.0002;
activation_threshold = 0.1;
radius = range*grid_size;
text_x = 0;
text_y = 0;
text = "";

alarm[1] = 2;

