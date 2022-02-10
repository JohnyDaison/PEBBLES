function gui_add_player_setup_pane(xx, yy, player_num) {
    var player_pane = gui_add_pane(xx, yy, "Player " + string(player_num));
    var team_number = calculate_team_number(player_num);

    with(player_pane)
    {
        draw_bg_color = true;
        draw_heading = false;
        centered = true;
        width = 304;
        height = 208;
        var hor_spacing = 16
        var vert_spacing = 8;
        var name = "";
        var ii;
    
        controls_names = ds_list_create();
        controls_ids = ds_list_create();
        team_names = ds_list_create();
    
        eloffset_x = x + hor_spacing;
        eloffset_y = y + vert_spacing;
    
        switch(player_num)
        {
            case 1:
                name = "Johny Daison";
                break;
            case 2:
                name = "CyberLabs";
                break;
            default:
                name = "Player " + string(player_num);
                break;
        }
    
        ii = gui_add_text_input(0, 0, name);
        ii.centered = true;
        ii.max_chars = 15;
        ii.width = 192;
        name_input = ii;
    
        eloffset_x = x + hor_spacing;
        eloffset_y += name_input.height + vert_spacing;
    
        ii = gui_add_dropdown(0, 0, "text", DB.control_set_names, 0);
        ii.width = 192;
        control_dropdown = ii;
        
        eloffset_x += control_dropdown.width + hor_spacing;
    
        ii = gui_add_dropdown(0, 0, "flag", DB.player_flags, 0);
        ii.width = 64;
        flag_input = ii;
        
        eloffset_x = x + hor_spacing;
        eloffset_y += control_dropdown.height + vert_spacing;
        
        ii = gui_add_dropdown(0, 0, "text", DB.team_names, team_number - 1);
        ii.width = 128;
        team_dropdown = ii;
        
        eloffset_x = x + hor_spacing;
        eloffset_y += team_dropdown.height + 2*vert_spacing;
    
        ii = gui_add_slider(0, 0, 10, 1, 10);
        ii.tooltip = "Max HP";
        ii.centered = true;
        ii.bar_min_value = 0;
        handicap_input = ii;

        ii = gui_add_label(handicap_input.width + hor_spacing, 0, "Max HP");
        ii.width = 96;
        ii.centered = true;
    
        eloffset_y += 32 + 2*vert_spacing;
    
        ii = gui_add_int_input(24, 16, 100, 10, 150);
        ii.value_step = 10;
        ii.is_percent = true;
        cpudiff_input = ii;

        ii = gui_add_label(40 + hor_spacing, 0, "CPU difficulty");
        ii.centered = true;
        //ii.width = 200;
        cpudiff_label = ii;
    
        eloffset_y += 32 + 2*vert_spacing;
    
        height = eloffset_y - y;
    }

    return player_pane;
}
