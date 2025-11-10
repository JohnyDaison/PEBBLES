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

self.messages = [];
self.message_count = 0;
// 0 - NOT SHOWN, 1 - ACTIVE, 2 - WAS SHOWN
self.message_state = [];

self.alarm[2] = self.message_delay;

function addMessage(message) {
    var index = self.message_count++;
    
    self.messages[index] = message;
    self.message_state[index] = 0;
}

// messages
self.addMessage(message_movement);
self.addMessage(message_attack);
self.addMessage(message_change_color);
self.addMessage(message_create_shield);
self.addMessage(message_crystals);
self.addMessage(message_sprinkler);
self.addMessage(message_load_cannon);
self.addMessage(message_fire_cannon);

self.addMessage(message_flashback);
self.addMessage(message_berserk);
self.addMessage(message_heal);
self.addMessage(message_teleport);
self.addMessage(message_haste);
self.addMessage(message_invis);
self.addMessage(message_ubershield);
self.addMessage(message_base_teleport);
