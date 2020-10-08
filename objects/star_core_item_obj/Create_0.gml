event_inherited();

my_color = g_octarine;
tint_updated = false;
multicolor = true;
image_alpha = 1;
image_speed = 0;
depth = -15;
done_for = false;
max_stack_size = 4;
destroy_on_use = true;

//friction_coef = 0.03;

self.shield_chargerate = 1;
self.shield_overcharge = 1;
self.shield_threshold = 6;
self.shield_repair_time = 360;

i = instance_create(x,y,shield_obj);
i.my_guy = self.id;
i.charge = 2;
i.my_color = g_white;
my_shield = i;

self.inventory_spr = bigbang_icon;

self.pickup_sound = overcharge_sound;
self.name = "Star Core";

