ds_list_destroy(gamemode_pane.gamemode_names);
ds_list_destroy(gamemode_pane.place_names);
ds_list_destroy(gamemode_pane.place_ids);
ds_map_destroy(gamemode_pane.gmmod_controls);
ds_map_destroy(gamemode_pane.gmmod_customs);
ds_list_destroy(gamemode_pane.summary_list);

event_inherited();
