event_inherited();

name = "Quick Tutorial";

var place;


place = add_place_in_room(room_quick_tut_movement, "Jump, jump, jump!", 0,0, 4480,3520, 192);
place.description = "Climbing, Charged jump, Triple jump, Wall hold, Wall jump, Impact, Dive jump";
place.controller = quick_tut_movement_place_controller_obj;
ds_list_add(place.level_configs_list, "tutorial");

place.forced_modifiers[? "turrets"] = false;


/*
place.times[? "gold"] = 28;
place.times[? "silver"] = 42;
place.times[? "bronze"] = 58;
place.times[? "normal"] = 82;
*/

place = add_place_in_room(room_quick_tut_base_colors, "The Trinity", 0,0, 9600,3840, 192);
place.description = "Effects of Red, Green and Blue";
place.controller = quick_tut_base_colors_place_controller_obj;
ds_list_add(place.level_configs_list, "tutorial", "movement");


place = add_place_in_room(room_quick_tut_catalyst, "Catalyst", 0,0, 7232,3840, 192);
place.description = "Catalyst weapon and Blast attack, Effects of Yellow, Cyan, Magenta, Inventory";
place.controller = quick_tut_catalyst_place_controller_obj;
ds_list_add(place.level_configs_list, "tutorial", "movement", "base_colors", "inventory");


place = add_place_in_room(room_quick_tut_basic_combat, "Trial by fire", 0,0, 9600,4800, 320);
place.description = "Barrage attack, Spitter mobs, Channeling, Dash-Wave attack, Sprinkler mini-boss";
place.controller = quick_tut_basic_combat_place_controller_obj;
ds_list_add(place.level_configs_list, "movement", "full_colors", "blast_only", "inventory");


/*
place = add_place_in_room(room_quick_tut_advanced_combat, "Space ship old", 0,0, 6784,3840, 384);
place.description = "Vortex attack, Shield, Combat trial, Abilities - Invisibility, Blink";
place.controller = quick_tut_advanced_combat_place_controller_obj;
ds_list_add(place.level_configs_list, "movement", "full_colors", "basic_combat", "inventory", "black_orb");
place.forced_modifiers[? "cannons"] = false;
*/

place = add_place_in_room(room_quick_tut_advanced_combat_new, "Space ship", 0,0, 9600,4800, 384);
place.description = "Vortex attack, Shield, Crystal, Shards, Plasma Cannon, PvP Combat";
place.controller = quick_tut_advanced_combat_new_place_controller_obj;
ds_list_add(place.level_configs_list, "movement", "full_colors", "basic_combat", "inventory", "black_orb");
place.forced_modifiers[? "base_crystals"] = true;
place.forced_modifiers[? "cannons"] = true;


place = add_place_in_room(room_quick_tut_abilities, "Arcane library", 0,0, 5376,5376, 384);
place.description = "Heal, Invisiblity, Berserk, Haste, Ubershield, Rewind, Blink, Teleport";
place.controller = quick_tut_abilities_place_controller_obj;
ds_list_add(place.level_configs_list, "movement", "full_colors", "basic_combat", "shield", 
                                      "inventory", "black_orb", "just_2orbs_start", "no_abilities");
place.forced_modifiers[? "orbs_energy_lock" ] = true;
place.forced_modifiers[? "base_crystals"] = true;
place.forced_modifiers[? "abilities"] = true;


place_count = ds_list_size(places);
current_place = places[|0];
