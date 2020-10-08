event_inherited();

singleton_obj.display_updated = false;
update_display();

self.width = 1232;
self.height = 688;
x = view_wport[0]/2 - self.width/2;
y = view_hport[0]/2 - self.height/2;
self.text = "Match Summary";
self.modal = true;

heading = 48;
pane_heading = 32;
row_height = 32;
spacing = 12;
col_thin = 32;
col_number = 80;
col_label = 128;
col_normal = 192;
col_wide = 256;
match_col_wide = 296;

eloffset_x = x;
eloffset_y = y + heading;

// SCORE BOARD
score_pane = gui_add_pane(16,0,"SCORE BOARD");
score_pane.width = 416;
score_pane.height = 252;

frame_manager.window_log_str = "";

with(score_pane)
{
    /* 
    x = x-width/2;
    y = y-height/2;
    */
    centered = true;
    
    heading = other.pane_heading;
    row_height = other.row_height;
    spacing = other.spacing;
    col_thin = other.col_thin;
    col_label = other.col_label;
    col_wide = other.col_wide;
    col_number = other.col_number;
    var player_num = gamemode_obj.player_count;
        
    // column labels
    eloffset_x = x + spacing;
    eloffset_y = y + heading;
    
    // rows

    tab_start = eloffset_y;
    frame_manager.window_log_str += "\n";
    
    for(i=0; i<=player_num; i+=1)
    {
        player = ds_map_find_value(gamemode_obj.players,i);
        eloffset_x = x + spacing;
        
        ii = gui_add_label(0,0,string(player.number));
        ii.width = col_thin;
        ii.centered = true;
        
        eloffset_x += ii.width+spacing;
        
        var result_text = "";
        if(player.is_cpu)
        {
            result_text += "(CPU " + string(player.cpu_difficulty*10) + ")";
        }
        
        if(player.winner)
        {
            result_text += " (win)";
        }
        else if(player.loser)
        {
            result_text += " (loss)";
        }
        
        ii = gui_add_label(0,0,player.name + result_text);
        ii.width = col_wide;
        ii.centered = true;
        
        
        eloffset_x += ii.width+spacing;
        
        ii = gui_add_label(0,0,string(player.stats[? "score"]));
        ii.width = col_number;
        ii.centered = true;
        
        eloffset_x += ii.width+spacing;
        
        eloffset_y += row_height+spacing;
        frame_manager.window_log_str += "\n";
    }
}

frame_manager.window_log_str += "\n";

// PLAYER STATS
eloffset_x = x + score_pane.width+32;

plstats_pane = gui_add_pane(0,0,"PLAYER STATS");
plstats_pane.width = 752;
plstats_pane.height = height - heading - pane_heading - 160;

with(plstats_pane)
{
    centered = true;
    
    heading = other.pane_heading;
    row_height = other.row_height;
    side_spacing = 8;
    spacing = 1;
    col_thin = other.col_thin;
    col_label = other.col_label;
    col_number = other.col_number;
    col_wide = other.col_wide + 48;
    var scroll_bar_width = 8;
    
    table_height = 384;
    max_items = floor((table_height-32)/32);
    
    eloffset_x = x + side_spacing;
    eloffset_y = y + heading;
        
    // STATS TABLE
    
    // HEADINGS
    ii = gui_add_label(0,0,"Stats");
    ii.width = col_wide - scroll_bar_width;
    ii.draw_border = true;
    ii.centered = true;
    
    for(i=0;i<=player_num;i+=1)
    {
        eloffset_x += ii.width + scroll_bar_width + spacing;
        
        ii = gui_add_label(0,0,string(i));
        ii.width = col_number - scroll_bar_width;
        ii.draw_border = true;
        ii.centered = true;
    }
    
    
    // SCROLL LISTS
    eloffset_x = x + side_spacing;
    eloffset_y += row_height;
    
    ii = gui_add_scroll_list(0,0);
    ii.width = col_wide;
    ii.height = table_height;
    ii.max_items = max_items;
    ii.centered = true;
    
    self.scroll_list = ii;

    scroll_group = gui_child_init(0,0,gui_scroll_group);
    
    ds_list_add(scroll_group.scroll_lists,ii);
    
    for(i=0;i<=player_num;i+=1)
    {
        eloffset_x += ii.width+spacing;
            
        ii = gui_add_scroll_list(0,0);
        ii.width = col_number;
        ii.height = table_height;
        ii.max_items = max_items;
        ii.centered = true;
        
        self.scroll_lists[i] = ii;
        ds_list_add(scroll_group.scroll_lists,ii);
    }
    
    eloffset_x += ii.width+spacing;
    
    frame_manager.window_log_str += "\n";
    
    // FILL LISTS WITH DATA
    for(i=0; i<DB.stats_display_rows; i+=1)
    {
        for(p=0;p<=player_num;p+=1)
        {
            var player = gamemode_obj.players[?p];
            
            if(p == 0) 
            {
                gui_add_scroll_item(self.scroll_list, DB.stats_display_labels[|i]);
            }

            var stat = DB.stats_display_keys[|i];
            var str = player.stats[? stat];
            
            if(stat == "" || is_undefined(str))
            {
                str = "";
            }
            else
            {
                str = string(str);
            }
           
            gui_add_scroll_item(self.scroll_lists[p], str);
            
            if(p == player_num) 
            {
                frame_manager.window_log_str += "\n";
            }
        }
    }
    
    // ARROWS
    self.up_arrow = gui_add_button(4,0,"",gui_list_picker_script,true);
    up_arrow.width = 27;
    up_arrow.height = 27;
    up_arrow.icon = small_nice_up_arrow_spr;
    up_arrow.show_icon = true; 
    up_arrow.center_icon = true;
    up_arrow.button_function = "up";
    up_arrow.centered = true;
    
    self.down_arrow = gui_add_button(4,scroll_list.height-27,"",gui_list_picker_script,true);
    down_arrow.width = 27;
    down_arrow.height = 27;
    down_arrow.icon = small_nice_down_arrow_spr;
    down_arrow.show_icon = true;
    down_arrow.center_icon = true;
    down_arrow.button_function = "down";
    down_arrow.centered = true;
}

