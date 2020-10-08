event_inherited();

my_color = g_white;
tint_updated = false;
image_alpha = 0.8;
destroy_on_use = true;
/*
invisible = true;
visible = false;
*/
level_upgrade = true;
level_upto = true;
consumed_on_pickup = true;
pickup_sound = shot1_sound;
levels[? "guy_orbit"] = 2;
levels[? "chargeball"] = 2;
levels[? "barrage_mode"] = 1;

self.name = "Catalyst upgrade";
self.description_name = "Barrage";

self.description = 
@"Multiple target-seeking mini-blasts.";
