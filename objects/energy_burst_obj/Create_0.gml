event_inherited();

self.energy = 0.25; //0
self.done_for = false;
self.image_speed = 1;
self.sprite_index = wall_burst_start_spr;
self.my_guy = noone;
self.alarm[1] = 1;

self.name = "Energy Burst";

self.base_xcoord = 0;
self.base_ycoord = 0;

self.right_xcoord = 0;
self.right_ycoord = 0;

self.x1 = 0;
self.x2 = 0;
self.x3 = 0;
self.x4 = 0;

self.y1 = 0;
self.y2 = 0;
self.y3 = 0;
self.y4 = 0;

// holo
self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.4;
self.holo_maxalpha = 0.6;
