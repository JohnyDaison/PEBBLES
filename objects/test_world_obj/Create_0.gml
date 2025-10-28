event_inherited();

name = "Test world";

var place;


place = add_place_in_room(room_all_items_test, "Items", 0,0, 4800,4800, 0);
ds_list_add(place.level_configs_list, "tutorial");

place.forced_rules[? "dark_color"] = true;
place.forced_rules[? "abilities"] = true;


place = add_place_in_room(room_energy_test, "Energy", 0,0, 4800,4800, 0);
ds_list_add(place.level_configs_list, "match");

place.forced_rules[? "turrets"] = true;


place = add_place_in_room(room_smoke_test, "Smoke", 0,0, 3200,3200, 0);
ds_list_add(place.level_configs_list, "inventory");


place = add_place_in_room(room_bigbang_test, "The Big Bang", 0,0, 3200,3200, 384);
ds_list_add(place.level_configs_list, "match");

place.forced_rules[? "dark_color"] = true;
place.forced_rules[? "abilities"] = true;


place = add_place_in_room(room_weapons_test, "Weapons", 0,0, 9600,4800, 384);
place.description = "Boom! Boom! BOOM!";
ds_list_add(place.level_configs_list, "match");

place.forced_rules[? "cannons"] = true;
place.forced_rules[? "turrets"] = true;


//add_place_in_room(room_star_test, "A Star", 0,0, 4800,4800, 384);


place = add_place_in_room(room_chaos_order_test, "Order and Chaos", 0,0, 2048,2048, 0);
place.description = "Order and Chaos";
ds_list_add(place.level_configs_list, "match");


place = add_place_in_room(room_bot_jump_test, "Bot Jump Test", 0,0, 2048,2048, 0);
place.description = "Can the bot get to the top?";
/*  Yes, if you move the left-most waypoint on bot's platform two blocks to the right after running navgraph.
    Why is it stopping on those waypoints instead of just running through? Is this related with START BREAKING EARLY? */
place.controller = autogenerate_place_controller_obj;
place.max_team_count = 2;
ds_list_add(place.level_configs_list, "movement");


place = add_place_in_room(room_show_off, "Show Off!", 0,0, 2368,2048, 0);
place.description = "Quick jumps";
ds_list_add(place.level_configs_list, "movement", "no_attacks");

place.forced_rules[? "color_orbs_energy_lock"] = false;
place.forced_rules[? "dark_color"] = false;
place.forced_rules[? "abilities"] = false;
place.forced_rules[? "random_item_spawner"] = false;
place.forced_rules[? "snakes_on_a_plane"] = false;
place.forced_rules[? "bolt_rain"] = false;
place.forced_rules[? "slime_mob_rain"] = false;
place.forced_rules[? "artifacts"] = false;
place.forced_rules[? "lightning_strikes"] = false;


place = add_place_in_room(room_displays_test, "Displays", 0,0, 4800,4800, 384);
place.controller = display_test_place_controller_obj;
ds_list_add(place.level_configs_list, "reset", "match");

place.default_rules[? "dark_color"] = true;
place.default_rules[? "abilities"] = true;


place = add_place_in_room(room_void_test, "Void", 0,0, 4800,4800, 0);
place.controller = autogenerate_place_controller_obj;
ds_list_add(place.level_configs_list, "match");

place.default_rules[? "base_crystals"] = true;
place.default_rules[? "dark_color"] = true;
place.default_rules[? "abilities"] = true;
place.default_rules[? "turrets"] = true;
place.default_rules[? "cannons"] = true;

/*
place = add_place_in_room(room_runjump_tut, "RUN & JUMP!", 0,0, 9600,4800, 384);
place.controller = run_jump_place_controller_obj;
ds_list_add(place.level_configs_list, "match");
*/


place = add_place_in_room(room_snake_test, "Snakes", 0,0, 4800,4800, 0);
place.description = "Room for testing snakes... it's a mess, what did you expect?";
place.max_team_count = 2;
ds_list_add(place.level_configs_list, "match");

place.forced_rules[? "snakes_on_a_plane"] = true;
place.forced_rules[? "base_crystals"] = true;
place.default_rules[? "dark_color"] = true;
place.default_rules[? "abilities"] = true;


//place = add_place_in_room(room_escape1, "Escape!", 0,0, 4800,4800, 384);

place = add_place_in_room(room_pebbles_logo, "PEBBLES", 0,0, 4800,4800, 384);
place.controller = pebbles_logo_place_controller_obj;
place.single_cam = true;


//place = add_place_in_room(room_slingshot_range, "Slingshot range", 0,0, 4800,4800, 384);
/*
place = add_place_in_room(room_shotshell_test, "Shooting range", 0,0, 9600,4800, 384);

place.forced_rules[? "turrets"] = true;
*/
place = add_place_in_room(room_gated1, "Gated", 0,0, 4800,4800, 384);
ds_list_add(place.level_configs_list, "match");

place.forced_rules[? "cannons"] = true;
place.forced_rules[? "turrets"] = true;


place_count = ds_list_size(places);
current_place = places[|0];
