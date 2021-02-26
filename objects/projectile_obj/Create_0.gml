event_inherited();

self.bounced = false;
self.corner_bounced = false;
self.collided = false;
self.shield_hit = false;
wallhit_played = false;
facing = 1;
has_not_left_list = ds_list_create();
has_left_inst = ds_map_create();
was_stopped = false;
force = 0;
gravity_coef = 0;
orig_friction = 0;
ground_friction_multiplier = 3;
alarm[0] = 1;
depth = -5;
radius = 0;
