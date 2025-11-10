event_inherited();

self.width = 0;
self.height = 0;
self.orig_alpha = 1;
self.bg_alpha = 0.66;
self.bg_color = merge_color(c_yellow, c_dkgray, 0.25);
self.orig_bg_color = self.bg_color;
self.color = c_black;
self.border_color = c_red;
self.font = tutorial_font;

self.title = "";
self.message = "";
self.cur_message_step = 0;
self.old_message = self.message;
self.adjusted = false;
self.my_guy = noone;

self.max_width = 0;
self.line_height = 32;
self.max_lines = 2;

self.message_delay = 60;
self.blink_time = 30;
self.blink_peak = 10;
self.blink_color = c_white;
self.fadeout_time = 90;
self.blink_step = 0;
self.fadeout_step = 0;

var messages = ds_map_create();
var i = 1;
ds_map_add(messages, i++, message_movement);
ds_map_add(messages, i++, message_attack);
ds_map_add(messages, i++, message_change_color);
ds_map_add(messages, i++, message_create_shield);
ds_map_add(messages, i++, message_crystals);
ds_map_add(messages, i++, message_sprinkler);
ds_map_add(messages, i++, message_load_cannon);
ds_map_add(messages, i++, message_fire_cannon);

ds_map_add(messages, i++, message_flashback);
ds_map_add(messages, i++, message_berserk);
ds_map_add(messages, i++, message_heal);
ds_map_add(messages, i++, message_teleport);
ds_map_add(messages, i++, message_haste);
ds_map_add(messages, i++, message_invis);
ds_map_add(messages, i++, message_ubershield);
ds_map_add(messages, i++, message_base_teleport);

self.messages = messages;
self.message_count = ds_map_size(messages);

// 0 - NOT SHOWN, 1 - ACTIVE, 2 - WAS SHOWN
self.message_state = ds_map_create();

for (i = 1; i <= self.message_count; i++) {
    ds_map_add(self.message_state, i, 0);
}

self.alarm[2] = self.message_delay;
