action_inherited();
alarm[1] = 5;

self.width = 1112;
self.height = 676;
x = room_width/2-self.width/2;
y = room_height/2-self.height/2;
self.text = "Match Setup";
self.modal = true;

heading = 48;
pane_heading = 32;
row_height = 32;
spacing = 12;
col_thin = 32;
col_number = 80;
col_label = 128;
col_wide = 192;

eloffset_x = x;
eloffset_y = y + heading;

//players_pane = gui_add_pane(width/2,158,"PLAYERS");
players_pane = gui_add_pane(16,0,"PLAYERS");
players_pane.width = 728;
players_pane.height = 300;
players_pane.icon = player_small_spr;
players_pane.show_icon = true;

with(players_pane)
{
    /* 
    x = x-width/2;
    y = y-height/2;
    */
    centered = true;
    
    min_player_num = 2;
    player_num = 0;
    max_player_num = 4;
    
    heading = other.pane_heading;
    row_height = other.row_height;
    spacing = other.spacing;
    col_thin = other.col_thin;
    col_label = other.col_label;
    col_wide = other.col_wide;
    
    control_texts[0] = "Keyboard 1";
    control_texts[1] = "Keyboard 2";
    control_texts[2] = "Joypad 1";
    control_texts[3] = "Joypad 2";
        
    // column labels
    eloffset_x = x + spacing;
    eloffset_y = y + heading;
    
    ii = gui_add_label(0,0,"No");
    ii.width = col_thin;
    ii.centered = true;
    
    eloffset_x += ii.width+spacing;
    
    ii = gui_add_label(0,0,"Control set");
    ii.width = col_label;
    ii.centered = true;
    
    eloffset_x += ii.width+spacing;
    
    ii = gui_add_label(0,0,"Player");
    ii.width = col_wide;
    ii.centered = true;
    
    eloffset_x += ii.width+spacing;
    
    // Create player
    eloffset_x += 2*col_thin+2*spacing;
    
    ii = gui_add_text_input(0,0,"(enter name here)");
    ii.width = col_wide;
    ii.centered = true;
    new_name = ii.id;
    
    eloffset_x += ii.width+spacing;
    
    ii = gui_add_button(12,16,"",match_create_player);
    ii.icon = bigplus_spr;
    ii.show_icon = true;
    ii.width = 24;
    ii.height = 24;
    
    // rows
    eloffset_y += row_height+16;
    tab_start = eloffset_y;
    
    for(i=0;i<4;i+=1)
    {
        eloffset_x = x + spacing;
        
        ii = gui_add_label(0,0,"");
        ii.width = col_thin;
        ii.centered = true;
        number_labels[i] = ii.id;
        
        eloffset_x += ii.width+spacing;
        
        /*
        ii = gui_add_label(0,0,control_texts[i]);
        ii.width = col_label;
        //ii.centered = true;
        if(i>=2)
        {
            ii.show_icon = true;
        }
        control_labels[i] = ii.id;
        */
        
        ii = gui_add_dropdown(0,0, "text", DB.control_set_names, 0);
        ii.width = col_label;
        ii.centered = true;
        control_dropdowns[i] = ii.id;
        
        eloffset_x += ii.width+spacing;
        
        ii = gui_add_label(0,0,"[Subject Name Here]");
        ii.width = col_wide;
        ii.enabled = false;
        ii.centered = true;
        player_names[i] = ii.id;
        
        eloffset_x += ii.width+spacing;
        
        ii = gui_add_button(16,16,"",match_unassign_player);
        ii.width = 24;
        ii.height = 24;
        ii.icon = unassign_arrow;
        ii.show_icon = true;
        ii.enabled = false;
        ii.index = i;
        unassign_buttons[i] = ii.id;
        
        eloffset_x += col_thin+spacing;
        
        ii = gui_add_button(16,16,"",match_assign_player);
        ii.width = 24;
        ii.height = 24;
        ii.icon = assign_arrow;
        ii.show_icon = true;
        ii.index = i;
        assign_buttons[i] = ii.id;
        
        eloffset_x += col_thin+spacing; 
        
        eloffset_y += row_height+spacing;
    }
    
    tab_end = eloffset_y;
    
    eloffset_y = tab_start;
    
    ii = gui_add_list_picker(0,0, "text", DB.player_names);
    ii.width = col_wide+44;
    player_picker = ii.id;
    
    eloffset_y = tab_end;
    
    ii = gui_add_button(0,0,"Delete",match_delete_player);
    ii.centered = true;
}


eloffset_x = x + players_pane.width+32;

limits_pane = gui_add_pane(0,0,"LIMITS");
limits_pane.width = 336;
limits_pane.height = height - heading - 64;

