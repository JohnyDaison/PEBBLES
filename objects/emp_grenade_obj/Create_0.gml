event_inherited();

self.my_color = g_octarine;
self.tint_updated = false;
self.multicolor = true;
self.image_alpha = 1;
self.image_speed = 0;
self.depth = -15;
self.armed = false;
self.attached_fuse_length = 240;
self.fuse_left = 600;
self.fuse_tick = 1;
self.explode_anim_speed = 0.06;
self.chain_explosion_range = 96;
self.done_for = false;
self.max_stack_size = 4;
self.consumable = true;
self.holdable = true;
self.use_cooldown_length = 120;

self.throw_speed = 10;
self.gravity_coef = 0.15;
//self.friction_coef = 0.03;

self.my_shield = noone;
self.shield_chargerate = 1;
self.shield_overcharge = 0;
self.shield_threshold = 6;
self.shield_repair_time = 360;

self.inventory_spr = emp_grenade_inv_spr;

self.pickup_sound = overcharge_sound;
self.name = "Shield Grenade";
