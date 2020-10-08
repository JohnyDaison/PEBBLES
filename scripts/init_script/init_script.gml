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

	// CONTROLS
	DB.mouse_has_moved = false;
	DB.keynames = ds_map_create();
	DB.joynames = ds_map_create();
	DB.padnames = ds_map_create();

	DB.keynames[? vk_left] =  "Left";
	DB.keynames[? vk_right] =  "Right";
	DB.keynames[? vk_up] =  "Up";
	DB.keynames[? vk_down] =  "Down";
	DB.keynames[? vk_enter] =  "Enter";
	DB.keynames[? vk_escape] =  "Esc";
	DB.keynames[? vk_space] =  "Space";
	DB.keynames[? vk_shift] =  "Shift";
	DB.keynames[? vk_control] =  "Ctrl";
	DB.keynames[? vk_alt] =  "Alt";
	DB.keynames[? vk_backspace] =  "Backspace";
	DB.keynames[? vk_tab] =  "Tab";
	DB.keynames[? vk_home] =  "Home";
	DB.keynames[? vk_end] =  "End";
	DB.keynames[? vk_delete] =  "Delete";
	DB.keynames[? vk_insert] =  "Insert";
	DB.keynames[? vk_pageup] =  "Page Up";
	DB.keynames[? vk_pagedown] =  "Page Down";
	DB.keynames[? vk_pause] =  "Pause";
	DB.keynames[? vk_printscreen] =  "PrtScr";
	i=0;
	repeat(12)
	{
	    DB.keynames[? vk_f1+i] =  "F"+string(i+1);
	    i+=1;
	}

	i=0;
	repeat(10)
	{
	    DB.keynames[? 48+i] =  string(i);
	    i+=1;
	}
	i=0;
	repeat(10)
	{
	    DB.keynames[? vk_numpad0+i] =  "NUM"+string(i);
	    i+=1;
	}

	DB.keynames[? vk_multiply] =  "NUM*";
	DB.keynames[? vk_divide] =  "NUM/";
	DB.keynames[? vk_add] =  "NUM+";
	DB.keynames[? vk_subtract] =  "NUM-";
	DB.keynames[? vk_decimal] =  "NUM.";
	DB.keynames[? vk_lshift] =  "L Shift";
	DB.keynames[? vk_lcontrol] =  "L Ctrl";
	DB.keynames[? vk_lalt] =  "L Alt";
	DB.keynames[? vk_rshift] =  "R Shift";
	DB.keynames[? vk_rcontrol] =  "R Ctrl";
	DB.keynames[? vk_ralt] =  "R Alt";

	DB.keynames[? 186] =  ";";
	DB.keynames[? 187] =  "=";
	DB.keynames[? 188] =  ",";
	DB.keynames[? 189] =  "-";
	DB.keynames[? 190] =  ".";
	DB.keynames[? 191] =  "/";
	DB.keynames[? 192] =  "`";

	DB.keynames[? 219] =  "[";
	DB.keynames[? 220] =  "\\";
	DB.keynames[? 221] =  "]";
	DB.keynames[? 222] =  "'";

	// JOYSTICKS NAMES
	DB.joynames[? joy_up] =  "Stick Up";
	DB.joynames[? joy_down] =  "Stick Down";
	DB.joynames[? joy_left] =  "Stick Left";
	DB.joynames[? joy_right] =  "Stick Right";
	DB.joynames[? joy_dpad_up] =  "D-Pad Up";
	DB.joynames[? joy_dpad_down] =  "D-Pad Down";
	DB.joynames[? joy_dpad_left] =  "D-Pad Left";
	DB.joynames[? joy_dpad_right] =  "D-Pad Right";
	DB.joynames[? joy_rtrigger] =  "R Trigger";
	DB.joynames[? joy_ltrigger] =  "L Trigger";
	DB.joynames[? joy_look] =  "Joy Look";

	DB.joynames[? 1] =  "(A)";
	DB.joynames[? 2] =  "(B)";
	DB.joynames[? 3] =  "(X)";
	DB.joynames[? 4] =  "(Y)";
	DB.joynames[? 5] =  "L Bumper";
	DB.joynames[? 6] =  "R Bumper";
	DB.joynames[? 7] =  "Back (<)";
	DB.joynames[? 8] =  "Start (>)";
	DB.joynames[? 9] =  "Stick Button";
	DB.joynames[? 10] =  "RS Button";

	for(i=11;i<20;i+=1)
	{
	    DB.joynames[? i] =  "Joy Button "+string(i);
	}

	// GAMEPAD NAMES
	DB.padnames[? gamepad_up] =  "Stick Up";
	DB.padnames[? gamepad_down] =  "Stick Down";
	DB.padnames[? gamepad_left] =  "Stick Left";
	DB.padnames[? gamepad_right] =  "Stick Right";
	DB.padnames[? gp_padu] =  "D-Pad Up";
	DB.padnames[? gp_padd] =  "D-Pad Down";
	DB.padnames[? gp_padl] =  "D-Pad Left";
	DB.padnames[? gp_padr] =  "D-Pad Right";
	DB.padnames[? gp_shoulderrb] =  "R Trigger";
	DB.padnames[? gp_shoulderlb] =  "L Trigger";
	DB.padnames[? gamepad_stick] =  "Stick Button";

	DB.padnames[? gp_face1] =  "(A)";
	DB.padnames[? gp_face2] =  "(B)";
	DB.padnames[? gp_face3] =  "(X)";
	DB.padnames[? gp_face4] =  "(Y)";
	DB.padnames[? gp_shoulderl] =  "L Bumper";
	DB.padnames[? gp_shoulderr] =  "R Bumper";
	DB.padnames[? gp_select] =  "Back (<)";
	DB.padnames[? gp_start] =  "Start (>)";
	DB.padnames[? gp_stickl] =  "LStick Button";
	DB.padnames[? gp_stickr] =  "RStick Button";


	// GUY SKINS
	DB.guy_skins = ds_map_create();
	//DB.guy_skins[? "orig"] = ds_map_create();
	DB.guy_skins[? "glowstick"] = ds_map_create();
	//DB.guy_skins[? "blackbody"] = ds_map_create();
	var glowstick = DB.guy_skins[? "glowstick"];

	ds_map_replace(glowstick, "guy_stand", guy_stand);
	ds_map_replace(glowstick, "guy_idle", guy_idle);
	ds_map_replace(glowstick, "guy_walk", guy_walk);
	ds_map_replace(glowstick, "guy_turn", guy_turn);
	ds_map_replace(glowstick, "guy_run", guy_run);
	ds_map_replace(glowstick, "guy_skid", guy_skid);
	ds_map_replace(glowstick, "guy_hurt", guy_hurt);
	ds_map_replace(glowstick, "guy_dead", guy_dead);
	ds_map_replace(glowstick, "guy_jump", guy_jump);
	ds_map_replace(glowstick, "guy_fall", guy_fall);
	ds_map_replace(glowstick, "guy_gettingup", guy_gettingup);
	ds_map_replace(glowstick, "guy_gettingdown", guy_gettingdown);
	ds_map_replace(glowstick, "guy_flybackwards", guy_flybackwards);
	ds_map_replace(glowstick, "guy_knockedback", guy_knockedback);
	ds_map_replace(glowstick, "guy_knockedforward", guy_knockedforward);
	ds_map_replace(glowstick, "guy_channeling", guy_channeling);
	ds_map_replace(glowstick, "guy_charging", guy_charging);
	ds_map_replace(glowstick, "guy_casting_forward", guy_casting_forward);
	ds_map_replace(glowstick, "guy_casting_up", guy_casting_up);
	ds_map_replace(glowstick, "guy_casting_down", guy_casting_down);
	ds_map_replace(glowstick, "guy_crouch", guy_crouch);
	ds_map_replace(glowstick, "guy_walljumphold", guy_walljumphold);
	ds_map_replace(glowstick, "guy_wallclimbhold", guy_wallclimbhold);
	ds_map_replace(glowstick, "guy_wallclimbup", guy_wallclimbup);
	ds_map_replace(glowstick, "guy_flip", guy_flip);
	ds_map_replace(glowstick, "guy_backflip", guy_backflip);


	// GUI CONTROLS
	for(i=0;i<4;i+=1) // directions
	{
	    for(ii=0;ii<4;ii+=1) // free to released
	    {
	        init_val = (ii==free);
	        DB.gui_controls[# i,ii] = init_val;
	    }
	}

	for(i=20;i<23;i+=1) // commands
	{
	    for(ii=0;ii<4;ii+=1) // free to released
	    {
	        init_val = (ii==free);
	        DB.gui_controls[# i,ii] = init_val;
	    }
	}


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


	// COLORS
	DB.colormap = ds_map_create();
	DB.colornames = ds_map_create();
	DB.colorpitch = ds_map_create();
	DB.colormatrix = ds_grid_create(9,9);

	// MAP OF GAME COLORS TO REPRESENTATIONS
	DB.colormap[? g_nothing] = c_black;
	DB.colormap[? g_black] = c_dkgray;
	DB.colormap[? g_red] = make_colour_rgb(255,20,20); //c_red;
	DB.colormap[? g_green] = make_colour_rgb(30,220,30); //0,200,0
	DB.colormap[? g_blue] = make_colour_rgb(50,50,255);  //50,55,255
	DB.colormap[? g_yellow] = make_colour_rgb(250,250,0);
	DB.colormap[? g_purple] = make_colour_rgb(240,50,240); //220,0,220
	DB.colormap[? g_azure] = make_colour_rgb(50,250,240); //50,220,220
	DB.colormap[? g_white] = c_white;
	DB.colormap[? g_octarine] = c_ltgray;
	DB.colormap[? "bf_orange"] = make_colour_rgb(252,135,10);

	// MAP OF GAME COLORS TO NAMES
	DB.colornames[? g_nothing] = "Void";
	DB.colornames[? g_black] = "Dark";
	DB.colornames[? g_red] = "Red";
	DB.colornames[? g_green] = "Green";
	DB.colornames[? g_blue] = "Blue";
	DB.colornames[? g_yellow] = "Yellow";
	DB.colornames[? g_purple] = "Magenta";
	DB.colornames[? g_azure] = "Cyan";
	DB.colornames[? g_white] = "White";
	DB.colornames[? g_octarine] = "Octarine";

	// MAP OF GAME COLORS TO PITCHES
	DB.colorpitch[? g_black] = 0.666;
	DB.colorpitch[? g_red] = 0.786;
	DB.colorpitch[? g_yellow] = 0.885;
	DB.colorpitch[? g_green] = 1;
	DB.colorpitch[? g_azure] = 1.1;
	DB.colorpitch[? g_blue] = 1.15;
	DB.colorpitch[? g_purple] = 1.3;
	DB.colorpitch[? g_white] = 1.4;
	DB.colorpitch[? g_octarine] = 1.5;

	// COLOR MATRIX - POWER RATIOS
    var pow;
	pow[0] = -0.10;
	pow[1] = 0.25;
	pow[2] = 0.50;
	pow[3] = 0.75;
	pow[4] = 1.00;
	pow[5] = 1.25;

	// init all - base
	ds_grid_set_region(DB.colormatrix, g_black, g_black, g_octarine, g_octarine, pow[2]);

	// double vs. (black/dark and basic) - base
	/*
	ds_grid_set_region(DB.colormatrix, g_yellow, g_black, g_yellow, g_green, pow[3]);
	ds_grid_set_region(DB.colormatrix, g_azure, g_blue, g_purple, g_blue, pow[3]);
	ds_grid_set_region(DB.colormatrix, g_azure, g_black, g_purple, g_green, pow[3]);
	*/

	// basic vs. black/dark
	/*
	ds_grid_set(DB.colormatrix, g_red, g_black, pow[3]);
	ds_grid_set(DB.colormatrix, g_green, g_black, pow[3]);
	ds_grid_set(DB.colormatrix, g_blue, g_black, pow[3]);
	*/

	// basic and double vs black/dark
	ds_grid_set_region(DB.colormatrix, g_red, g_black, g_azure, g_black, pow[3]);

	// buffed basic vs. basic
	/*
	ds_grid_set(DB.colormatrix, g_red, g_green, pow[3]);
	ds_grid_set(DB.colormatrix, g_green, g_blue, pow[3]);
	ds_grid_set(DB.colormatrix, g_blue, g_red, pow[3]);
	*/

	// buffed basic vs. basic
	ds_grid_set(DB.colormatrix, g_red, g_green, pow[4]);
	ds_grid_set(DB.colormatrix, g_green, g_blue, pow[4]);
	ds_grid_set(DB.colormatrix, g_blue, g_red, pow[4]);

	// new debuffed basic vs. basic
	ds_grid_set(DB.colormatrix, g_green, g_red, pow[1]);
	ds_grid_set(DB.colormatrix, g_blue, g_green, pow[1]);
	ds_grid_set(DB.colormatrix, g_red, g_blue, pow[1]);

	// debuffed basic vs. double
	/*
	ds_grid_set(DB.colormatrix, g_red, g_azure, pow[1]);
	ds_grid_set(DB.colormatrix, g_green, g_purple, pow[1]);
	ds_grid_set(DB.colormatrix, g_blue, g_yellow, pow[1]);
	*/

	// buffed basic vs. double
	ds_grid_set(DB.colormatrix, g_red, g_azure, pow[4]);
	ds_grid_set(DB.colormatrix, g_green, g_purple, pow[4]);
	ds_grid_set(DB.colormatrix, g_blue, g_yellow, pow[4]);


	// buffed double vs. basic
	/*
	ds_grid_set(DB.colormatrix, g_yellow, g_blue, pow[4]);
	ds_grid_set(DB.colormatrix, g_purple, g_green, pow[4]);
	ds_grid_set(DB.colormatrix, g_azure, g_red, pow[4]);
	*/

	// debuffed double vs. basic
	ds_grid_set(DB.colormatrix, g_yellow, g_blue, pow[1]);
	ds_grid_set(DB.colormatrix, g_purple, g_green, pow[1]);
	ds_grid_set(DB.colormatrix, g_azure, g_red, pow[1]);

	// buffed double vs. double
	ds_grid_set(DB.colormatrix, g_yellow, g_azure, pow[4]);
	ds_grid_set(DB.colormatrix, g_purple, g_yellow, pow[4]);
	ds_grid_set(DB.colormatrix, g_azure, g_purple, pow[4]);

	// new debuffed double vs. double
	ds_grid_set(DB.colormatrix, g_azure, g_yellow, pow[1]);
	ds_grid_set(DB.colormatrix, g_yellow, g_purple, pow[1]);
	ds_grid_set(DB.colormatrix, g_purple, g_azure, pow[1]);

	// basic vs. white
	/*
	ds_grid_set(DB.colormatrix, g_red, g_white, pow[2]);
	ds_grid_set(DB.colormatrix, g_green, g_white, pow[2]);
	ds_grid_set(DB.colormatrix, g_blue, g_white, pow[2]);
	*/

	// basic vs. white 
	ds_grid_set(DB.colormatrix, g_red, g_white, pow[3]);
	ds_grid_set(DB.colormatrix, g_green, g_white, pow[3]);
	ds_grid_set(DB.colormatrix, g_blue, g_white, pow[3]);

	// double vs. white

	ds_grid_set(DB.colormatrix, g_yellow, g_white, pow[1]);
	ds_grid_set(DB.colormatrix, g_purple, g_white, pow[1]);
	ds_grid_set(DB.colormatrix, g_azure, g_white, pow[1]);


	// white vs. basic
	/*
	ds_grid_set(DB.colormatrix, g_white, g_red, pow[4]);
	ds_grid_set(DB.colormatrix, g_white, g_green, pow[4]);
	ds_grid_set(DB.colormatrix, g_white, g_blue, pow[4]);
	*/

	// white vs. basic
	ds_grid_set(DB.colormatrix, g_white, g_red, pow[3]);
	ds_grid_set(DB.colormatrix, g_white, g_green, pow[3]);
	ds_grid_set(DB.colormatrix, g_white, g_blue, pow[3]);

	// white vs. double
	/*
	ds_grid_set(DB.colormatrix, g_white, g_yellow, pow[4]);
	ds_grid_set(DB.colormatrix, g_white, g_purple, pow[4]);
	ds_grid_set(DB.colormatrix, g_white, g_azure, pow[4]);
	*/

	// white vs. black
	ds_grid_set(DB.colormatrix, g_white, g_black, pow[4]);

	// octarine vs. all
	ds_grid_set_region(DB.colormatrix, g_octarine, g_black, g_octarine, g_octarine, pow[4]);

	// other vs. octarine
	ds_grid_set_region(DB.colormatrix, g_black, g_octarine, g_white, g_octarine, pow[4]);

	// the main diagonal minus black and octarine
	for(i=g_red; i<=g_white; i+=1)
	{
	    ds_grid_set(DB.colormatrix, i, i, pow[0]);
	}


	// COLOR DIRECTIONS
	DB.colordirs = ds_map_create();
	DB.colordirs[? g_red] = 0;
	DB.colordirs[? g_yellow] = 0.66;
	DB.colordirs[? g_green] = 1.33;
	DB.colordirs[? g_azure] = 2;
	DB.colordirs[? g_blue] = 2.66;
	DB.colordirs[? g_purple] = 3.33;

	// STATUS EFFECTS
	DB.status_effects = ds_map_create();

	DB.status_effects[? "burn"] = instance_create(0,0, status_burn_obj).id;
	DB.status_effects[? "frozen"] = instance_create(0,0, status_frozen_obj).id;
	DB.status_effects[? "slow"] = instance_create(0,0, status_slow_obj).id;
	DB.status_effects[? "confusion"] = instance_create(0,0, status_confusion_obj).id;
	DB.status_effects[? "weakness"] = instance_create(0,0, status_weakness_obj).id;
	DB.status_effects[? "suppressed"] = instance_create(0,0, status_suppressed_obj).id;
	DB.status_effects[? "bounce"] = instance_create(0,0, status_bounce_obj).id;
	DB.status_effects[? "heavy_shots"] = instance_create(0,0, status_heavy_shots_obj).id;

	DB.status_effects[? "tp_rush"] = instance_create(0,0, status_tp_rush_obj).id;
	DB.status_effects[? "overcharge"] = instance_create(0,0, status_overcharge_obj).id;
	DB.status_effects[? "shield_down"] = instance_create(0,0, status_shield_down_obj).id;

	DB.status_effects[? "berserk"] = instance_create(0,0, status_berserk_obj).id;
	DB.status_effects[? "heal"] = instance_create(0,0, status_heal_obj).id;
	DB.status_effects[? "haste"] = instance_create(0,0, status_haste_obj).id;
	DB.status_effects[? "ubershield"] = instance_create(0,0, status_ubershield_obj).id;
	DB.status_effects[? "invis"] = instance_create(0,0, status_invis_obj).id;

	DB.status_effect_count = ds_map_size(DB.status_effects);

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


	singleton_obj.game_speed =      round(clamp( ini_read_real("Game", "game_speed", singleton_obj.game_speed),  30, 60));
	singleton_obj.force_feedback =  !!ini_read_real("Game", "force_feedback", singleton_obj.force_feedback);
	DB.npc_speech_tick =            round(clamp( ini_read_real("Game", "npc_speech_tick", DB.npc_speech_tick),  1, DB.max_npc_speech_tick));

	update_master_volume( round( ini_read_real("Sound", "master_volume", singleton_obj.master_volume)) );

	ini_close();


	show_debug_message("INIT END");



}
