/// @description gui_add_player_setup_pane(x, y, player_number);
/// @function gui_add_player_setup_pane
/// @param x
/// @param y
/// @param player_number
function gui_add_player_setup_pane(argument0, argument1, argument2) {

    var xx,yy,player_num,ii;

    xx = argument0;
    yy = argument1;
    player_num = argument2;

    var player_pane = gui_add_pane(xx, yy, "Player " + string(player_num));

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
    
        controls_names = ds_list_create();
        controls_ids = ds_list_create();
    
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
    
        eloffset_x += name_input.width + hor_spacing;
    
        ii = gui_add_dropdown(0, 0, "flag", DB.player_flags, 0);
        ii.width = 58;
        flag_input = ii;
    
        eloffset_x = x + hor_spacing;
        eloffset_y += 32 + vert_spacing;
    
        ii = gui_add_dropdown(0, 0, "text", DB.control_set_names, 0);
        ii.width = 192;
        control_dropdown = ii;
    
        eloffset_y += control_dropdown.height + 2*vert_spacing;
    
        ii = gui_add_int_input(24, 16, 0, 0, 90);
        ii.tooltip = "MaxHP reduction";
        ii.value_step = 10;
        ii.is_percent = true;
        handicap_input = ii;

        ii = gui_add_label(40 + hor_spacing, 0, "Handicap");
        ii.centered = true;
    
        eloffset_y += 32 + vert_spacing;
    
        ii = gui_add_int_input(24, 16, 100, 10, 150);
        ii.value_step = 10;
        ii.is_percent = true;
        cpudiff_input = ii;

        ii = gui_add_label(40 + hor_spacing, 0, "CPU difficulty");
        ii.centered = true;
        //ii.width = 200;
        cpudiff_label = ii;
    
        eloffset_y += 32 + vert_spacing;
    
        height = eloffset_y - y;
    }

    return player_pane;
}
