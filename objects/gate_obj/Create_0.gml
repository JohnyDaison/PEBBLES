event_inherited();

var i;

tint_change_time = 90;

outer_tint = c_white;
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

alarm[1] = 2;
