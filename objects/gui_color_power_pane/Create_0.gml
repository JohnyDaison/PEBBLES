event_inherited();

self.bg_alpha = 0.6;
self.bg_color = c_black;
self.text = "Color Power";

column_bg_alpha = 0.1;
column_white_ratio = 0.8;

gaps_after = ds_list_create();
ds_list_add(gaps_after, g_black, g_blue, g_azure);

base_halfsize = 7;
column_width = 20;
row_height = 20;
gap_size = 6;
margin = 8;
heading_height = 32;

table_width = (g_white + 2) * row_height + ds_list_size(gaps_after) * gap_size;
table_height = table_width;

width = table_width + 2 * margin;
height = heading_height + table_height + margin;