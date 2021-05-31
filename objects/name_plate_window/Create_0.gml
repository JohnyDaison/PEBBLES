event_inherited();

self.width = 0;
self.height = 32;
self.text = "";
flag_icon = empty_mask;
allied_flag_tint = make_color_rgb(0, 128, 255);
enemy_flag_tint = c_orange;
self.my_guy = noone;
self.font = label_font;
self.bg_color = c_gray;
self.bg_alpha = 0.0;
self.flag_alpha = 0.8;
draw_swapped = false;

friend = false;
my_camera = noone;
border_width = 0;
view_width = 0;
view_height = 0;

alarm[0] = 0;
