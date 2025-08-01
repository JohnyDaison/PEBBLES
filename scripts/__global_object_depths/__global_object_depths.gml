function __global_object_depths() {
    // Initialise the global array that allows the lookup of the depth of a given object
    // GM2.0 does not have a depth on objects so on import from 1.x a global array is created
    // NOTE: MacroExpansion is used to insert the array initialisation at import time
    gml_pragma( "global", "__global_object_depths()");

    // insert the generated arrays here
    global.__objectDepths[0] = 10; // camera_obj
    global.__objectDepths[1] = -910; // main_camera_obj
    global.__objectDepths[2] = -910; // player_camera_obj
    global.__objectDepths[3] = -901; // editor_camera
    global.__objectDepths[4] = 9010; // player_display_obj
    global.__objectDepths[5] = 0; // editor_terrain_obj
    global.__objectDepths[6] = 0; // editor_guy_spawner_obj
    global.__objectDepths[7] = 0; // editor_jump_pad_obj
    global.__objectDepths[8] = 0; // editor_turret_obj
    global.__objectDepths[9] = 1; // main_editor_toolbar
    global.__objectDepths[10] = 1; // main_tools_toolbar
    global.__objectDepths[11] = 1; // terrain_placer_toolbar
    global.__objectDepths[12] = 1; // structure_placer_toolbar
    global.__objectDepths[13] = 1; // place_toolbar
    global.__objectDepths[14] = 1; // minimap_toolbar
    global.__objectDepths[15] = 0; // terrain_placer_tool
    global.__objectDepths[16] = 0; // structure_placer_tool
    global.__objectDepths[17] = 0; // selection_tool_obj
    global.__objectDepths[18] = 0; // panning_tool_obj
    global.__objectDepths[19] = 0; // clear_tool
    global.__objectDepths[20] = 0; // load_tool
    global.__objectDepths[21] = 0; // save_tool
    global.__objectDepths[22] = -5; // grid_drawer
    global.__objectDepths[23] = -10; // selection_obj
    global.__objectDepths[24] = 0; // editor_object
    global.__objectDepths[25] = 0; // editor_structure_object
    global.__objectDepths[26] = 0; // tool_object
    global.__objectDepths[27] = 10; // basic_bot
    global.__objectDepths[28] = -50; // npc_waypoint_obj
    global.__objectDepths[29] = -22; // sprinkler_shield_obj
    global.__objectDepths[30] = -21; // sprinkler_gun_obj
    global.__objectDepths[31] = 0; // white_force_field_obj
    global.__objectDepths[32] = 0; // black_force_field_obj
    global.__objectDepths[33] = 150; // guy_spawner_obj
    global.__objectDepths[34] = -10; // color_orb_obj
    global.__objectDepths[35] = -6; // charge_ball_obj
    global.__objectDepths[36] = 0; // place_holder_obj
    global.__objectDepths[37] = 10; // player_guy
    global.__objectDepths[38] = 0; // guy_obj
    global.__objectDepths[39] = 0; // chargeball_provider_obj
    global.__objectDepths[40] = 10; // level_start_obj
    global.__objectDepths[41] = 10; // checkpoint_obj
    global.__objectDepths[42] = 10; // level_end_obj
    global.__objectDepths[43] = 150; // guide_spawner_obj
    global.__objectDepths[44] = 0; // pickup_spawner_obj
    global.__objectDepths[45] = -30; // emp_grenade_obj
    global.__objectDepths[46] = -30; // star_core_item_obj
    global.__objectDepths[47] = -30; // inversion_matrix_item_obj
    global.__objectDepths[48] = -30; // crystal_obj
    global.__objectDepths[49] = 0; // overcharge_obj
    global.__objectDepths[50] = 0; // tp_rush_obj
    global.__objectDepths[51] = 0; // opponent_tp_obj
    global.__objectDepths[52] = -20; // pickup_magnet_obj
    global.__objectDepths[53] = -10; // spraycan_item_obj
    global.__objectDepths[54] = -20; // ability_pickup_obj
    global.__objectDepths[55] = -20; // shield_item_obj
    global.__objectDepths[56] = -20; // chargeball_item_obj
    global.__objectDepths[57] = -20; // inventory_size_item_obj
    global.__objectDepths[58] = -20; // attack_suppressor_item_obj
    global.__objectDepths[59] = -20; // attack_unlocker_item_obj
    global.__objectDepths[60] = -20; // pulse_booster_item_obj
    global.__objectDepths[61] = -20; // charged_jump_item_obj
    global.__objectDepths[62] = -20; // wallclimb_item_obj
    global.__objectDepths[63] = -20; // color_belt_item_obj
    global.__objectDepths[64] = -20; // three_color_belts_item_obj
    global.__objectDepths[65] = -20; // black_belt_item_obj
    global.__objectDepths[66] = -20; // orbital_item_obj
    global.__objectDepths[67] = -20; // health_obj
    global.__objectDepths[68] = -20; // orb_battery_obj
    global.__objectDepths[69] = -20; // SECRET_obj
    global.__objectDepths[70] = -20; // qubit_obj
    global.__objectDepths[71] = -20; // sprinkler_body_obj
    global.__objectDepths[72] = -5; // spark_obj
    global.__objectDepths[73] = 0; // snake_mob_obj
    global.__objectDepths[74] = 0; // slime_mob_obj
    global.__objectDepths[75] = 0; // berserk_flame_obj
    global.__objectDepths[76] = 0; // burn_flame_obj
    global.__objectDepths[77] = 0; // cold_glow_obj
    global.__objectDepths[78] = 0; // tp_rush_lines_obj
    global.__objectDepths[79] = 0; // weak_particles_obj
    global.__objectDepths[80] = 0; // conf_stars_obj
    global.__objectDepths[81] = 0; // frozen_cage_obj
    global.__objectDepths[82] = 0; // slow_glow_obj
    global.__objectDepths[83] = 0; // bounce_glow_obj
    global.__objectDepths[84] = -1; // jump_burst_obj
    global.__objectDepths[85] = 0; // pixel_sucker_obj
    global.__objectDepths[86] = -15; // shield_obj
    global.__objectDepths[87] = 0; // black_projectile_obj
    global.__objectDepths[88] = 0; // slot_explosion_obj
    global.__objectDepths[89] = 0; // black_aoe_obj
    global.__objectDepths[90] = 0; // bigbang_obj
    global.__objectDepths[91] = 0; // star_core_obj
    global.__objectDepths[92] = 0; // big_projectile_obj
    global.__objectDepths[93] = 0; // artillery_projectile_obj
    global.__objectDepths[94] = 0; // small_projectile_obj
    global.__objectDepths[95] = 0; // slime_ball_obj
    global.__objectDepths[96] = 0; // energy_smoke_obj
    global.__objectDepths[97] = -15; // beam_end_obj
    global.__objectDepths[98] = -10; // beam_obj
    global.__objectDepths[99] = -5; // aoe_obj
    global.__objectDepths[100] = -10; // impact_obj
    global.__objectDepths[101] = -10; // energy_burst_obj
    global.__objectDepths[102] = -50; // dash_wave_obj
    global.__objectDepths[103] = 0; // collision_group_obj
    global.__objectDepths[104] = 0; // shield_wall_obj
    global.__objectDepths[105] = 5; // jump_pad_obj
    global.__objectDepths[106] = 9001; // monolith_obj
    global.__objectDepths[107] = 5; // universal_pad_obj
    global.__objectDepths[108] = 5; // smoke_vent_obj
    global.__objectDepths[109] = 300; // infodisplay_obj
    global.__objectDepths[110] = -9000; // ingame_camera_obj
    global.__objectDepths[111] = 420; // projector_obj
    global.__objectDepths[112] = 5; // ingame_screen_obj
    global.__objectDepths[113] = 90; // turret_mount_obj
    global.__objectDepths[114] = 90; // small_turret_mount_obj
    global.__objectDepths[115] = -10; // turret_body_obj
    global.__objectDepths[116] = 90; // beam_turret_mount_obj
    global.__objectDepths[117] = -20; // cannon_base_obj
    global.__objectDepths[118] = 50; // mob_portal_obj
    global.__objectDepths[119] = 95; // snake_trophy_obj
    global.__objectDepths[120] = 5; // piezoplate_obj
    global.__objectDepths[121] = 80; // antenna_obj
    global.__objectDepths[122] = 80; // energy_pusher_obj
    global.__objectDepths[123] = -1; // zpm_structure_obj
    global.__objectDepths[124] = 80; // energy_drain_rod_obj
    global.__objectDepths[125] = 25; // platform_obj
    global.__objectDepths[126] = 20; // one_way_pass_obj
    global.__objectDepths[127] = -27; // gate_obj
    global.__objectDepths[128] = -25; // gate_field_obj
    global.__objectDepths[129] = -810; // filter_projector_obj
    global.__objectDepths[130] = -700; // filter_field_obj
    global.__objectDepths[131] = 5; // teleporter_obj
    global.__objectDepths[132] = -10; // item_spawner_obj
    global.__objectDepths[133] = 100; // wall_obj
    global.__objectDepths[134] = 100; // perma_wall_obj
    global.__objectDepths[135] = -20; // grate_block_obj
    global.__objectDepths[136] = 90; // armored_wall_obj
    global.__objectDepths[137] = 0; // status_shield_down_obj
    global.__objectDepths[138] = 110; // artifact_obj
    global.__objectDepths[139] = 0; // status_burn_obj
    global.__objectDepths[140] = 0; // status_frozen_obj
    global.__objectDepths[141] = 0; // status_slow_obj
    global.__objectDepths[142] = 0; // status_weakness_obj
    global.__objectDepths[143] = 0; // status_confusion_obj
    global.__objectDepths[144] = 0; // status_bounce_obj
    global.__objectDepths[145] = 0; // status_overcharge_obj
    global.__objectDepths[146] = 0; // status_tp_rush_obj
    global.__objectDepths[147] = 0; // status_berserk_obj
    global.__objectDepths[148] = 0; // status_heal_obj
    global.__objectDepths[149] = 0; // status_haste_obj
    global.__objectDepths[150] = 0; // status_ubershield_obj
    global.__objectDepths[151] = 100; // spawn_effect_obj
    global.__objectDepths[152] = 0; // status_invis_obj
    global.__objectDepths[153] = 0; // terrain_group_obj
    global.__objectDepths[154] = 100; // winner_effect_obj
    global.__objectDepths[155] = 0; // display_group_obj
    global.__objectDepths[156] = 0; // guy_detect_zone_obj
    global.__objectDepths[157] = 0; // data_holder_obj
    global.__objectDepths[158] = 0; // chunkgrid_obj
    global.__objectDepths[159] = 0; // game_obj
    global.__objectDepths[160] = 0; // item_obj
    global.__objectDepths[161] = 0; // mob_obj
    global.__objectDepths[162] = 0; // particle_obj
    global.__objectDepths[163] = 0; // spell_obj
    global.__objectDepths[164] = 0; // projectile_obj
    global.__objectDepths[165] = 0; // energy_projectile_obj
    global.__objectDepths[166] = 0; // equipment_obj
    global.__objectDepths[167] = 0; // energyball_obj
    global.__objectDepths[168] = 0; // structure_obj
    global.__objectDepths[169] = 0; // terrain_obj
    global.__objectDepths[170] = 0; // field_obj
    global.__objectDepths[171] = 0; // turret_obj
    global.__objectDepths[172] = 0; // solid_terrain_obj
    global.__objectDepths[173] = 0; // status_effect_obj
    global.__objectDepths[174] = 0; // phys_body_obj
    global.__objectDepths[175] = 0; // non_terrain_obj
    global.__objectDepths[176] = 0; // obj_group_obj
    global.__objectDepths[177] = 0; // zone_obj
    global.__objectDepths[178] = 0; // non_game_obj
    global.__objectDepths[179] = 0; // gamemode_obj
    global.__objectDepths[182] = 0; // chase_obj
    global.__objectDepths[183] = 0; // colorizer_obj
    global.__objectDepths[184] = -48; // green_colorizer_obj
    global.__objectDepths[185] = -50; // red_colorizer_obj
    global.__objectDepths[186] = -49; // blue_colorizer_obj
    global.__objectDepths[187] = -50; // white_colorizer_obj
    global.__objectDepths[188] = -50; // aurora_colorizer_obj
    global.__objectDepths[189] = -50; // octarine_colorizer_obj
    global.__objectDepths[190] = 0; // precharger_obj
    global.__objectDepths[191] = 0; // perma_fire_obj
    global.__objectDepths[192] = 0; // energizer_obj
    global.__objectDepths[193] = 0; // deenergizer_obj
    global.__objectDepths[194] = 0; // round_energizer_obj
    global.__objectDepths[195] = 0; // editor_orb_obj
    global.__objectDepths[196] = 0; // red_orb_obj
    global.__objectDepths[197] = 0; // black_orb_obj
    global.__objectDepths[198] = 0; // blue_orb_obj
    global.__objectDepths[199] = 0; // green_orb_obj
    global.__objectDepths[200] = 10; // gate_enabled_obj
    global.__objectDepths[201] = 10; // gate_active_obj
    global.__objectDepths[202] = 0; // editor_antenna_obj
    global.__objectDepths[203] = 0; // editor_drain_rod_obj
    global.__objectDepths[204] = 0; // editor_projector_obj
    global.__objectDepths[205] = 0; // editor_energy_pusher_obj
    global.__objectDepths[206] = 0; // color_lock_obj
    global.__objectDepths[207] = 0; // editor_projection_obj
    global.__objectDepths[208] = 0; // terrain_dropper_obj
    global.__objectDepths[209] = -100; // group_configurator_obj
    global.__objectDepths[210] = 0; // player_obj
    global.__objectDepths[211] = -100; // singleton_obj
    global.__objectDepths[212] = 0; // DB
    global.__objectDepths[214] = 0; // phenomena_obj
    global.__objectDepths[215] = 0; // event_manager
    global.__objectDepths[216] = -10000; // screen_fade_obj
    global.__objectDepths[217] = 0; // menu_elephant_obj
    global.__objectDepths[218] = 0; // gui_button
    global.__objectDepths[219] = 0; // gui_checkbox
    global.__objectDepths[220] = 0; // gui_int_dial
    global.__objectDepths[222] = 0; // gui_keybinder
    global.__objectDepths[223] = 0; // gui_text_input
    global.__objectDepths[224] = 0; // gui_int_input
    global.__objectDepths[225] = 0; // gui_list_picker
    global.__objectDepths[226] = 0; // gui_dropdown
    global.__objectDepths[227] = 0; // gui_command_input
    global.__objectDepths[228] = 0; // gui_big_text
    global.__objectDepths[229] = -17; // gui_infoarea
    global.__objectDepths[230] = 0; // gui_label
    global.__objectDepths[231] = 0; // gui_pane
    global.__objectDepths[232] = -400; // gui_time
    global.__objectDepths[233] = 0; // gui_scroll_group
    global.__objectDepths[234] = 0; // gui_scroll_list
    global.__objectDepths[235] = 0; // battlefeed_item_obj
    global.__objectDepths[236] = -10000; // cursor_obj
    global.__objectDepths[237] = 0; // frame_manager
    global.__objectDepths[238] = -1000; // cmatrix_overlay
    global.__objectDepths[239] = -1500; // fps_overlay
    global.__objectDepths[240] = -950; // battlefeed_overlay
    global.__objectDepths[242] = -90; // key_overlay
    global.__objectDepths[244] = -100; // terrain_overlay
    global.__objectDepths[245] = -950; // center_overlay
    global.__objectDepths[246] = -1100; // inventory_overlay
    global.__objectDepths[247] = -1100; // healthbar_overlay
    global.__objectDepths[248] = -1400; // radial_overlay
    global.__objectDepths[251] = -950; // tutorial_overlay
    global.__objectDepths[252] = -950; // item_description_overlay
    global.__objectDepths[253] = -50; // damage_popup_obj
    global.__objectDepths[254] = -50; // energy_popup_obj
    global.__objectDepths[255] = -50; // stat_popup_obj
    global.__objectDepths[256] = -50; // text_popup_obj
    global.__objectDepths[257] = -500; // speech_popup_obj
    global.__objectDepths[258] = -16; // info_window
    global.__objectDepths[259] = -50; // name_plate_window
    global.__objectDepths[260] = -1200; // timer_window
    global.__objectDepths[261] = 1; // main_menu_window
    global.__objectDepths[262] = 1; // pause_menu_window
    global.__objectDepths[263] = 1; // control_settings_window
    global.__objectDepths[264] = 1; // graphic_settings_window
    global.__objectDepths[266] = 1; // match_setup_window
    global.__objectDepths[267] = 1; // match_summary_window
    global.__objectDepths[268] = 1; // jump_pad_config_window
    global.__objectDepths[269] = -9600; // console_window
    global.__objectDepths[270] = 0; // gui_object
    global.__objectDepths[271] = 0; // empty_window
    global.__objectDepths[272] = 0; // empty_frame
    global.__objectDepths[273] = 0; // empty_overlay
    global.__objectDepths[274] = 0; // empty_toolbar
    global.__objectDepths[275] = 0; // gui_element
    global.__objectDepths[276] = 0; // popup_obj
    global.__objectDepths[277] = 0; // input_device_obj
    global.__objectDepths[278] = 0; // keyboard_input_obj
    global.__objectDepths[280] = 0; // gamepad_input_obj
    global.__objectDepths[281] = 0; // keyboard1_obj
    global.__objectDepths[282] = 0; // keyboard2_obj
    global.__objectDepths[285] = 0; // gui_controls_obj
    global.__objectDepths[286] = -800; // main_light_obj
    global.__objectDepths[287] = 800; // background_light_obj
    global.__objectDepths[288] = 0; // light_parent_obj
    global.__objectDepths[289] = 0; // world_obj
    global.__objectDepths[290] = 0; // place_obj
    global.__objectDepths[291] = 0; // place_controller_obj
    global.__objectDepths[292] = 0; // world_1_obj
    global.__objectDepths[293] = 0; // run_jump_place_controller_obj
    global.__objectDepths[294] = 0; // display_test_place_controller_obj
    global.__objectDepths[295] = 0; // base_colors_place_controller_obj
    global.__objectDepths[296] = 0; // movement_mountain_place_controller_obj
    global.__objectDepths[297] = 0; // sparring_world
    global.__objectDepths[298] = 0; // catalyst_place_controller_obj
    global.__objectDepths[299] = 0; // towerclimb_world
    global.__objectDepths[300] = -100; // overhead_overlay
    global.__objectDepths[301] = 0; // filter_projector_group_obj
    global.__objectDepths[302] = -1100; // status_effect_overlay


    global.__objectNames[0] = "camera_obj";
    global.__objectNames[1] = "main_camera_obj";
    global.__objectNames[2] = "player_camera_obj";
    global.__objectNames[3] = "editor_camera";
    global.__objectNames[4] = "player_display_obj";
    global.__objectNames[5] = "editor_terrain_obj";
    global.__objectNames[6] = "editor_guy_spawner_obj";
    global.__objectNames[7] = "editor_jump_pad_obj";
    global.__objectNames[8] = "editor_turret_obj";
    global.__objectNames[9] = "main_editor_toolbar";
    global.__objectNames[10] = "main_tools_toolbar";
    global.__objectNames[11] = "terrain_placer_toolbar";
    global.__objectNames[12] = "structure_placer_toolbar";
    global.__objectNames[13] = "place_toolbar";
    global.__objectNames[14] = "minimap_toolbar";
    global.__objectNames[15] = "terrain_placer_tool";
    global.__objectNames[16] = "structure_placer_tool";
    global.__objectNames[17] = "selection_tool_obj";
    global.__objectNames[18] = "panning_tool_obj";
    global.__objectNames[19] = "clear_tool";
    global.__objectNames[20] = "load_tool";
    global.__objectNames[21] = "save_tool";
    global.__objectNames[22] = "grid_drawer";
    global.__objectNames[23] = "selection_obj";
    global.__objectNames[24] = "editor_object";
    global.__objectNames[25] = "editor_structure_object";
    global.__objectNames[26] = "tool_object";
    global.__objectNames[27] = "basic_bot";
    global.__objectNames[28] = "npc_waypoint_obj";
    global.__objectNames[29] = "sprinkler_shield_obj";
    global.__objectNames[30] = "sprinkler_gun_obj";
    global.__objectNames[31] = "white_force_field_obj";
    global.__objectNames[32] = "black_force_field_obj";
    global.__objectNames[33] = "guy_spawner_obj";
    global.__objectNames[34] = "color_orb_obj";
    global.__objectNames[35] = "charge_ball_obj";
    global.__objectNames[36] = "place_holder_obj";
    global.__objectNames[37] = "player_guy";
    global.__objectNames[38] = "guy_obj";
    global.__objectNames[39] = "chargeball_provider_obj";
    global.__objectNames[40] = "level_start_obj";
    global.__objectNames[41] = "checkpoint_obj";
    global.__objectNames[42] = "level_end_obj";
    global.__objectNames[43] = "guide_spawner_obj";
    global.__objectNames[44] = "pickup_spawner_obj";
    global.__objectNames[45] = "emp_grenade_obj";
    global.__objectNames[46] = "star_core_item_obj";
    global.__objectNames[47] = "inversion_matrix_item_obj";
    global.__objectNames[48] = "crystal_obj";
    global.__objectNames[49] = "overcharge_obj";
    global.__objectNames[50] = "tp_rush_obj";
    global.__objectNames[51] = "opponent_tp_obj";
    global.__objectNames[52] = "pickup_magnet_obj";
    global.__objectNames[53] = "spraycan_item_obj";
    global.__objectNames[54] = "ability_pickup_obj";
    global.__objectNames[55] = "shield_item_obj";
    global.__objectNames[56] = "chargeball_item_obj";
    global.__objectNames[57] = "inventory_size_item_obj";
    global.__objectNames[58] = "attack_suppressor_item_obj";
    global.__objectNames[59] = "attack_unlocker_item_obj";
    global.__objectNames[60] = "pulse_booster_item_obj";
    global.__objectNames[61] = "charged_jump_item_obj";
    global.__objectNames[62] = "wallclimb_item_obj";
    global.__objectNames[63] = "color_belt_item_obj";
    global.__objectNames[64] = "three_color_belts_item_obj";
    global.__objectNames[65] = "black_belt_item_obj";
    global.__objectNames[66] = "orbital_item_obj";
    global.__objectNames[67] = "health_obj";
    global.__objectNames[68] = "orb_battery_obj";
    global.__objectNames[69] = "SECRET_obj";
    global.__objectNames[70] = "qubit_obj";
    global.__objectNames[71] = "sprinkler_body_obj";
    global.__objectNames[72] = "spark_obj";
    global.__objectNames[73] = "snake_mob_obj";
    global.__objectNames[74] = "slime_mob_obj";
    global.__objectNames[75] = "berserk_flame_obj";
    global.__objectNames[76] = "burn_flame_obj";
    global.__objectNames[77] = "cold_glow_obj";
    global.__objectNames[78] = "tp_rush_lines_obj";
    global.__objectNames[79] = "weak_particles_obj";
    global.__objectNames[80] = "conf_stars_obj";
    global.__objectNames[81] = "frozen_cage_obj";
    global.__objectNames[82] = "slow_glow_obj";
    global.__objectNames[83] = "bounce_glow_obj";
    global.__objectNames[84] = "jump_burst_obj";
    global.__objectNames[85] = "pixel_sucker_obj";
    global.__objectNames[86] = "shield_obj";
    global.__objectNames[87] = "black_projectile_obj";
    global.__objectNames[88] = "slot_explosion_obj";
    global.__objectNames[89] = "black_aoe_obj";
    global.__objectNames[90] = "bigbang_obj";
    global.__objectNames[91] = "star_core_obj";
    global.__objectNames[92] = "big_projectile_obj";
    global.__objectNames[93] = "artillery_projectile_obj";
    global.__objectNames[94] = "small_projectile_obj";
    global.__objectNames[95] = "slime_ball_obj";
    global.__objectNames[96] = "energy_smoke_obj";
    global.__objectNames[97] = "beam_end_obj";
    global.__objectNames[98] = "beam_obj";
    global.__objectNames[99] = "aoe_obj";
    global.__objectNames[100] = "impact_obj";
    global.__objectNames[101] = "energy_burst_obj";
    global.__objectNames[102] = "dash_wave_obj";
    global.__objectNames[103] = "collision_group_obj";
    global.__objectNames[104] = "shield_wall_obj";
    global.__objectNames[105] = "jump_pad_obj";
    global.__objectNames[106] = "monolith_obj";
    global.__objectNames[107] = "universal_pad_obj";
    global.__objectNames[108] = "smoke_vent_obj";
    global.__objectNames[109] = "infodisplay_obj";
    global.__objectNames[110] = "ingame_camera_obj";
    global.__objectNames[111] = "projector_obj";
    global.__objectNames[112] = "ingame_screen_obj";
    global.__objectNames[113] = "turret_mount_obj";
    global.__objectNames[114] = "small_turret_mount_obj";
    global.__objectNames[115] = "turret_body_obj";
    global.__objectNames[116] = "beam_turret_mount_obj";
    global.__objectNames[117] = "cannon_base_obj";
    global.__objectNames[118] = "mob_portal_obj";
    global.__objectNames[119] = "snake_trophy_obj";
    global.__objectNames[120] = "piezoplate_obj";
    global.__objectNames[121] = "antenna_obj";
    global.__objectNames[122] = "energy_pusher_obj";
    global.__objectNames[123] = "zpm_structure_obj";
    global.__objectNames[124] = "energy_drain_rod_obj";
    global.__objectNames[125] = "platform_obj";
    global.__objectNames[126] = "one_way_pass_obj";
    global.__objectNames[127] = "gate_obj";
    global.__objectNames[128] = "gate_field_obj";
    global.__objectNames[129] = "filter_projector_obj";
    global.__objectNames[130] = "filter_field_obj";
    global.__objectNames[131] = "teleporter_obj";
    global.__objectNames[132] = "item_spawner_obj";
    global.__objectNames[133] = "wall_obj";
    global.__objectNames[134] = "perma_wall_obj";
    global.__objectNames[135] = "grate_block_obj";
    global.__objectNames[136] = "armored_wall_obj";
    global.__objectNames[137] = "status_shield_down_obj";
    global.__objectNames[138] = "artifact_obj";
    global.__objectNames[139] = "status_burn_obj";
    global.__objectNames[140] = "status_frozen_obj";
    global.__objectNames[141] = "status_slow_obj";
    global.__objectNames[142] = "status_weakness_obj";
    global.__objectNames[143] = "status_confusion_obj";
    global.__objectNames[144] = "status_bounce_obj";
    global.__objectNames[145] = "status_overcharge_obj";
    global.__objectNames[146] = "status_tp_rush_obj";
    global.__objectNames[147] = "status_berserk_obj";
    global.__objectNames[148] = "status_heal_obj";
    global.__objectNames[149] = "status_haste_obj";
    global.__objectNames[150] = "status_ubershield_obj";
    global.__objectNames[151] = "spawn_effect_obj";
    global.__objectNames[152] = "status_invis_obj";
    global.__objectNames[153] = "terrain_group_obj";
    global.__objectNames[154] = "winner_effect_obj";
    global.__objectNames[155] = "display_group_obj";
    global.__objectNames[156] = "guy_detect_zone_obj";
    global.__objectNames[157] = "data_holder_obj";
    global.__objectNames[158] = "chunkgrid_obj";
    global.__objectNames[159] = "game_obj";
    global.__objectNames[160] = "item_obj";
    global.__objectNames[161] = "mob_obj";
    global.__objectNames[162] = "particle_obj";
    global.__objectNames[163] = "spell_obj";
    global.__objectNames[164] = "projectile_obj";
    global.__objectNames[165] = "energy_projectile_obj";
    global.__objectNames[166] = "equipment_obj";
    global.__objectNames[167] = "energyball_obj";
    global.__objectNames[168] = "structure_obj";
    global.__objectNames[169] = "terrain_obj";
    global.__objectNames[170] = "field_obj";
    global.__objectNames[171] = "turret_obj";
    global.__objectNames[172] = "solid_terrain_obj";
    global.__objectNames[173] = "status_effect_obj";
    global.__objectNames[174] = "phys_body_obj";
    global.__objectNames[175] = "non_terrain_obj";
    global.__objectNames[176] = "obj_group_obj";
    global.__objectNames[177] = "zone_obj";
    global.__objectNames[178] = "non_game_obj";
    global.__objectNames[179] = "gamemode_obj";
    global.__objectNames[182] = "chase_obj";
    global.__objectNames[183] = "colorizer_obj";
    global.__objectNames[184] = "green_colorizer_obj";
    global.__objectNames[185] = "red_colorizer_obj";
    global.__objectNames[186] = "blue_colorizer_obj";
    global.__objectNames[187] = "white_colorizer_obj";
    global.__objectNames[188] = "aurora_colorizer_obj";
    global.__objectNames[189] = "octarine_colorizer_obj";
    global.__objectNames[190] = "precharger_obj";
    global.__objectNames[191] = "perma_fire_obj";
    global.__objectNames[192] = "energizer_obj";
    global.__objectNames[193] = "deenergizer_obj";
    global.__objectNames[194] = "round_energizer_obj";
    global.__objectNames[195] = "editor_orb_obj";
    global.__objectNames[196] = "red_orb_obj";
    global.__objectNames[197] = "black_orb_obj";
    global.__objectNames[198] = "blue_orb_obj";
    global.__objectNames[199] = "green_orb_obj";
    global.__objectNames[200] = "gate_enabled_obj";
    global.__objectNames[201] = "gate_active_obj";
    global.__objectNames[202] = "editor_antenna_obj";
    global.__objectNames[203] = "editor_drain_rod_obj";
    global.__objectNames[204] = "editor_projector_obj";
    global.__objectNames[205] = "editor_energy_pusher_obj";
    global.__objectNames[206] = "color_lock_obj";
    global.__objectNames[207] = "editor_projection_obj";
    global.__objectNames[208] = "terrain_dropper_obj";
    global.__objectNames[209] = "group_configurator_obj";
    global.__objectNames[210] = "player_obj";
    global.__objectNames[211] = "singleton_obj";
    global.__objectNames[212] = "DB";
    global.__objectNames[214] = "phenomena_obj";
    global.__objectNames[215] = "event_manager";
    global.__objectNames[216] = "screen_fade_obj";
    global.__objectNames[217] = "menu_elephant_obj";
    global.__objectNames[218] = "gui_button";
    global.__objectNames[219] = "gui_checkbox";
    global.__objectNames[220] = "gui_int_dial";
    global.__objectNames[222] = "gui_keybinder";
    global.__objectNames[223] = "gui_text_input";
    global.__objectNames[224] = "gui_int_input";
    global.__objectNames[225] = "gui_list_picker";
    global.__objectNames[226] = "gui_dropdown";
    global.__objectNames[227] = "gui_command_input";
    global.__objectNames[228] = "gui_big_text";
    global.__objectNames[229] = "gui_infoarea";
    global.__objectNames[230] = "gui_label";
    global.__objectNames[231] = "gui_pane";
    global.__objectNames[232] = "gui_time";
    global.__objectNames[233] = "gui_scroll_group";
    global.__objectNames[234] = "gui_scroll_list";
    global.__objectNames[235] = "battlefeed_item_obj";
    global.__objectNames[236] = "cursor_obj";
    global.__objectNames[237] = "frame_manager";
    global.__objectNames[238] = "cmatrix_overlay";
    global.__objectNames[239] = "fps_overlay";
    global.__objectNames[240] = "battlefeed_overlay";
    global.__objectNames[242] = "key_overlay";
    global.__objectNames[244] = "terrain_overlay";
    global.__objectNames[245] = "center_overlay";
    global.__objectNames[246] = "inventory_overlay";
    global.__objectNames[247] = "healthbar_overlay";
    global.__objectNames[248] = "radial_overlay";
    global.__objectNames[251] = "tutorial_overlay";
    global.__objectNames[252] = "item_description_overlay";
    global.__objectNames[253] = "damage_popup_obj";
    global.__objectNames[254] = "energy_popup_obj";
    global.__objectNames[255] = "stat_popup_obj";
    global.__objectNames[256] = "text_popup_obj";
    global.__objectNames[257] = "speech_popup_obj";
    global.__objectNames[258] = "info_window";
    global.__objectNames[259] = "name_plate_window";
    global.__objectNames[260] = "timer_window";
    global.__objectNames[261] = "main_menu_window";
    global.__objectNames[262] = "pause_menu_window";
    global.__objectNames[263] = "control_settings_window";
    global.__objectNames[264] = "graphic_settings_window";
    global.__objectNames[266] = "match_setup_window";
    global.__objectNames[267] = "match_summary_window";
    global.__objectNames[268] = "jump_pad_config_window";
    global.__objectNames[269] = "console_window";
    global.__objectNames[270] = "gui_object";
    global.__objectNames[271] = "empty_window";
    global.__objectNames[272] = "empty_frame";
    global.__objectNames[273] = "empty_overlay";
    global.__objectNames[274] = "empty_toolbar";
    global.__objectNames[275] = "gui_element";
    global.__objectNames[276] = "popup_obj";
    global.__objectNames[277] = "input_device_obj";
    global.__objectNames[278] = "keyboard_input_obj";
    global.__objectNames[280] = "gamepad_input_obj";
    global.__objectNames[281] = "keyboard1_obj";
    global.__objectNames[282] = "keyboard2_obj";
    global.__objectNames[285] = "gui_controls_obj";
    global.__objectNames[286] = "main_light_obj";
    global.__objectNames[287] = "background_light_obj";
    global.__objectNames[288] = "light_parent_obj";
    global.__objectNames[289] = "world_obj";
    global.__objectNames[290] = "place_obj";
    global.__objectNames[291] = "place_controller_obj";
    global.__objectNames[292] = "world_1_obj";
    global.__objectNames[293] = "run_jump_place_controller_obj";
    global.__objectNames[294] = "display_test_place_controller_obj";
    global.__objectNames[295] = "base_colors_place_controller_obj";
    global.__objectNames[296] = "movement_mountain_place_controller_obj";
    global.__objectNames[297] = "sparring_world";
    global.__objectNames[298] = "catalyst_place_controller_obj";
    global.__objectNames[299] = "towerclimb_world";
    global.__objectNames[300] = "overhead_overlay";
    global.__objectNames[301] = "filter_projector_group_obj";
    global.__objectNames[302] = "status_effect_overlay";


    // create another array that has the correct entries
    var len = array_length(global.__objectDepths);
    global.__objectID2Depth = [];
    for( var i=0; i<len; ++i ) {
        var objID = asset_get_index( global.__objectNames[i] );
        if (object_exists(objID)) {
            global.__objectID2Depth[ objID ] = global.__objectDepths[i];
        } // end if
    } // end for
}
