event_inherited();

update_display();

y = 48;
self.height = 656;
window_axis = view_wport[0]/2;

self.text = "Play Menu";
self.draw_heading = false;
self.draw_bg_color = false;
self.draw_border = false;
self.world = noone;

menu_start = 112;

self.modal = true;

ii = instance_create(0,0,gui_label);
ii.text = DB.version_string;
ii.gui_parent = id;
ii.align = "left"
ii.draw_bg_color = false;
ii.rel_position = "absolute";
ds_list_add(self.gui_content,ii);


ii = instance_create(window_axis,y + 40,gui_big_text);
ii.text = "·P·E·B·B·L·E·S·";
ii.width = 2000;
ii.bg_color = c_black;
ii.bg_alpha = 0.9;
ii.gui_parent = id;
ii.depth -= 1;
ii.rel_position = "absolute";
ds_list_add(self.gui_content,ii);

eloffset_x = window_axis;

eloffset_y = y + menu_start;


/*
eloffset_x += 80;
var i=1;

but = gui_add_button(0,y+dist*i++, "Training", goto_tutorial);
but.tooltip = "Learn how to play, incomplete";

but = gui_add_button(0,y+dist*i++, "Sparring", goto_sparring);
but.tooltip = "Fight a simple bot";

but = gui_add_button(0,y+dist*i++, "Base defense Survival", goto_survival);
but.tooltip = "Infinite waves of enemies";

but = gui_add_button(0,y+dist*i++, "Rougelike", goto_roguelike);
but.tooltip = "Experimental";

but = gui_add_button(0,y+dist*i++, "1v1 Classic match (gamepads)", classic_match_joysticks);
but.tooltip = "Old school arena, old school rules";

but = gui_add_button(0,y+dist*i++, "1v1 Simple match (gamepads)", closed_quarters_joysticks);
but.tooltip = "Small arena with constant supply of powerups";

but = gui_add_button(0,y+dist*i++, "1v1 Tower Climb (gamepads)", goto_towerclimb);
but.tooltip = "Race to the top, needs work";

but = gui_add_button(0,y+dist*i++, "1v1 Battle (keyboard)", fast_match_start_keyboard);
but.tooltip = "Full battle using keyboard";

but = gui_add_button(0,y+dist*i++, "1v1 Battle (gamepads)", fast_match_start_joysticks);
but.tooltip = "Full battle using controllers";

but = gui_add_button(0,y+dist*i++, "4-P Battle (gamepads)", fast_4match_start);
but.tooltip = "Experimental";

but = gui_add_button(0,y+dist*i++, "Custom Match", goto_match_setup);

gui_add_button(0,y+dist*i++, "Back", goto_mainmenu);

eloffset_x -= 80;
*/

eloffset_x = x + 16;

gamemode_pane = gui_add_pane(0,0, "Game mode");
//gamemode_pane = gui_add_pane(-width-144, y + 32, "Game mode");

