event_inherited();

my_color = g_blue;
multicolor = true;
tint_updated = false;
image_alpha = 0.95;
max_stack_size = 4;
keep_on_death = true;
consumable = true;
use_cooldown_length = 600;
exit_safety_range = 800;
//destroy_on_use = true;
oppo_state = ds_map_create();

self.pickup_sound = tp_sound;
//self.pickup_show_name = false;
self.inventory_spr = sprite_index;

self.name = "Player Teleport";

