ds_list_destroy(gamemode_names);
ds_list_destroy(place_names);
ds_list_destroy(place_ids);
ds_map_destroy(gmmod_controls);
ds_map_destroy(gmmod_customs);
ds_list_destroy(gamemode_description_list);
ds_list_destroy(place_description_list);

event_inherited();
