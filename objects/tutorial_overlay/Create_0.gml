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

function addMessageStruct(message) {
    var index = self.message_count++;

    self.messages[index] = new message(self.id);
    self.message_state[index] = 0;
}

// Messages
self.addMessageStruct(MessageMovement);
self.addMessageStruct(MessageAttack);
self.addMessageStruct(MessageChangeColor);
self.addMessageStruct(MessageCreateShield);
self.addMessageStruct(MessageChanneling);
self.addMessageStruct(MessageCrystals);
self.addMessageStruct(MessageSprinkler);
self.addMessageStruct(MessageLoadCannon);
self.addMessageStruct(MessageFireCannon);
// Ability Messages
self.addMessageStruct(MessageRewind);
self.addMessageStruct(MessageBerserk);
self.addMessageStruct(MessageHeal);
self.addMessageStruct(MessageBlink);
self.addMessageStruct(MessageHaste);
self.addMessageStruct(MessageInvisibility);
self.addMessageStruct(MessageUbershield);
self.addMessageStruct(MessageTeleport);
