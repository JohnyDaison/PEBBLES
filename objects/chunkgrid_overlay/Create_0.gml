event_inherited();

if (!instance_exists(chunkgrid_obj)) {
    singleton_obj.show_chunkgrid = false;
    close_frame(self.id);
    exit;
}

self.my_chunkgrid = chunkgrid_obj.id;
self.grid_width = self.my_chunkgrid.grid_width;
self.grid_height = self.my_chunkgrid.grid_height;
self.width = self.grid_width * 32 + 48;
self.height = self.grid_height * 32 + 64;
self.bg_color = c_black;
self.bg_alpha = 0.7;

self.x = 320;
self.y = 320;
self.window_axis = self.x + self.width / 2;

self.heading = "";

for (var yy = 0; yy < self.grid_height; yy += 1) {
    self.ter_text[yy] = "";
}

self.depth = -2000;
