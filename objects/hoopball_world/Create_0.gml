event_inherited();

name = "Hoopball world";

var place;


place = add_place_in_room(small_football_field, "Small Football Field", 0,0, 4096,2176, 0);
place.description = "Experimental.";
place.controller = hoopball_place_controller_obj;
place.single_cam = true;


place = add_place_in_room(hoopball_field, "Hoopball Field", 0,0, 4096,2176, 0);
place.description = "Experimental hoopball level.";
place.controller = hoopball_place_controller_obj;

place_count = ds_list_size(places);
current_place = places[|0];