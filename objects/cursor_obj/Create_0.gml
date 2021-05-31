room_x = 0;
room_y = 0;

self.my_color = g_dark;
self.tint_updated = false;
self.tint = c_dkgray;
self.new_tint = self.tint;

last_x = x;
last_y = y;

glow_dir = 1;
glow_step = 0.01;
glow_min = 0.4;
glow_ratio = glow_min;

square_side = 128;

sprite_index = cursor_arrow;
active_tool = noone;
last_active_tool = active_tool;
ctrl_tool = panning_tool_obj;
old_tool = noone;
image_speed = 0;

tooltip = "";
tooltip_color = DB.colormap[? g_yellow];
tooltip_bg_color = make_color_rgb(16, 16, 16);
