event_inherited();

my_color = g_green;
tint_updated = false;
multicolor = true;
image_alpha = 0.9;
level_upgrade = true;
consumed_on_pickup = true;
pickup_sound = jump_sound;

levels[? "wall_hold"] = 1;
levels[? "wall_climb"] = 2;
levels[? "wall_jump"] = 3;

self.name = "Magnetic Gloves";

self.description = 
@"Now you can Wall Climb
and Wall Jump.";