//eloffset_y += 164;

frame_manager.window_log_str += "\n";

// MATCH STATS
eloffset_x = x;
eloffset_y = y + heading + score_pane.height+16;

match_pane = gui_add_pane(16,0,"MATCH");
match_pane.width = score_pane.width;
match_pane.height = height - heading - score_pane.height - 16 - 64 - 52;

with(match_pane)
{
    centered = true;
    heading = other.pane_heading;
    row_height = other.row_height;
    side_spacing = 8;
    spacing = 1;
    col_thin = other.col_thin;
    col_label = other.col_label;
    col_wide = other.match_col_wide;
    col_number = other.col_number;
    
    table_height = height - heading;
    max_items = floor((table_height-32)/32);
  
    // MATCH SCROLL LISTS
    eloffset_x = x;
    eloffset_y = y + heading;
    
    scroll_group = gui_child_init(0,0,gui_scroll_group);
    
    // LABELS
    ii = gui_add_scroll_list(0,0);
    ii.width = col_wide;
    ii.height = table_height;
    ii.max_items = max_items;
    ii.centered = true;
    
    self.scroll_list = ii;
    ds_list_add(scroll_group.scroll_lists,ii);    
    eloffset_x += ii.width+spacing;
     
    //VALUES   
    ii = gui_add_scroll_list(0,0);
    ii.width = col_number;
    ii.height = table_height;
    ii.max_items = max_items;
    ii.centered = true;
    
    self.scroll_list_values = ii;
    ds_list_add(scroll_group.scroll_lists,ii);   
    eloffset_x += ii.width+spacing;
    
    // FILL MATCH LIST WITH DATA
    frame_manager.window_log_str += "\n";

    for(i=0; i<DB.match_stats_display_rows; i+=1)
    {
        gui_add_scroll_item(self.scroll_list, DB.match_stats_display_labels[|i]);

        var stat = DB.match_stats_display_keys[|i];
        var str = gamemode_obj.stats[? stat];
        
        if(stat == "" || is_undefined(str))
        {
            str = "";
        }
        else
        {
            str = string(str);
        }
       
        gui_add_scroll_item(self.scroll_list_values, str);
        
        frame_manager.window_log_str += "\n";
    }
    
    // MATCH ARROWS
    self.up_arrow = gui_add_button(4,0,"",gui_list_picker_script,true);
    up_arrow.width = 27;
    up_arrow.height = 27;
    up_arrow.icon = small_nice_up_arrow_spr;
    up_arrow.show_icon = true;
    up_arrow.center_icon = true;
    up_arrow.button_function = "up";
    up_arrow.centered = true;
    
    self.down_arrow = gui_add_button(4,scroll_list.height-27,"",gui_list_picker_script,true);
    down_arrow.width = 27;
    down_arrow.height = 27;
    down_arrow.icon = small_nice_down_arrow_spr;
    down_arrow.show_icon = true;
    down_arrow.center_icon = true;
    down_arrow.button_function = "down";
    down_arrow.centered = true;
}

