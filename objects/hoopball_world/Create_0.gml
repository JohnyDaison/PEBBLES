event_inherited();

name = "Hoopball world";

var place;


place = add_place_in_room(football_field, "Hoopball Field", 0,0, 4096,2176, 0);
place.description = "Experimental hoopball level.";
place.controller = hoopball_place_controller_obj;

place_count = ds_list_size(places);
current_place = places[|0];