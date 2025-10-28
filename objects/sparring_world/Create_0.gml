event_inherited();

name = "Pit world";

var place;
place = add_place_in_room(sparring_arena, "The Pit", 0,0, 2816,2176, 0);
place.description = "Small open arena with two Battery Spawners.";
place.controller = autogenerate_place_controller_obj;

place.forced_rules[? "holographic_spawners"] = false;
place.forced_rules[? "cannons"] = false;
place.forced_rules[? "turrets"] = false;
place.forced_rules[? "mob_portals"] = false;

place_count = ds_list_size(places);
current_place = places[|0];
