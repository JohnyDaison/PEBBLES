event_inherited();

name = "Volleyball world";

var place;

place = add_place_in_room(thecourt_arena, "Indoor Court", 0,0, 2816,2176, 0);
place.description = "Local volleyball venue.";
place.controller = volleyball_place_controller_obj;
place.single_cam = true;


place = add_place_in_room(football_field, "Hoopball Field", 0,0, 4096,2176, 0);
place.description = "Experimental hoopball level.";
place.controller = volleyball_place_controller_obj;
ds_list_add(place.level_configs_list, "movement", "vortex");
place.forced_modifiers[? "one_death"] = false;
place.forced_modifiers[? "black_color"] = true;
place.forced_modifiers[? "dark_orb_energy_lock"] = true;

place_count = ds_list_size(places);
current_place = places[|0];