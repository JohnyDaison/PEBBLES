var i, pane;

for(i = 1; i <= players_pane.player_pane_count; i++)
{
    pane = player_panes_map[? i];
    
    ds_list_destroy(pane.controls_names);
    ds_list_destroy(pane.controls_ids);
    ds_list_destroy(pane.team_names);
}

ds_list_destroy(players_pane.used_flag_list);
ds_map_destroy(players_pane.used_teams_map);
ds_map_destroy(player_panes_map);

event_inherited();