// BUTTONS
eloffset_x = x + match_pane.width/2;
eloffset_y += match_pane.height+16;

// REMATCH
var rematch_text = "";

if(gamemode_obj.is_coop)
{
    rematch_text = "Restart level";
}
else
{
    rematch_text = "Rematch";
}


ii = gui_add_button(16,16, rematch_text, match_restart);
ii.icon = restart_icon;
ii.show_icon = true;
ii.center_icon = true;
ii.enabled = false;
ii.width = 192;
rematch_button = ii.id;

ii.base_bg_color = merge_color(c_lime, c_black, 0.2);
ii.base_text_color = c_white;

eloffset_y += 48;

// MAIN MENU 

/*
ii = gui_add_button(16,16, "Main Menu", goto_mainmenu);
//ii.icon = big_tick_spr;
//ii.show_icon = true;
//ii.center_icon = true;
ii.enabled = false;
ok_button = ii.id;

frame_manager.window_log_str += "\n";
*/

ii = gui_add_button(16,16, "Back", goto_playmenu);
//ii.icon = big_tick_spr;
//ii.show_icon = true;
//ii.center_icon = true;
ii.enabled = false;
ok_button = ii.id;

frame_manager.window_log_str += "\n";


// PLAYER AWARDS
eloffset_x = x + score_pane.width + 32;
eloffset_y = y + heading + plstats_pane.height + 16;

awards_pane = gui_add_pane(0,0,"PLAYER ACHIVEMENTS AND AWARDS");
awards_pane.width = 752;
awards_pane.height = 160;

with(awards_pane)
{
    centered = true;
    heading = other.pane_heading;
    row_height = other.row_height;
    spacing = other.spacing;
    col_thin = other.col_thin;
    col_label = other.col_label;
    col_wide = other.col_wide;
    col_number = other.col_number;
    
    table_height = height - heading;
    max_items = floor((table_height-32)/32);
    
    eloffset_x = x;
    eloffset_y = y + heading;
    
    // AWARDS LABELS
    ii = gui_add_scroll_list(0,0);
    ii.width = width-32;
    ii.height = table_height;
    ii.max_items = max_items;
    ii.centered = true;
    self.scroll_list = ii;
    
    eloffset_x += ii.width;
    
    var i,a,str;
    
    for(i=0; i <= player_num; i+=1)
    {
        player = ds_map_find_value(gamemode_obj.players,i);
        
        for(a=1; a <= player.achiev_count; a+=1)
        {
            if(player.achiev_state[? a] == 1)
            {
                str = script_execute(player.achievs[? a], "title") + ": " + player.name + " " + script_execute(player.achievs[? a], "verb");
                gui_add_scroll_item(self.scroll_list, str);
                frame_manager.window_log_str += "\n";
            }
        }
    }
    
    // AWARDS ARROWS
    self.up_arrow = gui_add_button(4,0, "",gui_list_picker_script,true);
    up_arrow.width = 27;
    up_arrow.height = 27;
    up_arrow.icon = small_nice_up_arrow_spr;
    up_arrow.show_icon = true;
    up_arrow.center_icon = true;
    up_arrow.button_function = "up";
    up_arrow.centered = true;
    
    self.down_arrow = gui_add_button(4,scroll_list.height-27, "",gui_list_picker_script,true);
    down_arrow.width = 27;
    down_arrow.height = 27;
    down_arrow.icon = small_nice_down_arrow_spr;
    down_arrow.show_icon = true;
    down_arrow.center_icon = true;
    down_arrow.button_function = "down";
    down_arrow.centered = true;
}



// DUMP FILE
var filename = "";
var curTime = date_current_datetime();
filename += my_string_format(date_get_year(curTime),4,0) + "-";
filename += my_string_format(date_get_month(curTime),2,0) + "-";
filename += my_string_format(date_get_day(curTime),2,0) + " ";

filename += my_string_format(date_get_hour(curTime),2,0) + "-";
filename += my_string_format(date_get_minute(curTime),2,0) + " ";

filename += string_replace_all(gamemode_obj.stats[? "match_length"],":","-") + " ";

for(i=1;i<=player_num;i+=1)
{
    var player = gamemode_obj.players[?i];
    if(i!=1)
        filename += " - ";
    filename += player.name;    
}

filename += " on " + gamemode_obj.arena_name;
filename += "(" + gamemode_obj.name + ")";
filename += ".txt";

var file = file_text_open_write(filename);
file_text_write_string(file, frame_manager.window_log_str);
file_text_close(file);


alarm[1] = 60;

