function init_script() {
	show_debug_message("INIT START");
	randomize();
	instance_create(0,0,DB);
	DB.version_string = "P.E.B.B.L.E.S. v"+GM_version+" Alpha";
	create_tips(DB);

	draw_set_circle_precision(DB.circle_precision);

	if(debug_mode)
	{
	    show_debug_overlay(true);
	}


	DB.sound_cutoff_dist = 800;
	DB.max_jump_pad_power = 35;

	
	// PLAYERS
	DB.player_names = ds_list_create();

	if(file_exists(working_directory + "players.dat"))
	{
	    var file = file_text_open_read(working_directory + "players.dat");
	    var str = file_text_read_string(file);
	    ds_list_read(DB.player_names,str);
	    while(ds_list_find_index(DB.player_names,"") != -1)
	    {
	        ds_list_delete(DB.player_names,ds_list_find_index(DB.player_names,""));
	    }
	    file_text_close(file);
	}

	if(ds_list_size(DB.player_names) == 0)
	{
	    ds_list_add(DB.player_names, "Johny Daison");
	    ds_list_add(DB.player_names, "Ray Jacques");
	}


	// COLOR TO EFFECT MAP
	DB.color_effects = ds_map_create();

	//DB.color_effects[? g_black] = noone;
	DB.color_effects[? g_red] = DB.status_effects[? "burn"];
	DB.color_effects[? g_green] = DB.status_effects[? "slow"];
	DB.color_effects[? g_blue] = DB.status_effects[? "frozen"];
	DB.color_effects[? g_yellow] = DB.status_effects[? "confusion"];
	DB.color_effects[? g_azure] = DB.status_effects[? "bounce"];
	//DB.color_effects[? g_purple] = DB.status_effects[? "weakness"];
	DB.color_effects[? g_purple] = DB.status_effects[? "suppressed"];
	DB.color_effects[? g_white] = DB.status_effects[? "heavy_shots"];
	DB.color_effects[? g_octarine] = DB.status_effects[? "shield_down"];

	// DEFAULT STARTING SLOTS NUMBER
	/*
	DB.arena_slots = 1;
	DB.starting_slots = 0;
	*/

	// ARENAS
	// TODO: this shouldn't be used anymore
	/*
	DB.arenas = ds_map_create();
	DB.arena_names = ds_list_create();
	var i=0;

	DB.arenas[? i++] =   testroom;
	ds_list_add(DB.arena_names,  "Testing Room");
	DB.arenas[? i++] =   crumble_arena;
	ds_list_add(DB.arena_names,  "4-Player Crumble");
	DB.arenas[? i++] =   closed_quarters_arena;
	ds_list_add(DB.arena_names,  "Closed Quarters");
	DB.arenas[? i++] =   classic_arena;
	ds_list_add(DB.arena_names,  "Classic Arena");
	DB.arenas[? i++] =   face_arena;
	ds_list_add(DB.arena_names,  "Second Arena");
	DB.arenas[? i++] =   domination1;
	ds_list_add(DB.arena_names,  "Domination");
	DB.arenas[? i++] =   alpinus_sandbox;
	ds_list_add(DB.arena_names,  "Alpinus Sandbox");
	DB.arenas[? i++] =   skull_bones;
	ds_list_add(DB.arena_names,  "Skull & Bones");
	DB.arenas[? i++] =   big_arena;
	ds_list_add(DB.arena_names,  "Big Arena");
	DB.arenas[? i++] =   room_snake_test;
	ds_list_add(DB.arena_names,  "Snake test");
	*/


	// MAP OF GAME COLORS TO ABILITIES
	DB.abimap = ds_map_create();
	DB.abimap[? -1] =   "self_destruct";
	DB.abimap[? g_black] =   "rewind";
	DB.abimap[? g_red] =  "berserk";
	DB.abimap[? g_green] =  "heal";
	DB.abimap[? g_blue] =  "teleport";
	DB.abimap[? g_yellow] =  "haste";
	DB.abimap[? g_purple] =  "ubershield";
	DB.abimap[? g_azure] =  "invisibility";
	DB.abimap[? g_white] =  "base_teleport";

	DB.abi_name_map = ds_map_create();
	DB.abi_name_map[? -1] =   "Self destruct";
	DB.abi_name_map[? g_black] =   "Rewind";
	DB.abi_name_map[? g_red] =  "Berserk";
	DB.abi_name_map[? g_green] =  "Heal";
	DB.abi_name_map[? g_blue] =  "Blink";
	DB.abi_name_map[? g_yellow] =  "Haste";
	DB.abi_name_map[? g_purple] =  "Ubershield";
	DB.abi_name_map[? g_azure] =  "Invisibility";
	DB.abi_name_map[? g_white] =  "Teleport";

	DB.abi_description_map = ds_map_create();
	DB.abi_description_map[? -1] =   "End your existence.";
	DB.abi_description_map[? g_black] =   "Go 2 seconds back in time.";
	DB.abi_description_map[? g_red] =  "Charge spells faster.";
	DB.abi_description_map[? g_green] =  "Regenerate HP over time.";
	DB.abi_description_map[? g_blue] =  "Instantly appear elsewhere.";
	DB.abi_description_map[? g_yellow] =  "Run faster.";
	DB.abi_description_map[? g_purple] =  "Double your Shield or create new one.";
	DB.abi_description_map[? g_azure] =  "Make Turrets, Mobs and NPCs ignore you.";
	DB.abi_description_map[? g_white] =  "Return to Base.";

	DB.abi_icons = ds_map_create();
	DB.abi_icons[? -1] =   selfdestruct_icon;
	DB.abi_icons[? g_black] =   flashback_icon;
	DB.abi_icons[? g_red] =  berserk_icon;
	DB.abi_icons[? g_green] =  heal_icon;
	DB.abi_icons[? g_blue] =  teleport_icon;
	DB.abi_icons[? g_yellow] =  haste_icon;
	DB.abi_icons[? g_purple] =  ubershield_icon;
	DB.abi_icons[? g_azure] =  invisibility_icon;
	DB.abi_icons[? g_white] =  chaos_drive_icon;


	create_collision_map(DB);

	// LIMITS MAP
	DB.limit_ids = ds_list_create();
	DB.limit_values = ds_map_create();

	DB.limit_ids[| 0] =  "score";
	DB.limit_values[? 0] =  400;
	DB.limit_ids[| 1] =  "kills";
	DB.limit_values[? 1] =  20;
	DB.limit_ids[| 2] =  "deaths";
	DB.limit_values[? 2] =  20;
	DB.limit_ids[| 3] =  "time";
	DB.limit_values[? 3] =  15;
	DB.limit_ids[| 4] =  "walls";
	DB.limit_values[? 4] =  42;
	DB.limit_ids[| 5] =  "sudden_death";
	DB.limit_values[? 5] =  13;

	DB.limit_count = ds_list_size(DB.limit_ids);

	// RESOLUTIONS
	DB.resolution_list = ds_list_create();
	ds_list_add(DB.resolution_list, "1280x720");
	ds_list_add(DB.resolution_list, "1280x800");
	ds_list_add(DB.resolution_list, "1366x768");
	ds_list_add(DB.resolution_list, "1440x900");
	ds_list_add(DB.resolution_list, "1440x1080");
	ds_list_add(DB.resolution_list, "1600x900");
	ds_list_add(DB.resolution_list, "1680x1050");
	ds_list_add(DB.resolution_list, "1760x990");
	ds_list_add(DB.resolution_list, "1920x1080");
	ds_list_add(DB.resolution_list, "3200x900");
	ds_list_add(DB.resolution_list, "3840x1080");
	ds_list_add(DB.resolution_list, "3200x1800");
	ds_list_add(DB.resolution_list, "3840x2160");

	show_debug_message("CREATE SINGLETON");

	// CREATE SINGLETONS
	instance_create(0, 0, event_manager);
	instance_create(0, 0, singleton_obj);
	//instance_create(0, 0, tester_obj);


	// LOAD SETTINGS
	ini_open("pebbles_settings.ini");

	var res = ini_read_string("Graphics", "resolution", string(singleton_obj.windowed_width) + "x" + string(singleton_obj.windowed_height));

	var xpos = string_pos("x", res);
	var res_width = round(real(string_copy(res, 1, xpos - 1)));
	var res_height = round(real(string_copy(res, xpos + 1, string_length(res) - xpos)));

	with(singleton_obj)
	{
	    windowed_width = res_width;
	    windowed_height = res_height;
    
	    fullscreen_width = res_width;
	    fullscreen_height = res_height;
	}


	singleton_obj.fullscreen =          !!ini_read_real("Graphics", "fullscreen", singleton_obj.fullscreen);
	singleton_obj.draw_object_labels =  !!ini_read_real("Graphics", "draw_object_labels", singleton_obj.draw_object_labels);
	singleton_obj.scale_up_gui =        !!ini_read_real("Graphics", "scale_up_gui", singleton_obj.scale_up_gui);
	singleton_obj.vsync =               !!ini_read_real("Graphics", "vsync", singleton_obj.vsync);
    singleton_obj.aa_level =            !!ini_read_real("Graphics", "aa_level", singleton_obj.aa_level);
    singleton_obj.interpolate =         !!ini_read_real("Graphics", "interpolate", singleton_obj.interpolate);


	singleton_obj.game_speed =      round(clamp( ini_read_real("Game", "game_speed", singleton_obj.game_speed),  30, 60));
	singleton_obj.force_feedback =  !!ini_read_real("Game", "force_feedback", singleton_obj.force_feedback);
	DB.npc_speech_tick =            round(clamp( ini_read_real("Game", "npc_speech_tick", DB.npc_speech_tick),  1, DB.max_npc_speech_tick));

	update_master_volume( round( ini_read_real("Sound", "master_volume", singleton_obj.master_volume)) );

	ini_close();


	show_debug_message("INIT END");
}
