event_inherited();

name = "World 1";

var place;

place = add_place_in_room(room_movement_mountain, "Get a move on!", 0,0, 10720,7200, 0);
place.description = "Learn to perform various kinds of jumps.";
place.controller = movement_mountain_place_controller_obj;
ds_list_add(place.level_configs_list, "tutorial");


place = add_place_in_room(room_base_colors_tut, "Basic survival", 0,0, 8800,8800, 0);
place.description = "Discover the base colors and their effects.";
place.controller = base_colors_place_controller_obj;
ds_list_add(place.level_configs_list, "tutorial", "movement");


place = add_place_in_room(room_double_effects_tut, "Intermezzo", 0,0, 6400,4960, 0);
place.description = "Experience the wonderful effects of secondary colors.";
ds_list_add(place.level_configs_list, "tutorial", "movement", "base_colors");


place = add_place_in_room(room_catalyst_tut, "Catalyst", 0,0, 12800,4960, 0);
place.description = "Embrace the Catalyst and unleash its destructive power.";
place.controller = catalyst_place_controller_obj;
ds_list_add(place.level_configs_list, "tutorial", "movement", "base_colors");


place = add_place_in_room(room_shield_tut, "Shield", 0,0, 4800,4800, 0);
place.description = "Defend yourself from the dangers of the arena.";
ds_list_add(place.level_configs_list, "tutorial", "movement", "base_colors");


/*
place = add_place_in_room(room_barrage_tut, "Barrage", 0,0, 6400,4800, 0);
*/

/*
place = add_place_in_room(room_teleport_tut, "Blink", 0,0, 4800,4800, 384);
place.description = "Get Blink";
ds_list_add(place.level_configs_list, "match");
*/

place_count = ds_list_size(places);
current_place = places[|0];
