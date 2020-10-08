event_inherited();

my_color = g_blue;
min_power = 5;
max_power = 7;
jump_power = max_power;
recharge_speed = 0.1;
// states: recharging, ready, active
ready = true;
active = false;
walkable = false;
immovable = true;

trigger_script = teleporter_trigger_script;
triggerable = true;

tp_xx = 0;
tp_yy = 0;

angle = 0;
scale = 0;

name = "Teleporter";

