event_inherited();

my_color = g_black;
black_tint = DB.colormap[? g_black];
white_tint = DB.colormap[? g_azure];
min_power = 7;
max_power = DB.max_jump_pad_power;
jump_power = max_power;
recharge_speed = 0.1;
// states: recharging, ready, active
ready = true;
active = false;
walkable = true;

airborne = true;
max_speed = 40;

name = "Jump Pad";

