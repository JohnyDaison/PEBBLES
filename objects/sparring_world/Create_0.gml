event_inherited();

name = "Pit world";

var place;
place = add_place_in_room(sparring_arena, "The Pit", 0,0, 2816,2176, 0);
place.description = "Small open arena with two Battery Spawners.";
place.controller = autogenerate_place_controller_obj;

place.forced_modifiers[? "holographic_spawners"] = false;
place.forced_modifiers[? "cannons"] = false;
place.forced_modifiers[? "turrets"] = false;
place.forced_modifiers[? "mob_portals"] = false;

place_count = ds_list_size(places);
current_place = places[|0];
