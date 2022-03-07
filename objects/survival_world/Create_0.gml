event_inherited();

name = "Survival World";

var place;

place = add_place_in_room(survival_arena, "Wave Survival", 0,0, 3136,2048, 0);
place.description = "Basic Survival arena with 3 Mob Portals"
place.controller = autogenerate_place_controller_obj;

place_count = ds_list_size(places);
current_place = places[|0];