with(gamemode_pane)
{
    icon = player_small_spr;
    draw_bg_color = true;
    show_icon = true;

    centered = true;
    width = 928;
    
    draw_heading = false;
    
    gamemode_names = ds_list_create();
    place_names = ds_list_create();
    place_ids = ds_list_create();
    gmmod_controls = ds_map_create();
    gmmod_customs = ds_map_create();
    
    summary_list = ds_list_create();
    
    var hor_spacing = 16;
    var vert_spacing = 8;
    var heading_start = y + vert_spacing;
    var content_start = y + 32 + 2*vert_spacing;
    var main_content_height = 392;
    var picker_width = 236;
    var summary_width = 392;
    
    var mods_height = 96;
    //var mods_x = x + width - 144;
    var mods_x = x + hor_spacing;
    var mods_start = content_start + main_content_height + vert_spacing;
    var modifier_chb_size = 40;
    var mod_dist = 56;
    //var mods_width = 720;
    var mods_width = 80 + 15 * mod_dist;
    
    
    height = mods_start + mods_height + vert_spacing - y;

    // POPULATE gamemode_names
    var i, count = ds_list_size(DB.gamemode_list), gm, ii;
    
    for(i=0; i<count; i++)
    {
        gm = DB.gamemodes[? (DB.gamemode_list[| i])];
        ds_list_add(gamemode_names, gm[? "name"]);
    }
    
    eloffset_x = x + hor_spacing;
    
    // Game mode COLUMN
    eloffset_y = heading_start;
    
    ii = gui_add_label(0,0, "Game mode:");
    ii.width = picker_width;
    ii.centered = true;

    eloffset_y = content_start;
    
    ii = gui_add_list_picker(0,0, "text", gamemode_names, DB.gamemode_list);
    ii.width = picker_width;
    ii.height = main_content_height;
    ii.auto_items = true;
    ii.centered = true;
    ii.item_change_script = gamemode_picker_script;
    gamemode_picker = ii.id;
    
    eloffset_x += gamemode_picker.width + hor_spacing;
    
    
    // Level COLUMN
    eloffset_y = heading_start;
    
    ii = gui_add_label(0,0, "Level:");
    ii.width = picker_width;
    ii.centered = true;
    
    eloffset_y = content_start;
    
    ii = gui_add_list_picker(0,0, "text");
    ii.width = picker_width;
    ii.height = main_content_height;
    ii.auto_items = true;
    ii.centered = true;
    ii.align_items = "left";
    ii.item_change_script = place_picker_script;
    place_picker = ii.id;
    
    eloffset_x += place_picker.width + hor_spacing;
    
    
    // Summary COLUMN
    eloffset_y = heading_start;
    
    ii = gui_add_label(summary_width/2, 16, "Summary:");
    ii.width = summary_width;
    //ii.width = 64;
    
    eloffset_y = content_start;
    
    /*
    ii = gui_add_label(0,0, "summary");
    ii.width = summary_width;
    ii.height = main_content_height;
    ii.centered = true;
    ii.text_align = "lefttop";
    ii.multiline = true;
    //ii.font = small_font;
    summary_label = ii.id;
    */
    
    ii = gui_add_list_picker(0,0, "text");
    ii.width = summary_width;
    ii.height = main_content_height;
    ii.centered = true;
    ii.auto_items = true;
    ii.align_items = "left";
    ii.text_color = c_white;
    ii.select_text_color = c_white;
    //ii.auto_height = true;
    //ii.max_items = max(1, floor( (main_content_height - 32) / 20 ) - 1);
    
    with(ii)
    {
        alarm[0] = -1;
        event_perform(ev_alarm, 0);
    }
    
    i = ii.scroll_list;
    
    //i.draw_border = false;
    i.bg_color = c_black;
    i.bg_alpha = 0.5;
    i.item_bg_color = c_black;
    i.item_height = 20;
    i.item_padding = 0;
    i.highlight_color = merge_colour(i.item_bg_color, c_purple, 0.1);
    i.select_color = merge_colour(i.item_bg_color, c_lime, 0.1);
    
    summary_list_picker = ii.id;
    

    // Mods SECTION
    eloffset_x = mods_x;
    eloffset_y = mods_start;
    
    ii = gui_add_label(0,4, "Mods:");
    ii.width = 64;
    ii.centered = true;
    mods_label = ii.id;
    
    /*
    ii = gui_add_label(0,mod_dist+4, "Bans:");
    ii.width = 64;
    ii.centered = true;
    bans_label = ii.id;
    */
    
    var mods_content_x = mods_x + mods_label.width + hor_spacing;
    eloffset_x = mods_content_x;

    var gmmod_id, gmmod, gmmod_type, ii, list;
    
    // create lists for types
    var gmmod_controls_types = ds_map_create();
    count = ds_list_size(DB.gamemode_mod_type_list);
    
    for(i=0; i<count; i++)
    {
        gmmod_type = DB.gamemode_mod_type_list[| i];
        gmmod_controls_types[? gmmod_type] = ds_list_create();
    }
    
    // split mods into lists
    count = ds_list_size(DB.gamemode_mod_list);
    
    for(i=0; i<count; i++)
    {
        gmmod_id = DB.gamemode_mod_list[| i];
        gmmod = DB.gamemode_mods[? gmmod_id];
        gmmod_type = gmmod[? "type"];
    
        if(gmmod[? "public"])
        {
            if(is_undefined(gmmod_controls_types[? gmmod_type]))
            {
                gmmod_controls_types[? gmmod_type] = ds_list_create();
            }
            
            ds_list_add(gmmod_controls_types[? gmmod_type], gmmod_id);
            /*
            if()
            {
                ds_list_add(gmmod_controls_types[? gmmod_type], "blank_space");
            }
            */
        }
    }
    
    // create controls
    var type_count = ds_list_size(DB.gamemode_mod_type_list), type_i;
    
    for(type_i=0; type_i<type_count; type_i++)
    {
        gmmod_type = DB.gamemode_mod_type_list[| type_i];
        list = gmmod_controls_types[? gmmod_type];
        count = ds_list_size(list);
        mods_width = 80 + min(15, ceil(count/2)) * mod_dist;
    
        for(i=0; i<count; i++)
        {
            gmmod_id = list[| i];
            
            if(gmmod_id != "blank_space")
            {
                ii = noone;
        
                if(gmmod_type == "bool" || gmmod_type == "ban")
                {
                    ii = gui_add_mod_checkbox(0, 0, gmmod_id, modifier_chb_size);

                    ii.user_clicked_script = mod_chb_user_click_script;
                    ii.onchange_script = play_summary_update;
                    ii.draw_unlocked_border = true;
                }
            
                gmmod_controls[? gmmod_id] = ii;
            }
            
            eloffset_x += mod_dist;
            
            if(eloffset_x > (x + mods_width - mod_dist + hor_spacing))
            {
                eloffset_x = mods_content_x;
                eloffset_y += mod_dist;
            }
        }
    
        eloffset_x = mods_content_x;
        eloffset_y += mod_dist;
    }
    
    /*
    for(i=0; i<count; i++)
    {
        gmmod_id = DB.gamemode_mod_list[| i];
        gmmod = DB.gamemode_mods[? gmmod_id];
    
        if(gmmod[? "public"])
        {
            ii = gui_add_mod_checkbox(0, 0, gmmod_id, modifier_chb_size);

            ii.user_clicked_script = mod_chb_user_click_script;
            ii.onchange_script = play_summary_update;

            gmmod_controls[? gmmod_id] = ii;


            eloffset_x += mod_dist;

            if(eloffset_x > (x + mods_width - mod_dist + hor_spacing))
            {
                eloffset_x = mods_content_x;
                eloffset_y += mod_dist;
            }
        }
    }
    */
    
    // destroy gmmod_controls_types
    count = ds_list_size(DB.gamemode_mod_type_list);
    
    for(i=0; i<count; i++)
    {
        gmmod_type = DB.gamemode_mod_type_list[| i];
        list = gmmod_controls_types[? gmmod_type];
        ds_list_destroy(list);
    }
    
    ds_map_destroy(gmmod_controls_types);
    
}

