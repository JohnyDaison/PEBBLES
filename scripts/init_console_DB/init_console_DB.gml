function init_console_DB() {
    console_history = ds_list_create();
    console_history_cur_item = -1;
    console_history_selection_pos = -1;
    console_command_history = ds_list_create();
    console_menu = ds_map_create();
    console_scripts = ds_map_create();
    console_vars = ds_map_create();
    console_modes = ds_map_create();
    console_watches = ds_list_create();
    console_secrets = ds_list_create();
    console_commands_saved = ds_list_create();
    console_divider_max_steps = 10;
    console_divider_step_length = 12;
    console_popup_on_log = false;
    
    var ccs = console_commands_saved;

    ds_list_add(ccs, "mode debug");
    ds_list_add(ccs, "mode test");
    ds_list_add(ccs, "mode play");
    
    /*
    ds_list_add(ccs, "playerquests 1");
    ds_list_add(ccs, "playerquestrecheck 1");
    ds_list_add(ccs, "questdebug");
    */

    ds_list_add(ccs, "camfollow 1 basic_bot");
    ds_list_add(ccs, "goto_quest 1000");

    ds_list_add(ccs, "killall mob");
    ds_list_add(ccs, "killall spark");
    ds_list_add(ccs, "spawn slime 100");
    ds_list_add(ccs, "spawn spitter 100");

    ds_list_add(ccs, "consolebg");
    

    objectmap = ds_map_create();

    create_objectmap();

    ds_list_add(console_secrets, "iamcheatsidoodlin", "elephant");
    
    // NOTE: "object [, object, string]" is valid;
    // "object, [object, string]" will be parsed the same as "object, object [, string]"

    add_console_script("help", console_help_script, "[string]", "Type \"help str\" to filter commands which contain string(1)");
    add_console_script("noop", empty_script, "", "Does nothing");
    add_console_script("parse", parse_stringvalue, "string, string", "Parse given string(2) as the given type(1)");
    add_console_script("restart", match_restart, "", "Restart the current room");
    add_console_script("gamespeed", getset_gamespeed, "[number]", "Set and/or display current game speed");

    add_console_script("replace", object_replace, "object, object", "Destroy instances(1) and for each create an instance of object(2)");
    add_console_script("transform", object_transform, "object [, object]", "Transform instances(1) to/from data_holder_obj");
    add_console_script("chunks", chunk_optimizer, "", "Run chunk update");
    add_console_script("chunksoff", chunk_deoptimizer, "", "Turn off chunk system");
    add_console_script("findholders", find_holders, "[string, string]", "List all data_holder_obj, or filter for key(1) == asset or number(2)");
    add_console_script("listevents", list_event_subscriptions, "", "List all event subscriptions, grouped by events");
    add_console_script("navgraph", navgraph_command, "", "Regenerate navigation graph");

    add_console_script("count", my_instance_number, "object", "Count the active instances of object(1)");
    add_console_script("grouplist", list_groups, "", "List object groups and their member counts");
    add_console_script("instlist", list_instances, "[object]", "List given instances. If no object(1) given, list possible values");
    add_console_script("instinfo", get_instance_info, "object", "Show some info about given instance or first instance of given object");
    add_console_script("killall", kill_all_command, "[object]", "Destroy all given instances (if object(1) not given, all game_obj)");
    add_console_script("spawn", spawn_command, "object [, number]", "Spawn object(1) at mouse cursor, number(2) times");
    add_console_script("listds", list_ds, "", "List dynamic structures in ds_registry");
    add_console_script("getvalue", get_value_command, "[object, string]", "For all instances(1) print the value of variable(2)");
    add_console_script("setnumber", set_single_value, "object, string, number", "For all instances(1) set variable(2) to number(3)");
    add_console_script("setstring", set_single_value, "object, string, string", "For all instances(1) set variable(2) to string(3)");
    add_console_script("objname", obj_getname, "number", "Return name of the object with given ID(1)");
    add_console_script("spritename", spr_getname, "number", "Return name of the sprite with given ID(1)");
    add_console_script("dumpinst", command_dump_instance, "number", "List all variables and values of instance(1)");
    add_console_script("dumplist", command_dump_list, "number", "List all values in list(1)");
    add_console_script("dumpmap", command_dump_map, "number", "List all keys and values of map(1)");

    add_console_script("camfollow", camera_override, "number, object", "Make the camera(1) follow instance(2)");
    add_console_script("camgoto", camera_position, "number, number, number", "Move the camera(1) to coordinates[2,3]");
    add_console_script("camreset", camera_resume, "number", "Reset the camera(1) to normal behavior");

    add_console_script("questlist", quest_nodes_printout, "", "List all quest IDs in the game");
    add_console_script("questdebug", quest_debug_printout, "[string]", "Show definitions of all quests [whose ID contains string(1)]");
    add_console_script("playerquests", player_quest_log_printout, "number [, number]", "Show quests of player(1)[, with level of detail(2)]");
    add_console_script("playerstartquest", player_quest_start_command, "number, string, string, string", "Player(1) receives quest(2) with context(3) and type(4)");
    add_console_script("playerskiptoquest", player_quest_skip_to_command, "number, number", "Complete all subquests of the player's(1) main quest up to index(2)");
    add_console_script("playerquestrecheck", player_quests_recheck_command, "number", "Update the state of given player's(1) quests");
    add_console_script("goto_quest", go_to_quest_command, "number", "For Player 1, complete all subquests of the main quest up to given index(1)");

    add_console_script("playerlevels", show_player_levels, "number", "Show levels of player(1)");

    add_console_script("consolebg", console_background_toggle, "[number]", "Show/Hide console background");
    add_console_script("mode", console_mode_command, "[string]", "Set and/or display console mode (play|test|debug)");
    add_console_script("debugkeylist", command_debug_key_list, "[string]", "List key combos usable in test/debug mode[, filtered by string(1)]");

    add_console_script("circle_precision", circle_precision_command, "number", "Set number of triangles per circle (must be 4*k)");

    add_console_script("test", test_command, "string", "Run the test script with given ID(1)");
    add_console_script("elephant", elephant_command, "", "Makes the Elephant in Main Menu come out right away");

    //add_console_script("iamcheatsindoodlin", console_mode_cheats, "");

    //add_console_script("watch", watch_script, "string, string"); // label, command
    //add_console_script("unwatch", unwatch_script, "number"); // watch ID

    var common = ds_list_create();

    ds_list_add(common, "help", "noop", "parse", "restart", "gamespeed", "elephant");

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

    ds_list_add(test, "killall", "spawn", "test", "getvalue", "count", "navgraph");
    console_modes[? "test"] = test;


    // debug
    var debug = ds_list_create();
    ds_list_copy(debug, test);

    ds_list_add(debug, "replace", "transform", "chunks", "chunksoff", "findholders", "listevents");

    ds_list_add(debug, "grouplist", "instlist", "instinfo", "listds", "setnumber", "setstring", "objname", "spritename");
    ds_list_add(debug, "dumpinst", "dumplist", "dumpmap");

    ds_list_add(debug, "questlist", "questdebug", "playerstartquest", "playerquestrecheck");
    console_modes[? "debug"] = debug;



    ds_list_destroy(common);


    console_mode = "test"; // play test debug

    if(debug_mode)
    {
        console_mode = "debug";
    }

    debug_keys_list = create_debug_keys_list();
}
