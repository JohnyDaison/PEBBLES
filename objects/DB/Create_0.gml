// ORB REGEN SPEEDS
orb_regen_speeds = ds_map_create();
orb_regen_speeds[? spd_none] = 0;
orb_regen_speeds[? spd_veryslow] = 0.00001;
orb_regen_speeds[? spd_slow] = 0.00002;
orb_regen_speeds[? spd_normal] = 0.00005;
orb_regen_speeds[? spd_fast] = 0.001;
orb_regen_speeds[? spd_veryfast] = 0.01;
orb_regen_speeds[? spd_instant] = 10;

// BASE ABILITY COOLDOWNS
abi_cooldowns = ds_map_create();
abi_cooldowns[? g_black] = 7200;
abi_cooldowns[? g_red] = 2220;
abi_cooldowns[? g_green] = 2700;
abi_cooldowns[? g_blue] = 900;
abi_cooldowns[? g_yellow] = 1600;
abi_cooldowns[? g_purple] = 1620;
abi_cooldowns[? g_azure] = 4200;
abi_cooldowns[? g_white] = 36000;

npc_waypoint_connect_dist = 640;
npc_waypoint_disconnect_dist = 1280;
npc_waypoint_oneway_vert_dist = 352;
npc_waypoint_edge_length_coef = 64;

// I18n
I18n = ds_map_create();
define_strings_DB();

npc_speech_tick = 3;
max_npc_speech_tick = 6;

// STATS
stats_display_labels = ds_list_create();
stats_display_keys = ds_list_create();

stats_DisplayList_init(stats_display_labels, stats_display_keys);
stats_display_rows = ds_list_size(stats_display_labels);

match_stats_display_labels = ds_list_create();
match_stats_display_keys = ds_list_create();

match_stats_DisplayList_init(match_stats_display_labels, match_stats_display_keys);
match_stats_display_rows = ds_list_size(match_stats_display_labels);

// WHICH STATS ARE ACTIONS
player_stats_actions = ds_list_create();
ds_list_add(player_stats_actions, "spells", "abilities", "jumps");

// LEVELS

level_list = ds_list_create();
level_type = ds_map_create();
level_label = ds_map_create();
level_globalmax = ds_map_create();
level_globalmin = ds_map_create();

init_levels_DB();

// TERRAIN

terrain_xx = ds_map_create();
terrain_yy = ds_map_create();
terrain_xx[? up] = 0;
terrain_yy[? up] = -32;

terrain_xx[? down] = 0;
terrain_yy[? down] = 32;

terrain_xx[? left] = -32;
terrain_yy[? left] = 0;

terrain_xx[? right] = 32;
terrain_yy[? right] = 0;

// this is not used everywhere it should be
terrain_config = ds_map_create();
terrain_config[? "active_threshold"] = 0.2;
terrain_config[? "behaviour_threshold"] = 0.33;
terrain_config[? "status_threshold"] = 0.66;
terrain_config[? "damage_threshold"] = 1;
terrain_config[? "outburst_threshold"] = 1.33;
terrain_config[? "bounce_threshold"] = terrain_config[? "status_threshold"];
terrain_config[? "max_energy"] = 2.5;


// CONTROL SETS

i=0;
control_set_names = ds_list_create();
control_set_names[| i++] = "CPU";
control_set_names[| i++] = "Keyboard 1";
control_set_names[| i++] = "Keyboard 2";
control_set_names[| i++] = "Joystick 1";
control_set_names[| i++] = "Joystick 2";
control_set_names[| i++] = "Gamepad";
//control_set_names[| i++] = "Nothing";

i=0;
control_set_order = ds_list_create();
control_set_order[| i++] = gamepad;
control_set_order[| i++] = cpu_control_set;
control_set_order[| i++] = keyboard1;
control_set_order[| i++] = keyboard2;

gui_controls = ds_grid_create(stepmode+1, released+1);


// GAMEMODES
create_gamemodes_DB();

// CONSOLE
init_console_DB();

// CHUNK EXCEPTIONS
chunk_exceptions = ds_list_create();
ds_list_add(chunk_exceptions, guy_spawner_obj, player_guy);

// DS REGISTRY
ds_registry = ds_list_create();
ds_registry_index = ds_map_create();

// BF ICON MAP
bf_icon_map = ds_map_create();

init_bf_icons_DB();

// PLAYER FLAGS
player_flags = ds_list_create();

ds_list_add(player_flags,
"pacman_flag",
//"pirate_flag",
"venn_flag",
"racing_flag",
//"stairs_flag",
"yinyang_flag");

// QUESTS
quests_create();

// SPARRING BOT NAMES
bot_names = ds_map_create();
bot_names[? 1] = "Dummy";
bot_names[? 2] = "Weakling";
bot_names[? 3] = "Loser";
bot_names[? 4] = "Pest";
bot_names[? 5] = "Heckler";
bot_names[? 6] = "Monkey";
bot_names[? 7] = "Mugger";
bot_names[? 8] = "Mercenary";
bot_names[? 9] = "Sidekick";
bot_names[? 10] = "Knight";
bot_names[? 11] = "Wizard";
bot_names[? 12] = "Ninja";
bot_names[? 13] = "Hero";
bot_names[? 14] = "Superhero";
bot_names[? 15] = "Ultrahero";

// SPEECH TERM COLORS
speech_terms_create();
speech_terms_define();


circle_precision = 24;
