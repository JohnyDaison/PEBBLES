event_inherited();

self.draw_border = true;
self.round_corners = true;
self.draw_bg_color = true;
self.bg_alpha = 0.9;
self.border_color = merge_colour(c_purple,c_white,0.5);
self.base_border_color = border_color;
self.color = c_black;
self.bg_color = self.base_bg_color;
self.base_text_color = c_black;
self.text_color = self.base_text_color;
self.onmouseover_script = noone;
self.ondown_script = noone;
self.onrepeat_script = noone;
self.onup_script = noone;
self.onmouseleave_script = noone;
self.want_focus = true;
self.step_count = 0;
self.locked = false;
self.draw_unlocked_border = false;
self.locked_border_color = merge_colour(c_red,c_black,0.25);
self.unlocked_border_color = merge_colour(c_green,c_white,0.25);

ondown_function = function() {};
onrepeat_function = function() {};
onup_function = function() {};
