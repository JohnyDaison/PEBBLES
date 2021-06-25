event_inherited();

var i;

enabled = ds_map_create();
active = ds_map_create();
field = ds_map_create();
tints = ds_map_create();

for(i=0; i<4; i++)
{
    enabled[? i] = false;
    active[? i] = false;
    field[? i] = noone;
    tints[? i] = ds_list_create();
}

image_speed = 0;
my_last_color = g_nothing;
rotate_by = 0;
has_rotated = true;

transfer_packet_size = 0.2;

disc_tint = c_black;
disc_alpha = 0.8;
dot_distance = 8;
disc_angle = 0;
desired_disc_angle = 0;
rotation_speed = 0;
rotation_time = 60;
rotation_acc_coef = 90 / rotation_time;
rotation_acc = 0;

alarm[1] = 2;