add_frame(mod_tooltip_window);

eloffset_x += gamemode_pane.width + 16;

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
    width = 304;
    height = max(536, other.gamemode_pane.height);
    player_pane_count = 4;
    var hor_spacing = 16;
    var vert_spacing = 8;
    
    eloffset_x = x + 48;
    eloffset_y = y + vert_spacing;
    top_player_pane_y = 0;
    bottom_player_pane_y = 0;
    show_team = 1;
    hidden_team_button_color = merge_color(base_bg_color, c_dkgray, 0.75);
    used_flag_list = ds_list_create();
    
    
    ii = gui_add_label(64, 16, "Number of players:");
    
    playernum_input = gui_add_int_input(204, 16, 0, 1, 1);

    
    var team_button_width = 96;
    
    eloffset_y += 32 + vert_spacing;
    
    ii = gui_add_button(0,0, "Team 1", team1_click_script);
    ii.width = team_button_width;
    ii.centered = true;
    team1_button = ii;
    
    eloffset_x += team1_button.width + hor_spacing;
    
    ii = gui_add_button(0,0, "Team 2", team2_click_script);
    ii.width = team_button_width;
    ii.centered = true;
    team2_button = ii;
    
    eloffset_x = x;
    eloffset_y += 32 + 2*vert_spacing;
    top_player_pane_y = eloffset_y;
    
    for(i = 1; i <= player_pane_count; i++)
    {
        if(i == 2)
        {
            bottom_player_pane_y = eloffset_y;   
        }
        
        pp_map[? i] = gui_add_player_setup_pane(0, 0, i);
        
        if(i == 1 || i == player_pane_count)
        {
            eloffset_y += pp_map[? i].height + vert_spacing;
        }
    }


    var start_button_width = 160;
    var back_button_width = 96;
    
    eloffset_x = x + width - (start_button_width + back_button_width + 2*hor_spacing);
    eloffset_y = y + height - 32 - vert_spacing;
    
    ii = gui_add_button(0,0, "Start game", play_menu_window_start_game);
    ii.width = start_button_width;
    ii.centered = true;
    ii.base_bg_color = select_color;
    start_button = ii.id;
    
    eloffset_x += start_button.width + hor_spacing;
    
    ii = gui_add_button(0,0, "Back", goto_mainmenu);
    ii.width = back_button_width;
    ii.centered = true;
    back_button = ii.id;
    
    eloffset_y += start_button.height + vert_spacing;
}

self.width = 3*hor_spacing + gamemode_pane.width + players_pane.width;
x = view_wport[0]/2 - width/2;

// ELEPHANT
if(instance_exists(menu_elephant_obj))
{
    instance_destroy(menu_elephant_obj.id);
}

