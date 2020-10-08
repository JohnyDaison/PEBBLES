event_inherited();

multicolor = true;
my_color = irandom_range(1,7);
tint_updated = false;
image_alpha = 0.8;
usable = false;
hp = 2;
energy = 3;

my_angle = 0;
my_distance = 48;

self.pickup_sound = crystal_sound;
self.inventory_spr = sprite_index;

self.shield_chargerate = 1;
self.shield_overcharge = 0;
self.shield_threshold = 6;
self.shield_repair_time = 360;

self.size_pulse = 0;
hover_offset = 8;

self.protected = false;
step_count = 0;
self.damage_tint_ratio = 0.5;

i = instance_create(x,y,shield_obj);
i.my_guy = self.id;
i.charge = 1;
i.my_color = irandom_range(1,7);
my_shield = i;

self.name = "Shard";



