event_inherited();

self.my_color = g_octarine;
self.hp = 0.75;
self.immovable = true;
self.max_speed = 2;

self.image_alpha = 1;
self.image_index = 0;
self.image_speed = 0;

self.protected = false;
self.damage_tint_ratio = 0.5;
self.my_shield = noone;
last_attacker_init();

self.alarm[0] = irandom(180) + 1;

self.name = "Artifact";

event_perform(ev_other, ev_user1);
