event_inherited();

my_player = noone;

nonfocusable = true;
draw_border = false;
self.bg_color = c_black;
self.bg_alpha = 0.8;

self.width = 256;
self.height = 256;
abi_panel_height = 61;
margin = 8;

// to prevent blink in wrong position
x = -1000;
y = -1000;

window_x_center = x + self.width / 2;
window_y_center = y + self.height / 2;

eloffset_x = window_x_center;
eloffset_y = window_y_center;

power_pane = gui_add_color_power_pane(0, 0);
