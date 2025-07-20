event_inherited();

self.width = 0;
self.height = 0;
self.orig_alpha = 1;
self.bg_alpha = 1;
self.bg_color = c_black;
self.orig_bg_color = self.bg_color;
self.color = c_white;
self.item_color = c_white;
self.outline_color = c_white;
self.border_color = c_white;
self.font = tutorial_font;
self.item_scale = 3;
/*
x = view_wview[0]/2-width/2;
y = view_hview[0]/2-height/2;
*/
self.title = "Item title";
self.image = item_placeholder_spr;
self.message = "Item description";
self.adjusted = false;
my_guy = noone;

max_width = 0;
line_height = 32;
max_lines = 2;
margin = 8;
move_speed = 4;
text_width = 0;
item_halfwidth = 0;
item_halfheight = 0;
scaled_halfwidth = 0;
scaled_halfheight = 0;
side_x = 0;

message_delay = 10;
blink_time = 30;
blink_peak = 10;
blink_color = c_white;
slide_time = 120;
fadeout_time = 600;
blink_step = 0;
slide_step = 0;
fadeout_step = 0;

birth_step = singleton_obj.step_count;

alarm[2] = message_delay;
