var players_pane = self.players_pane;
/*
var player_pane1 = player_panes_map[? 1];
var player_pane2 = player_panes_map[? 2];
*/
var pl_num;

ds_list_clear(players_pane.used_flag_list)

// PLAYER FLAGS SHOULD BE DIFFERENT
for(pl_num = 1; pl_num <= players_pane.player_pane_count; pl_num++)
{
    var player_pane = player_panes_map[? pl_num];
    
    if(instance_exists(player_pane.flag_input) && instance_exists(player_pane.flag_input.list_picker.scroll_list))
    {
        var item_count = player_pane.flag_input.list_picker.scroll_list.item_count;
        if(player_pane.flag_input.value != -1 && item_count > 1)
        {
            var cur_value = player_pane.flag_input.list_picker.scroll_list.cur_item;
        
            if(!player_pane.flag_input.list_picker.visible)
            {
                var list_size = ds_list_size(players_pane.used_flag_list);
                while(item_count > list_size && ds_list_find_index(players_pane.used_flag_list, cur_value) != -1)
                {
                    cur_value = cur_value+1 mod item_count;
                }
                
                if(player_pane.flag_input.list_picker.scroll_list.cur_item != cur_value)
                {
                    player_pane.flag_input.list_picker.scroll_list.cur_item = cur_value;
                    gui_list_picker_update_script(player_pane.flag_input.list_picker);
                }
            }
        
            ds_list_add(players_pane.used_flag_list, cur_value);
        }
    }
}

var but1 = players_pane.team1_button;
var but2 = players_pane.team2_button;

// CHANGE TEAM BUTTON BACKGROUND
if(players_pane.show_team == 1)
{
    but1.base_bg_color = players_pane.base_bg_color;
    but2.base_bg_color = players_pane.hidden_team_button_color;
}
else
{
    but1.base_bg_color = players_pane.hidden_team_button_color;
    but2.base_bg_color = players_pane.base_bg_color;
}


var player_count = players_pane.playernum_input.value;
var pane2 = player_panes_map[? 2];

// SWITCH BETWEEN NORMAL AND TEAM LAYOUT
if(player_count <= 2)
{
    gui_hide_element(but1);
    gui_hide_element(but2);
    gui_move_element(pane2, pane2.x, players_pane.bottom_player_pane_y);
}
else
{
    gui_show_element(but1);
    gui_show_element(but2);
    gui_move_element(pane2, pane2.x, players_pane.top_player_pane_y);
}

// SHOW/HIDE PLAYER PANES
for(pl_num = 1; pl_num <= players_pane.player_pane_count; pl_num++)
{
    var player_pane = player_panes_map[? pl_num];
    var show_me, team_number;
    
    with(player_pane)
    {
        show_me = (pl_num <= player_count);
        if(player_count > 2)
        {
            team_number = pl_num mod 2;
            if(team_number == 0)
            {
                team_number = 2;
            }
            
            show_me = show_me && (team_number == players_pane.show_team);
        }
        
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
