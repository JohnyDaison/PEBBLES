action_inherited();
type = joystick;
alarm[1] = 1;
number = 0;
analog_dead_zone = 0.5;
trigger_dead_zone = 0.3;
hor_zone = 65;
vert_zone = 65;
directions_str = "Analog Sticks";

ds_grid_resize(states,35,4);
ds_grid_set_region(states, 0, free, 34, free, true);

binds[? up] =  joy_up;
binds[? down] =  joy_down;
binds[? left] =  joy_left;
binds[? right] =  joy_right;
binds[? r] =  2;
binds[? g] =  4;
binds[? b] =  3;
binds[? cast] =  joy_rtrigger;
binds[? channel] =  joy_ltrigger;
binds[? abi] =  5;
binds[? jump] =  1;
binds[? look] =  9;
binds[? altfire] =  6;
binds[? inventory_1] =  joy_dpad_up;
binds[? inventory_2] =  joy_dpad_left;
binds[? inventory_3] =  joy_dpad_down;
binds[? inventory_4] =  joy_dpad_right;


