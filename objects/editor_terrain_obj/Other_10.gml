if (palette_index == 1) {
    self.tint = c_gray;
}
else if (palette_index == 2) {
    self.tint = ds_map_find_value(DB.colormap, self.color);
}

self.final_tint = self.tint;
if (self.color != g_dark) {
    self.final_tint = merge_color(self.tint, c_white, 0.1);
}

image_index = max(0, image_index);
