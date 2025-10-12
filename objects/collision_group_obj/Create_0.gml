self.members = ds_list_create();
self.annihilate = false;
self.resolved = false;
self.speed_threshold = 1;
self.sitting_on_terrain = false;

self.force = ds_map_create();
for (var i = g_red; i < g_white; i++) {
    self.force[? i] = 0;
}

self.ratio_updated = false;
self.base_color = g_dark;
self.ratio = 0;
//self.balance_margin = 0.1;

// This is not general, it's made for energyballs
