event_inherited();

name = "Arena World";

var place;

place = add_place_in_room(classic_arena, "Classic Arena", 0,0, 2912,1472, 0);
place.description = "Small arena from the dawn of the age.";
place.controller = autogenerate_place_controller_obj;
place.max_team_count = 2;
place.forced_rules[? "turrets"] = false;
place.forced_rules[? "flag_capture"] = false;


place = add_place_in_room(closed_quarters_arena, "Closed Quarters", 0,0, 2816,2816, 0);
place.description = "Very small arena with constant supply of Orb Batteries.";
place.controller = autogenerate_place_controller_obj;
place.single_cam = true;
place.max_team_count = 2;
place.forced_rules[? "turrets"] = false;
place.forced_rules[? "cannons"] = false;
place.forced_rules[? "mob_portals"] = false;
place.forced_rules[? "flag_capture"] = false;

place.forced_rules[? "random_item_spawner"] = false;
place.forced_rules[? "snakes_on_a_plane"] = false;
place.forced_rules[? "bolt_rain"] = false;
place.forced_rules[? "slime_mob_rain"] = false;
place.forced_rules[? "artifacts"] = false;
place.forced_rules[? "lightning_strikes"] = false;


place = add_place_in_room(two_towers_arena, "Two Towers", 0,0, 2048,2048, 0);
place.description = "Two wizards built their towers next to each other. Only one can remain.";
place.controller = autogenerate_place_controller_obj;
place.single_cam = true;
place.max_team_count = 2;
ds_list_add(place.level_configs_list, "just_2orbs_start");
place.forced_rules[? "turrets"] = false;
place.forced_rules[? "cannons"] = false;
place.forced_rules[? "mob_portals"] = false;
place.forced_rules[? "flag_capture"] = false;

place.forced_rules[? "holographic_spawners"] = true;
place.forced_rules[? "hp_death"] = true;
place.forced_rules[? "dark_color"] = false;
place.forced_rules[? "dark_orb_energy_lock"] = false;
place.forced_rules[? "random_item_spawner"] = false;
place.forced_rules[? "weak_terrain"] = false;
place.forced_rules[? "indestr_terrain"] = false;
place.forced_rules[? "regenerate_terrain"] = false;
place.forced_rules[? "random_item_spawner"] = false;
place.forced_rules[? "snakes_on_a_plane"] = false;
place.forced_rules[? "bolt_rain"] = false;
place.forced_rules[? "slime_mob_rain"] = false;
place.forced_rules[? "artifacts"] = false;
place.forced_rules[? "lightning_strikes"] = false;
place.forced_rules[? "abilities"] = false;
place.forced_rules[? "death_limit"] = true;
place.forced_rules[? "orbs_energy_min_lock"] = true;


place = add_place_in_room(vertigo_arena, "Vertigo", 0,0, 3072,3072, 0);
place.description = "Very few places to stand on and almost no cover.";
place.controller = autogenerate_place_controller_obj;
place.max_team_count = 2;
place.forced_rules[? "turrets"] = false;
place.forced_rules[? "cannons"] = false;
place.forced_rules[? "mob_portals"] = false;

place.forced_rules[? "random_item_spawner"] = false;
place.forced_rules[? "snakes_on_a_plane"] = false;
place.forced_rules[? "slime_mob_rain"] = false;
place.forced_rules[? "lightning_strikes"] = false;


place = add_place_in_room(less_vertigo_arena, "New Vertigo", 0,0, 3840,3456, 0);
place.description = "Not much terrain and no cover.";
place.controller = autogenerate_place_controller_obj;
place.max_team_count = 2;
place.forced_rules[? "turrets"] = false;
place.forced_rules[? "cannons"] = false;
place.forced_rules[? "mob_portals"] = false;

place.forced_rules[? "snakes_on_a_plane"] = false;
place.forced_rules[? "slime_mob_rain"] = false;
place.forced_rules[? "lightning_strikes"] = false;

place.default_rules[? "random_item_spawner"] = false;


place = add_place_in_room(mayhemburger_arena, "Mayhemburger", 0,0, 4896,2848, 0);
place.description = "Medium size complex arena with a lot of Turrets, Spawners and other elements.";
place.controller = autogenerate_place_controller_obj;
place.max_team_count = 2;


place = add_place_in_room(room_small_face_arena, "Small Face Arena", 0,0, 2048,2048, 0);
place.description = "Very small arena.";
place.controller = autogenerate_place_controller_obj;
place.single_cam = true;
place.max_team_count = 2;
place.forced_rules[? "turrets"] = false;
place.forced_rules[? "cannons"] = false;
place.forced_rules[? "mob_portals"] = false;
place.forced_rules[? "flag_capture"] = false;

place.forced_rules[? "random_item_spawner"] = false;
place.forced_rules[? "snakes_on_a_plane"] = false;
place.forced_rules[? "bolt_rain"] = false;
place.forced_rules[? "slime_mob_rain"] = false;
place.forced_rules[? "artifacts"] = false;
place.forced_rules[? "lightning_strikes"] = false;


place = add_place_in_room(face_arena, "Face Arena", 0,0, 3104,2016, 0);
place.description = "Small arena with rounder geometry with a few Turrets and two gravity anomalies.";
place.controller = autogenerate_place_controller_obj;
place.max_team_count = 2;

place.forced_rules[? "flag_capture"] = false;

/*
place = add_place_in_room(room_tech_war_arena, "Tech war grid", 0,0, 3200,3200, 0);
place.description = "For Tech war mode";
place.controller = autogenerate_place_controller_obj;
*/

place = add_place_in_room(crumble_arena, "Four-Player Crumble", 0,0, 4608,3968, 0);
place.description = "Four Bases. Destructible terrain. Total chaos.";
place.controller = autogenerate_place_controller_obj;
place.max_team_count = 4;

place.forced_rules[? "flag_capture"] = false;

//place = add_place_in_room(domination1, "Domination", 0,0, 4608,3968, 0);


place = add_place_in_room(alpinus_sandbox, "Alpinus Sandbox", 0,0, 2528,2784, 384);
place.description = "Medium size wacky arena with many gravity anomalies.";
place.max_team_count = 2;

place.forced_rules[? "flag_capture"] = false;

//place = add_place_in_room(skull_bones, "Skull & Bones", 0,0, 1280,1280, 0);


place = add_place_in_room(big_arena, "Big Arena", 0,0, 6400,3200, 384);
place.description = "Huge arena, pointlessly even. Should be filled with some stuff...";
place.max_team_count = 2;

place.forced_rules[? "flag_capture"] = false;

place_count = ds_list_size(places);
current_place = places[|0];
