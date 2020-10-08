event_inherited();

self.fired = false;
self.energy = 10;
self.shrapnel_count = 12;
self.shrapnel_charge = energy/shrapnel_count;
self.create_shockwave = true;
self.shield_charge = 0.5;
self.slot = noone;
self.fire_projectiles = true;
self.create_sparks = true;
self.spark_cost = 2;
self.my_source = object_index;

self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.4;
self.holo_maxalpha = 0.6;

name = "Shockwave";

