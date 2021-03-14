event_inherited();

my_color = g_octarine;
hp = 0.75;
immovable = true;
max_speed = 2;

image_alpha = 1;
image_index = 0;
image_speed = 0;

self.protected = false;
self.damage_tint_ratio = 0.5;
my_shield = noone;
last_attacker_init();

self.name = "Artifact";

event_perform(ev_other,ev_user1);

