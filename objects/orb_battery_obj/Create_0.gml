event_inherited();

my_color = g_octarine;
multicolor = true;
tint_updated = false;
image_alpha = 1;
energy_boost = 0.3; // per orb (given to all colored orbs)
//consumed_on_pickup = true;
destroy_on_use = true;
custom_sprite = true;
bg_alpha = 0.3;
colors_alpha = 0.9;
red_tint = DB.colormap[? g_red];
green_tint = DB.colormap[? g_green];
blue_tint = DB.colormap[? g_blue];

// LIGHT
gives_light = true;
shape = shape_circle;
ambient_light = 0.4;
direct_light = 0.1;

self.pickup_sound = heal_sound;
self.pickup_show_name = false;
self.inventory_spr = sprite_index;
sprite_index = orb_battery_spr;

self.name = "Orb Battery";

