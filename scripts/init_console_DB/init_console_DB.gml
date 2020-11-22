function init_console_DB() {
	console_history = ds_list_create();
	console_command_history = ds_list_create();
	console_menu = ds_map_create();
	console_scripts = ds_map_create();
	console_vars = ds_map_create();
	console_modes = ds_map_create();
	console_watches = ds_list_create();
	console_secrets = ds_list_create();
	console_commands_saved = ds_list_create();
	var ccs = console_commands_saved;


	ds_list_add(ccs, "mode debug");
	ds_list_add(ccs, "mode test");
	ds_list_add(ccs, "mode play");
    
	/*
	ds_list_add(ccs, "playerquests 1");
	ds_list_add(ccs, "playerquestrecheck 1");
	ds_list_add(ccs, "questdebug");
	*/

	ds_list_add(ccs, "killall mob");
	ds_list_add(ccs, "killall spark");
	ds_list_add(ccs, "spawn slime 100");
	ds_list_add(ccs, "spawn spitter 100");


	ds_list_add(ccs, "consolebg");

	objectmap = ds_map_create();

	create_objectmap();

	ds_list_add(console_secrets, "iamcheatsidoodlin");

	// NOTE: "object [, object, string]" is valid;
	// "object, [object, string]" will be parsed the same as "object, object [, string]"

	add_console_script("help", console_help_script, "[string]", "Type \"help str\" to filter commands which contain str");
	add_console_script("noop", empty_script, "", "Does nothing");
	add_console_script("parse", parse_stringvalue, "string, string", "(type, data) Parse given string data as a given type");
	add_console_script("restart", match_restart, "", "Restart the current room");
	add_console_script("gamespeed", getset_gamespeed, "[number]", "Set and/or display current game speed");

	add_console_script("replace", object_replace, "object, object");
	add_console_script("transform", object_transform, "object [, object]");
	add_console_script("chunks", chunk_optimizer, "[object]");
	add_console_script("chunksoff", chunk_deoptimizer, "[object]");
	add_console_script("findholders", find_holders, "string [, string]");
	add_console_script("listevents", list_event_subscriptions, "");
	add_console_script("navgraph", navgraph_command, "");

	add_console_script("count", my_instance_number, "object", "Count the number of active instances of given object");
	add_console_script("grouplist", list_groups, "");
	add_console_script("instlist", list_instances, "[object]");
	add_console_script("instinfo", get_instance_info, "object");
	add_console_script("killall", kill_all_command, "[object]");
	add_console_script("spawn", spawn_command, "object [, number]");
	add_console_script("listds", list_ds, "");
	add_console_script("getprop", getprop, "object, string");
	add_console_script("setprop", setprop, "object, string, string");
    add_console_script("setnumber", set_number, "object, string, number");
	add_console_script("objname", obj_getname, "number", "Return name of the object with given id");
	add_console_script("spritename", spr_getname, "number", "Return name of the sprite with given id");

	add_console_script("camfollow", camera_override, "number, object", "Make a given camera follow given object");
	add_console_script("camgoto", camera_position, "number, number, number", "(cam, x, y) Move a given camera to given coordinates");
	add_console_script("camreset", camera_resume, "number", "Reset given camera to normal behavior");

	add_console_script("questlist", quest_nodes_printout, "");
	add_console_script("questdebug", quest_debug_printout, "[string]");
	add_console_script("playerquests", player_quest_log_printout, "number [, number]", "Show quests of given player[, with a given level of detail]");
	add_console_script("playerstartquest", player_quest_start_command, "number, string, string, string");
	add_console_script("playerskiptoquest", player_quest_skip_to_command, "number, number");
	add_console_script("playerquestrecheck", player_quests_recheck_command, "number");
	add_console_script("goto_quest", go_to_quest_command, "number");

	add_console_script("playerlevels", show_player_levels, "number", "Show levels of given player");

	add_console_script("consolebg", console_background_toggle, "[number]", "Show/Hide console background");
	add_console_script("mode", console_mode_command, "[string]", "Set and/or display console mode (play|test|debug)");
	add_console_script("debugkeylist", debug_keys_list, "[string]", "List key combos usable in test/debug mode");

	add_console_script("circle_precision", circle_precision_command, "number", "Set number of triangles per circle (must be 4*k)");

	add_console_script("test", test_command, "string", "Run a test script with given id");

	//add_console_script("iamcheatsindoodlin", console_mode_cheats, "");

	//add_console_script("watch", watch_script, "string, string"); // label, command
	//add_console_script("unwatch", unwatch_script, "number"); // watch id

	var common = ds_list_create();

	ds_list_add(common, "help", "noop", "parse", "restart", "gamespeed");

	ds_list_add(common, "playerlevels", "playerquests", "consolebg", "mode");


	// play
	var play = ds_list_create();
	ds_list_copy(play, common);
	console_modes[? "play"] = play;


	// test
	var test = ds_list_create();
	ds_list_copy(test, play);

	ds_list_add(test, "camfollow", "camgoto", "camreset");

	ds_list_add(test, "debugkeylist", "circle_precision", "playerskiptoquest", "goto_quest");

	ds_list_add(test, "killall", "spawn", "test");
	console_modes[? "test"] = test;


	// debug
	var debug = ds_list_create();
	ds_list_copy(debug, test);

	ds_list_add(debug, "replace", "transform", "chunks", "chunksoff", "findholders", "listevents", "navgraph");

	ds_list_add(debug, "count", "grouplist", "instlist", "instinfo", "listds", "getprop", "setprop", "setnumber", "objname", "spritename");

	ds_list_add(debug, "questlist", "questdebug", "playerstartquest", "playerquestrecheck");
	console_modes[? "debug"] = debug;



	ds_list_destroy(common);


	console_mode = "test"; // play test debug

	if(debug_mode)
	{
	    console_mode = "debug";
	}

	debug_keys_map = create_debug_keys_map();
}
