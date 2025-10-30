event_inherited();

name = "Tower Climb world";

var RuleID = global.RuleID;
var place;
//place = add_place_in_room(room_weapons_test, "Weapons", 0,0, 9600,4800, 0);

/*
place = add_place_in_room(room_movement_mountain, "Mountain", 0,0, 9600,7200, 0);
place.controller = movement_mountain_place_controller_obj;
ds_list_add(place.level_configs_list, "tutorial");
*/
place = add_place_in_room(towerclimb_arena, "Tower of Madness", 0,0, 4800,16000, 0);
place.description = "Get through the swarms of Spitters and frantic Sprinklers. There's no princess at the end.";
place.forced_rules[? "cannons"] = true;
place.forced_rules[? RuleID.HolographicSpawners] = false;
place.max_team_count = 2;

place_count = ds_list_size(places);
current_place = places[|0];
