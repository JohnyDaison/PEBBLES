event_inherited();

var place;
place = add_place_in_room(room_rougelike, "Rougelike", 0,0, 65536,65536, 31040);
place.controller = roguelike_place_controller_obj;

place_count = ds_list_size(places);
current_place = places[|0];