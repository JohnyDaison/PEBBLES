event_inherited();

self.base_bg_color = c_ltgray;
self.bg_color = self.base_bg_color;
self.color = c_black;
self.max_chars = 140;
self.width = 256;
self.prompt_str = "";
self.list_picker = noone;
self.items = ds_list_create();
self.tab_text = "";
self.tab_mode = false;
self.history_mode = false;
self.command_history_index = -1;

self.alarm[0] = 1;