with(limits_pane)
{
    centered = true;
    
    heading = other.pane_heading;
    row_height = other.row_height;
    spacing = 16;
    col_thin = other.col_thin;
    col_label = other.col_label;
    col_number = other.col_number;
    col_wide = 160;
    
    eloffset_x = x + spacing;
    eloffset_y = y + heading;
        
    // LIMITS TABLE
    
    ii = gui_add_label(0,0,"On");
    ii.width = col_thin;
    ii.centered = true;
    
    eloffset_x += ii.width+spacing;
    
    ii = gui_add_label(0,0,"Limit");
    ii.width = col_wide;
    ii.centered = true;
    
    eloffset_x += ii.width+spacing;
    
    ii = gui_add_label(0,0,"Value");
    ii.width = col_number;
    ii.centered = true;
    
    eloffset_x += ii.width+spacing;
    
    // rows
    eloffset_y += row_height+16;
    tab_start = eloffset_y;
    
    for(i=0;i<DB.limit_count;i+=1)
    {
        eloffset_x = x + spacing;
        
        ii = gui_add_checkbox(16,16);
        limit_checkboxes[i] = ii.id;
        
        eloffset_x += col_thin+spacing;
        
        ii = gui_add_label(0,0, DB.limit_ids[| i]);
        ii.width = col_wide;
        ii.centered = true;
        
        eloffset_x += ii.width+spacing;
        
        ii = gui_add_int_input(32,16,ds_map_find_value(DB.limit_values,i),1,999);
        ii.enabled = false;
        //ii.centered = true;
        limit_dials[i] = ii.id;

        eloffset_x += col_number+spacing;
        
        eloffset_y += row_height+spacing;
    }
}

//eloffset_y += 164;


eloffset_x = x;
eloffset_y = y + heading + players_pane.height+16;


match_pane = gui_add_pane(16,0,"MATCH");
match_pane.width = 296*2;
match_pane.height = 296;

with(match_pane)
{
    centered = true;
    col_wide = other.col_wide;
    heading = other.pane_heading;
    row_height = other.row_height;
    spacing = 3;

    eloffset_x = x + 12+col_wide+6;
    eloffset_y = y + heading + 16;
        
    // STARTING SLOTS
    /*
    ii = gui_add_label(-100,0,"Starting slots");
    ii.width = col_wide;
    
    ii = gui_add_int_input(32,0,DB.arena_slots,0,3);
    //ii.centered = true;
    starting_slots = ii.id;
    */
    eloffset_y += row_height + spacing;
    
    // ARENA
    /*
    ii = gui_add_list_picker(-col_wide-4,0, "text", DB.arena_names);
    //ii.width = col_wide+44;
    arena_picker = ii.id;
    
    eloffset_x += 12+1.5*col_wide+6;
    eloffset_y = y + heading + 16;
    */
    
    // DARK MAGIC
    ii = gui_add_label(-100,0,"Ban Dark Color");
    ii.width = col_wide;
    
    ii = gui_add_checkbox(20,0);
    //ii.centered = true;
    ban_black = ii.id;
    
    eloffset_y += row_height + spacing;
    
    // SUDDEN DEATH
    ii = gui_add_label(-100,0,"Sudden Death");
    ii.width = col_wide;
    
    ii = gui_add_checkbox(20,0);
    //ii.centered = true;
    sudden_death = ii.id;
    
    eloffset_y += row_height + spacing;
    
    // SIMPLE MODE
    ii = gui_add_label(-100,0,"Simple Mode");
    ii.width = col_wide;
    
    ii = gui_add_checkbox(20,0);
    ii.tooltip = "No turrets, cannons, mobs";
    //ii.centered = true;
    simple_mode = ii.id;
    
    eloffset_y += row_height + spacing;
    
    // HP DEATH
    ii = gui_add_label(-100,0,"Death by damage");
    ii.width = col_wide;
    
    ii = gui_add_checkbox(20,0);
    //ii.centered = true;
    hp_death = ii.id;
    
    eloffset_y += row_height + spacing;
    
    // WEAK TERRAIN
    ii = gui_add_label(-100,0,"Weak terrain");
    ii.width = col_wide;
    
    ii = gui_add_checkbox(20,0);
    //ii.centered = true;
    weak_terrain = ii.id;
    
    eloffset_y += row_height + spacing;
    
    // TUTORIALS
    ii = gui_add_label(-100,0,"Tutorials");
    ii.width = col_wide;
    
    ii = gui_add_checkbox(20,0);
    //ii.centered = true;
    tutorials = ii.id;
    
    eloffset_y += row_height + spacing;
    
    // BOLT RAIN
    ii = gui_add_label(-100,0,"Acid rain");
    ii.width = col_wide;
    
    ii = gui_add_checkbox(20,0);
    ii.tooltip = "Rainbow tears of pain";
    //ii.centered = true;
    bolt_rain = ii.id;
}


eloffset_x = x + width-16;
eloffset_y = y + heading + limits_pane.height+16;

// OK and Cancel

ii = gui_add_button(-256,16,"Start",match_start);
ii.icon = big_tick_spr;
ii.show_icon = true;
ii.center_icon = true;
ii.enabled = false;
start_button = ii;

ii = gui_add_button(-80,16,"Cancel",goto_mainmenu);


/* */
/*  */
