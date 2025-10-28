event_inherited();

my_sound_play(shot1_sound);
//my_sound_play_colored(shot1_sound, g_dark);

if (instance_number(object_index) == 1) {
    my_sound_loop(black_projectile_sound);
    //my_sound_play_colored(black_projectile_sound, g_dark, false, true);
}

self.force_used = 0;
self.stolen_slots = ds_list_create();
self.slot_count = 0;
self.picked_pickups = ds_list_create();
self.pickup_count = 0;
self.radius = 80;
self.orig_friction = 0.05;
self.gravity_ratio = 0;
self.orb_dist = 2;

self.return_distance_limit = 8;
self.return_max_axisdelta = 6;

self.start_trail_delay = 20;
self.min_trail_delay = 8;
self.trail_delay = self.start_trail_delay;
self.alarm[2] = self.trail_delay;

//sprite_index = no_sprite;
self.tint_updated = true;
self.tint = merge_color(c_purple, c_white, 0.333);
self.highlight_alpha = 0.666;

self.name = "Vortex";
