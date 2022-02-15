event_inherited();

self.width = 24;
self.height = 24;

self.onup_script = gui_checkbox_script;
self.onchange_script = empty_script;
self.user_clicked_script = empty_script;
self.icon = medium_tick_spr;
self.checked = false;

self.checked_icon = medium_tick_spr;
self.unchecked_icon = noone;

self.checked_bg_color = self.base_bg_color;
self.unchecked_bg_color = self.base_bg_color;
self.checked_icon_color = c_white;
self.unchecked_icon_color = c_white;

alarm[2] = 1;

onchange_function = function() {
}
