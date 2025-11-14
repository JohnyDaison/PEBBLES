event_inherited();

self.bg_alpha = 0.6;
self.bg_color = c_black;
self.text = "Color Power";

self.column_bg_alpha = 0.2;
self.column_white_ratio = 0.6;

self.color_order = ds_list_create();
ds_list_add(self.color_order, g_red, g_green, g_blue, g_yellow, g_magenta, g_cyan, g_dark, g_white);
self.color_count = ds_list_size(self.color_order);

self.gaps_after = ds_list_create();
ds_list_add(self.gaps_after, g_blue, g_cyan);

self.base_halfsize = 8;
self.column_width = 26;
self.row_height = 26;
self.big_gap_size = 4;
self.gap_size = 2;
self.margin = 8;
self.heading_height = 32;

self.table_width = (self.color_count + 1) * self.row_height + ds_list_size(self.gaps_after) * self.gap_size + self.big_gap_size;
self.table_height = (self.color_count + 1) * self.row_height + ds_list_size(self.gaps_after) * self.gap_size + self.big_gap_size;

self.width = self.table_width + 2 * self.margin;
self.height = self.heading_height + self.table_height + self.margin;
