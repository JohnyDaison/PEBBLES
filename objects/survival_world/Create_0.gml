event_inherited();

name = "Survival World";

var place;

place = add_place_in_room(survival_arena, "Wave Survival", 0,0, 3104,2016, 0);

place_count = ds_list_size(places);
current_place = places[|0];