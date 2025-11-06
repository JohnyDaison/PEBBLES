event_inherited();

self.bounced = false;
self.corner_bounced = false;
self.collided = false;
self.shield_hit = false;
self.wallhit_played = false;
self.facing = 1;
self.has_not_left_list = ds_list_create();
self.has_left_inst = ds_map_create();
self.was_stopped = false;
self.force = 0;
self.gravity_coef = 0;
self.orig_friction = 0;
self.ground_friction_multiplier = 3;
self.alarm[0] = 1;
self.depth = -5;
self.radius = 0;
