action_inherited();
my_color = g_octarine;
tint_updated = false;
multicolor = true;
image_alpha = 1;
image_speed = 0;
armed = false;
fuse_length = 240;
fuse_left = fuse_length;
fuse_tick = 1;
explode_anim_speed = 0.04;
chain_explosion_range = 64;
done_for = false;
max_stack_size = 4;

throw_speed = 10;
gravity_coef = 0.15;
friction_coef = 0.05;

self.my_shield = noone;
self.shield_chargerate = 1;
self.shield_overcharge = 0;
self.shield_threshold = 6;
self.shield_repair_time = 360;

self.inventory_spr = inversion_matrix_inv_spr;

self.pickup_sound = overcharge_sound;
self.name = "Inversion Matrix";

