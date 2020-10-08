event_inherited();

my_color = g_green;
tint_updated = false;
multicolor = true;
image_alpha = 0.9;
level_upgrade = true;
consumed_on_pickup = true;
pickup_sound = jump_sound;

/*
ds_map_add(levels, "wall_hold", 1);
ds_map_add(levels, "wall_climb", 1);
ds_map_add(levels, "wall_jump", 1);
*/

levels[? "wall_hold"] = 1;
levels[? "wall_climb"] = 1;
levels[? "wall_jump"] = 1;

self.name = "Climbing Gloves";

self.description = 
@"Now you can climb walls
and do Wall jump.";