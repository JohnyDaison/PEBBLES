event_inherited();

energy = 0.25; //0
done_for = false;
image_speed = 1;
sprite_index = wall_burst_start_spr;
my_guy = noone;
alarm[1] = 1;

name = "Energy Burst";

base_xcoord = 0;
base_ycoord = 0;

right_xcoord = 0;
right_ycoord = 0;

x1 = 0; x2 = 0; x3 = 0; x4 = 0;
y1 = 0; y2 = 0; y3 = 0; y4 = 0;

// holo
self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.4;
self.holo_maxalpha = 0.6;