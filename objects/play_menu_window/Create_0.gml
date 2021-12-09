event_inherited();

update_display();

self.height = 656;
window_axis = display_get_gui_width()/2;

self.text = "Play Menu";
self.draw_heading = false;
self.draw_bg_color = false;
self.draw_border = false;
self.world = noone;

self.modal = true;
self.update_summary = false;

eloffset_x = x;
eloffset_y = y;

gamemode_pane = gui_add_pane(0,0, "Game mode");

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
    

    // Rules SECTION
    eloffset_x = mods_x;
    eloffset_y = mods_start;
    
    ii = gui_add_label(0,4, "Rules:");
    ii.width = 64;
    ii.centered = true;
    mods_label = ii.id;

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
        
        if(gmmod_type == "bool") {
            mods_width = 80 + min(15, ceil(count/2)) * mod_dist;
        }
        
        if(gmmod_type == "number") {
            eloffset_x -= 8;
            eloffset_y -= 8;
            mod_dist = 2 * 56;
        }
    
        for(i=0; i<count; i++)
        {
            gmmod_id = list[| i];
            
            if(gmmod_id != "blank_space")
            {
                ii = noone;
        
                if(gmmod_type == "bool")
                {
                    ii = gui_add_mod_checkbox(0, 0, gmmod_id, modifier_chb_size);

                    ii.user_clicked_script = mod_chb_user_click_script;
                    ii.onchange_script = schedule_play_summary_update;
                    ii.draw_unlocked_border = true;
                }
                else if(gmmod_type == "number")
                {
                    ii = gui_add_mod_numberbox(0, 0, gmmod_id, modifier_chb_size);

                    ii.checkbox.user_clicked_script = mod_chb_user_click_script;
                    ii.checkbox.onchange_script = number_mod_change_state_script;
                    ii.checkbox.draw_unlocked_border = true;
                    
                    ii.number_input.onchange_script = number_mod_change_value_script;
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
        eloffset_y += vert_spacing;
    }
    
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

eloffset_y += gamemode_pane.height - (2 * 32 + 2 * vert_spacing);

ii = gui_add_button(0,0, "Next step", play_menu_window_next_step);
ii.centered = true;
ii.base_bg_color = select_color;
next_step_button = ii.id;

eloffset_y += 32 + vert_spacing;

ii = gui_add_button(0,0, "Back", goto_mainmenu);
ii.width = 96;
ii.centered = true;
    
eloffset_x += next_step_button.width + hor_spacing;

self.width = 3*hor_spacing + gamemode_pane.width + next_step_button.width;
x = window_axis - width/2;
y = 8;

// DESTROY ELEPHANT
if(instance_exists(menu_elephant_obj))
{
    instance_destroy(menu_elephant_obj.id);
}

alarm[0] = 2;


load_from_gamemode = function () {
    if (instance_exists(gamemode_obj)) {
        var gm_picker = gamemode_pane.gamemode_picker;
        gm_picker.select_item_by_id(gamemode_obj.mode);
        
        var place_picker = gamemode_pane.place_picker;
        place_picker.select_item_by_id(gamemode_obj.world.current_place.room_id);
        
        ds_map_copy(gamemode_pane.gmmod_customs, gamemode_obj.custom_mods);
        mods_controls_update();
    }
    
    with(gamemode_obj)
    {
        instance_destroy();
    }
}

event_perform(ev_step, ev_step_end);
