event_inherited();

my_color = g_octarine;
tint_updated = false;
multicolor = true;
image_alpha = 1;
image_speed = 0;
depth = -15;
armed = false;
attached_fuse_length = 240;
fuse_left = 600;
fuse_tick = 1;
explode_anim_speed = 0.06;
chain_explosion_range = 96;
done_for = false;
max_stack_size = 4;
consumable = true;
holdable = true;
use_cooldown_length = 120;

throw_speed = 10;
gravity_coef = 0.15;
//friction_coef = 0.03;

self.my_shield = noone;
self.shield_chargerate = 1;
self.shield_overcharge = 0;
self.shield_threshold = 6;
self.shield_repair_time = 360;

self.inventory_spr = emp_grenade_inv_spr;

self.pickup_sound = overcharge_sound;
self.name = "Shield Grenade";

