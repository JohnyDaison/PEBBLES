self.room_x = 0;
self.room_y = 0;

self.my_color = g_dark;
self.tint_updated = false;
self.tint = c_dkgray;
self.new_tint = self.tint;

self.last_x = x;
self.last_y = y;

self.glow_dir = 1;
self.glow_step = 0.01;
self.glow_min = 0.4;
self.glow_ratio = self.glow_min;

self.square_side = 128;

self.sprite_index = cursor_arrow;
self.active_tool = noone;
self.last_active_tool = self.active_tool;
self.ctrl_tool = panning_tool_obj;
self.old_tool = noone;
self.image_speed = 0;

self.tooltip = "";
self.tooltip_color = DB.colormap[? g_yellow];
self.tooltip_bg_color = make_color_rgb(16, 16, 16);
