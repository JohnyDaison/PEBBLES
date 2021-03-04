event_inherited();

name = "Arena World";

var i=0, place;


place = add_place_in_room(classic_arena, "Classic Arena", 0,0, 2912,1472, 0);
place.description = "Small arena from the dawn of the age.";
//place.controller = classic_arena_place_controller_obj;
place.controller = autogenerate_place_controller_obj;
place.forced_modifiers[? "turrets"] = false;


place = add_place_in_room(closed_quarters_arena, "Closed Quarters", 0,0, 2816,2816, 0);
place.description = "Very small arena with constant supply of Orb Batteries.";
place.controller = autogenerate_place_controller_obj;
place.single_cam = true;
place.forced_modifiers[? "turrets"] = false;
place.forced_modifiers[? "cannons"] = false;
place.forced_modifiers[? "mob_portals"] = false;

place.forced_modifiers[? "random_item_spawner"] = false;
place.forced_modifiers[? "snakes_on_a_plane"] = false;
place.forced_modifiers[? "bolt_rain"] = false;
place.forced_modifiers[? "slime_mob_rain"] = false;
place.forced_modifiers[? "artifacts"] = false;
place.forced_modifiers[? "lightning_strikes"] = false;


place = add_place_in_room(vertigo_arena, "Vertigo", 0,0, 3072,2048, 0);
place.description = "Very few places to stand on and almost no cover.";
place.controller = autogenerate_place_controller_obj;
place.forced_modifiers[? "turrets"] = false;
place.forced_modifiers[? "cannons"] = false;
place.forced_modifiers[? "mob_portals"] = false;

place.forced_modifiers[? "random_item_spawner"] = false;
place.forced_modifiers[? "snakes_on_a_plane"] = false;
place.forced_modifiers[? "slime_mob_rain"] = false;
place.forced_modifiers[? "lightning_strikes"] = false;


place = add_place_in_room(testroom, "Mayhemburger", 0,0, 4896,2848, 0);
place.description = "Medium size complex arena with a lot of Turrets, Spawners and other elements.";
place.controller = autogenerate_place_controller_obj;


place = add_place_in_room(room_small_face_arena, "Small Face Arena", 0,0, 2048,2048, 0);
place.description = "Very small arena.";
place.controller = autogenerate_place_controller_obj;
place.single_cam = true;
place.forced_modifiers[? "turrets"] = false;
place.forced_modifiers[? "cannons"] = false;
place.forced_modifiers[? "mob_portals"] = false;

place.forced_modifiers[? "random_item_spawner"] = false;
place.forced_modifiers[? "snakes_on_a_plane"] = false;
place.forced_modifiers[? "bolt_rain"] = false;
place.forced_modifiers[? "slime_mob_rain"] = false;
place.forced_modifiers[? "artifacts"] = false;
place.forced_modifiers[? "lightning_strikes"] = false;


place = add_place_in_room(face_arena, "Face Arena", 0,0, 3104,2016, 0);
place.description = "Small arena with rounder geometry with a few Turrets and two gravity anomalies.";
// TODO: this is shared, but shouldn't be the same
place.controller = autogenerate_place_controller_obj;

/*
place = add_place_in_room(room_tech_war_arena, "Tech war grid", 0,0, 3200,3200, 0);
place.description = "For Tech war mode";
place.controller = autogenerate_place_controller_obj;
*/

place = add_place_in_room(crumble_arena, "4-Player Crumble", 0,0, 4608,3968, 0);


//place = add_place_in_room(domination1, "Domination", 0,0, 4608,3968, 0);


place = add_place_in_room(alpinus_sandbox, "Alpinus Sandbox", 0,0, 2528,2784, 384);
place.description = "Medium size wacky arena with many gravity anomalies.";


//place = add_place_in_room(skull_bones, "Skull & Bones", 0,0, 1280,1280, 0);


place = add_place_in_room(big_arena, "Big Arena", 0,0, 6400,3200, 384);
place.description = "Huge arena, pointlessly even. Should be filled with some stuff...";


place_count = ds_list_size(places);
current_place = places[|0];
