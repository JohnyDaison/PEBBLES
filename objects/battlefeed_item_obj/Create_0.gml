self.battlefeed = noone;
self.width = 0;
self.height = 0;
self.content_length = 0;
self.item_type = "";
self.type = ds_map_create();
self.content = ds_map_create();
self.tint = ds_map_create();
self.facing = ds_map_create();
self.blanks = ds_map_create();

self.init_fade_ratio = 4;
self.blinkin_duration = 0.75;
self.fade_ratio = self.init_fade_ratio;
