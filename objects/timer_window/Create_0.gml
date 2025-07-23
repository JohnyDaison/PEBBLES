event_inherited();

self.width = 80;
self.height = 48;
self.medal_label = noone;
self.show_medal = false;
self.time = noone;
self.keep_inside = false;
raw_total = 0;
last_check = gamemode_obj.match_start_time;

best_award_value = -1;
best_time_award = "";

self.font = label_font;
self.bg_alpha = 0.75;
self.bg_color = c_ltgray;

alarm[2] = 1;
