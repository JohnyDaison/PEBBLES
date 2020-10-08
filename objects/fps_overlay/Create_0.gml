event_inherited();

self.width = 128;
self.height = 64;
self.bg_alpha = 0.66;
self.bg_color = c_dkgray;

fps_list = ds_list_create();
fps_real_list = ds_list_create();
value_count = 120;

average_fps = 0;
average_fps_real = 0;