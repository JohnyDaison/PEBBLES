ds_list_destroy(gamemode_names);
ds_list_destroy(place_names);
ds_list_destroy(place_ids);
ds_list_destroy(preset_names);
ds_list_destroy(preset_ids);
ds_map_destroy(gmrule_controls);
ds_map_destroy(gmrule_customs);
ds_list_destroy(summary_list);

event_inherited();
