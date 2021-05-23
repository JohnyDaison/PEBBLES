event_inherited();

my_color = c_black;
my_last_color = my_color;
black_tint = DB.colormap[? g_dark];
final_tint = c_black;
last_tint = tint;
energy = 0;
last_energy = energy;
max_energy = 1;
recharge_speed = 0.005;
// states: recharging, ready, active
ready = true;
active = false;
compressed = false;
walkable = true;

alarm[1] = 2;

name = "Piezo-plate";

// LIGHT
radius = 32;
gives_light = true;
shape = shape_circle;
ambient_light_coef = 0.4;
direct_light_coef = 0.15;
light_fadeout_coef = 1/6;
ambient_light = self.ambient_light_coef;
direct_light = self.direct_light_coef;

light_yoffset = -20;
