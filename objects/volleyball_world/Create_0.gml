event_inherited();

name = "Volleyball world";

var place;

place = add_place_in_room(thecourt_arena, "Indoor Court", 0,0, 2816,2176, 0);
place.description = "Local volleyball venue.";
place.controller = volleyball_place_controller_obj;
place.single_cam = true;
place.max_team_count = 2;

place = add_place_in_room(the_low_ceiling_court, "Low Ceiling Court", 0,0, 2816,2176, 0);
place.description = "Watch out for the ball bouncing off the ceiling.";
place.controller = volleyball_place_controller_obj;
place.single_cam = true;
place.max_team_count = 2;

place_count = ds_list_size(places);
current_place = places[|0];