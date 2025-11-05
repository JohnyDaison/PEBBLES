event_inherited();

self.enabled = ds_map_create();
self.drainables = ds_list_create();

self.potential_targets = ds_list_create();
self.potential_drain_rods = ds_list_create();
self.nearest_drain_target = ds_map_create();
self.drain_target_list = ds_map_create();

ds_list_add(self.drainables, color_orb_obj, slime_mob_obj, shield_obj);

for (var dir = 0; dir < 4; dir++) {
    self.enabled[? dir] = false;
    self.nearest_drain_target[? dir] = noone;
    self.drain_target_list[? dir] = ds_list_create();
}

self.image_speed = 0;
self.my_last_color = g_nothing;
self.drain_point_dist = 64;
self.range = 96;
self.grid_size = 32;
self.energy_tick = 0.005;
self.activation_threshold = 0.1;
self.radius = 2 * self.range;

self.lightning_tint = c_black;
self.lightning_steps = 2;
self.lightning_thickness = 4;
self.lightning_width = 16;
self.lightning_alpha = 1;
self.lightning_reset = true;

self.alarm[1] = 2;
