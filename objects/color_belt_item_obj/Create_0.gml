event_inherited();

self.my_color = g_white;
self.tint_updated = false;
self.image_alpha = 0.9;
self.level_upgrade = true;
self.consumed_on_pickup = true;
self.pickup_sound = slot_absorbed_sound;
self.levels[? "colors_belt_size"] = 1;

self.name = "Color belt";

self.description =
@"Provides equip slots for Color Orbs.
(1 slot per color)";
