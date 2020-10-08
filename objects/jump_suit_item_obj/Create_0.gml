event_inherited();

my_color = g_azure;
tint_updated = false;
multicolor = true;
image_alpha = 0.9;
level_upgrade = true;
level_upto = true;
consumed_on_pickup = true;
pickup_sound = jump_sound;

levels[? "air_jump"] = 2;
levels[? "charged_jump"] = 2;
levels[? "wall_hold"] = 1;
levels[? "wall_climb"] = 2;
levels[? "wall_jump"] = 3;
levels[? "dive_jump"] = 2;

self.name = "Jump Suit";

self.description = 
@"Full Movement suite ACTIVATED!";