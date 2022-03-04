// SPEECH TERM COLORS
speech_terms_destroy();

ds_map_destroy(keynames);
ds_map_destroy(padnames);
ds_list_destroy(control_set_names);
ds_list_destroy(control_set_order);
ds_grid_destroy(gui_controls);

ds_map_destroy(guy_skins[? "glowstick"]);
ds_map_destroy(guy_skins);

ds_list_destroy(player_names);

ds_map_destroy(colormap);
ds_map_destroy(colornames);
ds_map_destroy(colorpitch);
ds_grid_destroy(colormatrix);
ds_map_destroy(colordirs);

ds_map_destroy(status_effects);
ds_list_destroy(status_effects_list);
ds_map_destroy(color_effects);
/*
ds_map_destroy(arenas);
ds_list_destroy(arena_names);
*/
ds_map_destroy(abimap);
ds_map_destroy(abi_icons);
ds_list_destroy(resolution_list);

ds_map_destroy(orb_regen_speeds);
ds_map_destroy(abi_cooldowns);

ds_map_destroy(I18n);

// STATS
ds_list_destroy(stats_display_labels);
ds_list_destroy(stats_display_keys);

ds_list_destroy(match_stats_display_labels);
ds_list_destroy(match_stats_display_keys);

ds_list_destroy(player_stats_actions);

// LEVELS

ds_list_destroy(level_list);
ds_map_destroy(level_type);
ds_map_destroy(level_label);
ds_map_destroy(level_globalmax);
ds_map_destroy(level_globalmin);

// TERRAIN
ds_map_destroy(terrain_xx);
ds_map_destroy(terrain_yy);
ds_map_destroy(terrain_config);

// GAMEMODES
destroy_gamemodes_DB();

// CHUNK EXCEPTIONS
ds_list_destroy(chunk_exceptions);

// DS REGISTRY
ds_list_destroy(ds_registry);
ds_map_destroy(ds_registry_index);

// BF ICON MAP
ds_map_destroy(battlefeed_icon_map);

// PLAYER FLAGS
ds_list_destroy(player_flags);

// TEAM NAMES
ds_list_destroy(team_names);

quests_destroy();

ds_map_destroy(bot_names);

// CONSOLE
destroy_console_DB();