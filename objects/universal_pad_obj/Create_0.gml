event_inherited();

my_color = g_white;
pad_color = g_dark;
last_pad_color = g_dark;
dark_tint = DB.colormap[? g_dark];
bright_tint = DB.colormap[? pad_color];
tint_updated = true;
ready_power = ds_map_create();
recharge_speed = ds_map_create();
deactivate_power = ds_map_create();
max_power = 1;
cur_power = max_power;
burst_anim_sprite = noone;
burst_anim_index = 0;
burst_anim_length = 0;
burst_anim_speed = 0.25;
burst_tint = c_black;
text_popped = false;
popup_string = "";
meeting_guys_list = ds_list_create();
blinked_guys_list = ds_list_create();

foreground = instance_create_depth(x,y,-50, universal_pad_foreground_obj);
foreground.background = id;

shape = shape_circle;
radius = 24;

//TODO: glow in front of guy

// states: recharging, ready, active
ready = false;
active = false;
walkable = true;

ready_power[? g_dark]     = 0;
ready_power[? g_red]      = 0.9;
ready_power[? g_green]    = 0.95;
ready_power[? g_blue]     = 0.9;
ready_power[? g_yellow]   = 0.9;
ready_power[? g_magenta]  = 0.9;
ready_power[? g_cyan]     = 1;
ready_power[? g_white]    = 0.9;
ready_power[? g_octarine] = 0.9;

deactivate_power[? g_dark]  = 0;
deactivate_power[? g_red] = 0.5;
deactivate_power[? g_green] = 0.6;
deactivate_power[? g_blue] = 0.5;
deactivate_power[? g_yellow] = 0.5;
deactivate_power[? g_magenta] = 0.5;
deactivate_power[? g_cyan]  = 0;
deactivate_power[? g_white] = 0.5;
deactivate_power[? g_octarine] = 0.5;

recharge_speed[? g_dark] = 0;
recharge_speed[? g_red] = 0.01;
recharge_speed[? g_green] = 0.075;
recharge_speed[? g_blue] = 0.01;
recharge_speed[? g_yellow] = 0.01;
recharge_speed[? g_magenta] = 0.01;
recharge_speed[? g_cyan] = 0.003;
recharge_speed[? g_white] = 0.01;
recharge_speed[? g_octarine] = 0.01;

orb_boost_coef = 0.01;
orb_boost_cost = 0.5;

health_regen_coef = 0.02;
health_regen_cost = 0.2;

cooldown_regen_coef = 0.01;
cooldown_regen_cost = 0.5;

shield_boost_coef = 0.05;
shield_boost_cost = 0.2;

jump_power_coef = DB.max_jump_pad_power;

airborne = true;
max_speed = 40;

name = "Power Pad";
