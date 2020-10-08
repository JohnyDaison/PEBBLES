action_inherited();
var dir;
enabled = ds_map_create();
drainables = ds_list_create();
ds_list_add(drainables, color_orb_obj, slime_mob_obj, shield_obj);
potential_targets = ds_list_create();
potential_drain_rods = ds_list_create();
nearest_drain_target = ds_map_create();
drain_target_list = ds_map_create();
for(dir = 0; dir < 4; dir++)
{
    enabled[? dir] = false;
    nearest_drain_target[? dir] = noone;
    drain_target_list[? dir] = ds_list_create();
}
image_speed = 0;
my_last_color = g_nothing;
drain_point_dist = 64;
range = 96;
grid_size = 32;
energy_tick = 0.005;
activation_threshold = 0.1;
radius = 2*range;

lightning_tint = c_black;
lightning_steps = 2;
lightning_thickness = 4;
lightning_width = 16;
lightning_alpha = 1;
lightning_reset = true;

alarm[1] = 2;

