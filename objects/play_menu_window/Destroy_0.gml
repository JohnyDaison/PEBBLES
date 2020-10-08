ds_list_destroy(gamemode_pane.gamemode_names);
ds_list_destroy(gamemode_pane.place_names);
ds_list_destroy(gamemode_pane.place_ids);
ds_map_destroy(gamemode_pane.gmmod_controls);
ds_map_destroy(gamemode_pane.gmmod_customs);
ds_list_destroy(gamemode_pane.summary_list);

var i, pane;

for(i = 1; i <= players_pane.player_pane_count; i++)
{
    pane = player_panes_map[? i];
    
    ds_list_destroy(pane.controls_names);
    ds_list_destroy(pane.controls_ids);
}

ds_list_destroy(players_pane.used_flag_list);
ds_map_destroy(player_panes_map);

event_inherited();
