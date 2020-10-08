action_inherited();
type = gamepad;
number = 0;
index = -1;
analog_dead_zone = 0.5;
trigger_dead_zone = 0.2;
hor_zone = 65;
vert_zone = 65;
camera = noone;
directions_str = "Analog Sticks";

ds_grid_resize(states,6,4);
ds_grid_set_region(states, 0, free, 5, free, true);

binds[? up] =  gamepad_up;
binds[? down] =  gamepad_down;
binds[? left] =  gamepad_left;
binds[? right] =  gamepad_right;
binds[? r] =  gp_face2;
binds[? g] =  gp_face4;
binds[? b] =  gp_face3;
binds[? cast] =  gp_shoulderrb;
binds[? channel] =  gp_shoulderlb;
binds[? abi] =  gp_shoulderl;
binds[? jump] = gp_face1;
binds[? look] =  gamepad_stick;
binds[? altfire] =  gp_shoulderr;
binds[? inventory_1] =  gp_padu;
binds[? inventory_2] =  gp_padl;
binds[? inventory_3] =  gp_padd;
binds[? inventory_4] =  gp_padr;


