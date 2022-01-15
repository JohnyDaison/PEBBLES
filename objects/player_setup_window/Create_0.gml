event_inherited();

update_display();

y = 32;
self.height = 656;
window_axis = display_get_gui_width()/2;

self.text = "Player Setup";
self.draw_heading = false;
self.draw_bg_color = false;
self.draw_border = false;
self.world = noone;

self.modal = true;

eloffset_x = x;
eloffset_y = y;

players_pane = gui_add_pane(0, 0, "Players");
player_panes_map = ds_map_create();
var pp_map = player_panes_map;

with(players_pane)
{
    icon = player_small_spr;
    draw_bg_color = true;
    show_icon = true;
    draw_heading = false;
    centered = true;
    player_pane_width = 304;
    height = other.height;
    player_pane_count = 4;
    var hor_spacing = 16;
    var vert_spacing = 8;
    width = 3 * hor_spacing + 2 * player_pane_width;
    
    eloffset_x = x + width/2 - 112;
    eloffset_y = y + vert_spacing;
    
    used_flag_list = ds_list_create();
    
    
    ii = gui_add_label(64, 16, "Number of players:");
    
    playernum_input = gui_add_int_input(204, 16, 0, 1, 1);
    
    eloffset_x = x + hor_spacing;
    eloffset_y += 32 + 3 * vert_spacing;
    
    pp_map[? 1] = gui_add_player_setup_pane(0, 0, 1);
    
    eloffset_x += player_pane_width + hor_spacing;
    
    pp_map[? 2] = gui_add_player_setup_pane(0, 0, 2);
    
    eloffset_x = x + hor_spacing;
    eloffset_y += pp_map[? 2].height + hor_spacing;
    
    pp_map[? 3] = gui_add_player_setup_pane(0, 0, 3);
    
    eloffset_x += player_pane_width + hor_spacing;
    
    pp_map[? 4] = gui_add_player_setup_pane(0, 0, 4);
    
    eloffset_y += pp_map[? 4].height + hor_spacing;
    
    var start_button_width = 160;
    var back_button_width = 96;
    
    eloffset_x = x + width - (start_button_width + back_button_width + 2*hor_spacing);
    eloffset_y = y + height - 32 - vert_spacing;
    
    ii = gui_add_button(0,0, "Start game", player_setup_window_start_game);
    ii.width = start_button_width;
    ii.centered = true;
    ii.base_bg_color = select_color;
    start_button = ii.id;
    
    eloffset_x += start_button.width + hor_spacing;
    
    ii = gui_add_button(0,0, "Back", goto_playmenu);
    ii.width = back_button_width;
    ii.centered = true;
    //back_button = ii.id;
    
    eloffset_y += start_button.height + vert_spacing;
    
    // UPDATE PLAYER NUMBER
    var gm = DB.gamemodes[? gamemode_obj.mode];
    playernum_input.min_value = gm[? "min_players"];
    playernum_input.max_value = gm[? "max_players"];
}

self.width = players_pane.width;
x = window_axis - width/2;

alarm[0] = 2;
