event_inherited();

my_sound_play(wall_hum_sound, true);

self.image_alpha = 0.95;
self.fade_ratio = 1;
self.fade_speed = 0.01;
self.fading_out = false;
self.dash_dist = 0;
self.depth = -50;
self.knockback = false;

self.has_collided = false;
self.terrain_col_done = false;
self.dealt_damage = false;
self.start_step = singleton_obj.step_count;
self.wallhit_played = false;

self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.4;
self.holo_maxalpha = 0.6;

self.name = "Dash-Wave";
