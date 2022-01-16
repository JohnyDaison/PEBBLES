var players_pane = self.players_pane;
/*
var player_pane1 = player_panes_map[? 1];
var player_pane2 = player_panes_map[? 2];
*/
var pl_num, team_number;

ds_list_clear(players_pane.used_flag_list);
ds_map_clear(players_pane.used_teams_map);

for(pl_num = 1; pl_num <= players_pane.player_pane_count; pl_num++)
{
    var player_pane = player_panes_map[? pl_num];
    
    // PLAYER FLAGS SHOULD BE DIFFERENT
    if(instance_exists(player_pane.flag_input) && instance_exists(player_pane.flag_input.list_picker.scroll_list))
    {
        var item_count = player_pane.flag_input.list_picker.scroll_list.item_count;
        if(player_pane.flag_input.value != -1 && item_count > 1)
        {
            var cur_value = player_pane.flag_input.list_picker.cur_item;
        
            if(!player_pane.flag_input.list_picker.visible)
            {
                var list_size = ds_list_size(players_pane.used_flag_list);
                while(item_count > list_size && ds_list_find_index(players_pane.used_flag_list, cur_value) != -1)
                {
                    cur_value = (cur_value+1) mod item_count;
                }
                
                if(player_pane.flag_input.list_picker.cur_item != cur_value)
                {
                    player_pane.flag_input.list_picker.select_item_by_index(cur_value);
                }
            }
        
            ds_list_add(players_pane.used_flag_list, cur_value);
        }
    }
    
    // POPULATE USED TEAMS MAP
    if(player_pane.visible && instance_exists(player_pane.team_dropdown) && instance_exists(player_pane.team_dropdown.list_picker.scroll_list))
    {
        var item_count = player_pane.team_dropdown.list_picker.scroll_list.item_count;
        if(player_pane.team_dropdown.value != -1 && item_count > 0)
        {
            var cur_value = player_pane.team_dropdown.list_picker.cur_item;
            team_number = cur_value + 1;
        
            if(is_undefined(players_pane.used_teams_map[? team_number])) {
                players_pane.used_teams_map[? team_number] = 1;
            } else {
                players_pane.used_teams_map[? team_number]++;
            }
        }
    }
}

// AT LEAST THE MINIMUM NUMBER OF TEAMS MUST BE USED
for(team_number = 1; team_number <= players_pane.min_teams && ds_map_size(players_pane.used_teams_map) < players_pane.min_teams; team_number++) {
    var use_count = players_pane.used_teams_map[? team_number];
    var team_used = !is_undefined(use_count);
    
    for(pl_num = 1; pl_num <= players_pane.player_pane_count && !team_used; pl_num++)
    {
        var player_pane = player_panes_map[? pl_num];
    
        if(instance_exists(player_pane.team_dropdown) && instance_exists(player_pane.team_dropdown.list_picker.scroll_list))
        {
            var item_count = player_pane.team_dropdown.list_picker.scroll_list.item_count;
            if(player_pane.team_dropdown.value != -1 && item_count > 0)
            {
                if(!player_pane.team_dropdown.list_picker.visible)
                {
                    var cur_value = player_pane.team_dropdown.list_picker.cur_item;
                    var pane_team_number = cur_value + 1;
                    var pane_team_use_count = players_pane.used_teams_map[? pane_team_number];
                    
                    if((pane_team_use_count > 1 && pl_num >= team_number) || pane_team_number >= players_pane.min_teams)
                    {
                        cur_value = team_number - 1;
                    }
                    
                    if(player_pane.team_dropdown.list_picker.cur_item != cur_value)
                    {
                        player_pane.team_dropdown.list_picker.select_item_by_index(cur_value);
                        
                        players_pane.used_teams_map[? pane_team_number]--;
                        players_pane.used_teams_map[? team_number] = 1;
                        team_used = true;
                    }
                }
            }
        }
    }
}

var player_count = players_pane.playernum_input.value;

// SHOW/HIDE PLAYER PANES
for(pl_num = 1; pl_num <= players_pane.player_pane_count; pl_num++)
{
    var player_pane = player_panes_map[? pl_num];
    var show_me;
    
    with(player_pane)
    {
        show_me = (pl_num <= player_count);
        
        if(show_me)
        {
            if(hidden)
            {
                gui_show_element(player_pane);
            }
            
            if(instance_exists(cpudiff_input))
            {
                cpudiff_input.enabled = (control_dropdown.value_id == cpu_control_set);
            
                if(cpudiff_input.enabled && cpudiff_input.hidden)
                {
                    gui_show_element(cpudiff_input);
                    gui_show_element(cpudiff_label);
                }
            
                if(!cpudiff_input.enabled && !cpudiff_input.hidden)
                {
                    gui_hide_element(cpudiff_input);
                    gui_hide_element(cpudiff_label);
                }
            }
        }
        else
        {
            if(!hidden)
            {
                gui_hide_element(player_pane);
            }
        }
    }
}
