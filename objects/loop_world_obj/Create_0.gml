event_inherited();

name = "Loop World";

var place;

place = add_place_in_room(room_empty_base, "Test!", 0,0, 2048,2048, 0);
place.description = "Test.";
place.controller = autogenerate_place_controller_obj;
ds_list_add(place.level_configs_list, "match");

place_count = ds_list_size(places);
current_place = places[|0];
