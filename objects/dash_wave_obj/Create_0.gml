event_inherited();

my_sound_play(wall_hum_sound, true);

image_alpha = 0.95;
fade_ratio = 1;
fade_speed = 0.01;
fading_out = false;
dash_dist = 0;
depth = -50;
knockback = false;

has_collided = false;
terrain_col_done = false;
dealt_damage = false;
start_step = singleton_obj.step_count;
wallhit_played = false;

self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.4;
self.holo_maxalpha = 0.6;

self.name = "Dash-Wave";
