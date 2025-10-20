event_inherited();

self.multicolor = true;
self.my_color = irandom_range(1, 7);
self.tint_updated = false;
self.image_alpha = 0.8;
self.usable = false;
self.hp = 2;
self.energy = 3;

self.my_angle = 0;
self.my_distance = 48;
self.orbiting_lerp_ratio = 0.05;

self.ambient_light = 0.5;
self.direct_light = 0.25;

self.pickup_sound = crystal_sound;
self.inventory_spr = self.sprite_index;

self.shield_chargerate = 1;
self.shield_overcharge = 0;
self.shield_threshold = 6;
self.shield_repair_time = 360;

self.hover_offset = 8;

self.protected = false;
self.damage_tint_ratio = 0.5;

var inst = instance_create(self.x, self.y, shield_obj);

inst.my_guy = self.id;
inst.charge = 1;
inst.my_color = irandom_range(1, 7);

self.my_shield = inst;

self.name = "Shard";
