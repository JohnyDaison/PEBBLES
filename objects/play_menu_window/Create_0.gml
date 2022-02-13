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
    width = 1248;
    
    draw_heading = false;
    
    gamemode_names = ds_list_create();
    place_names = ds_list_create();
    place_ids = ds_list_create();
    gmmod_controls = ds_map_create();
    gmmod_customs = ds_map_create();
    
    gamemode_description_list = ds_list_create();
    place_description_list = ds_list_create();
    
    var hor_spacing = 16;
    var vert_spacing = 8;
    var heading_start = y + vert_spacing;
    var content_start = y + 32 + 2*vert_spacing;
    var main_content_height = 352;
    var picker_width = 320;
    
    var description_line_count = 10;
    var description_height = description_line_count * 20 + 32;
    var description_start = content_start + main_content_height + vert_spacing;
    var modifier_chb_size = 40;
    var mod_grid_unit = 56;
    var mod_dist = mod_grid_unit;
    var mod_column_count = 9;
    //var mods_width = 720;
    var mods_width = mod_column_count * mod_grid_unit;
    
    
    height = description_start + description_height + vert_spacing - y;

    // POPULATE gamemode_names
    var i, count = ds_list_size(DB.gamemode_list), gm, ii;
    
    for(i=0; i<count; i++)
    {
        gm = DB.gamemodes[? (DB.gamemode_list[| i])];
        ds_list_add(gamemode_names, gm[? "name"]);
    }
    
    eloffset_x = x + hor_spacing;
    
    // Game Mode COLUMN
    eloffset_y = heading_start;
    
    ii = gui_add_label(0,0, "Game Mode");
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
    
    
    // Description SECTION
    eloffset_y = description_start;
    
    ii = gui_add_text_display_scroll_list(0,0);
    ii.width = picker_width;
    ii.height = description_height;
    
    gamemode_description_scroll_list = ii.id;
    
    eloffset_x += gamemode_picker.width + hor_spacing;
    
    
    // Level COLUMN
    eloffset_y = heading_start;
    
    ii = gui_add_label(0,0, "Level");
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
    
    // Description SECTION
    eloffset_y = description_start;
    
    ii = gui_add_text_display_scroll_list(0,0);
    ii.width = picker_width;
    ii.height = description_height;
    
    level_description_scroll_list = ii.id;
    
    eloffset_x += place_picker.width + hor_spacing;
    
    
    // Rules COLUMN
    eloffset_y = heading_start;
    
    ii = gui_add_label(mods_width/2, 16, "Rules");
    ii.width = mods_width;
    //ii.width = 64;
    
    eloffset_y = content_start;
    
    var mods_content_x = eloffset_x;
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
            mods_width = min(mod_column_count, ceil(count/2)) * mod_grid_unit;
        }
        
        if(gmmod_type == "number") {
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
                    ii = gui_add_mod_boolbox(0, 0, gmmod_id, modifier_chb_size);

                    ii.checkbox.user_clicked_script = mod_chb_user_click_script;
                    ii.checkbox.onchange_script = schedule_play_summary_update;
                    ii.checkbox.draw_unlocked_border = true;
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
            
            if(eloffset_x > (mods_content_x + mods_width - mod_dist + hor_spacing))
            {
                eloffset_x = mods_content_x;
                eloffset_y += mod_grid_unit + vert_spacing;
            }
        }
    
        eloffset_x = mods_content_x;
        eloffset_y += mod_grid_unit + vert_spacing;
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

eloffset_x += gamemode_pane.width - 224;
eloffset_y += gamemode_pane.height;

ii = gui_add_button(0, vert_spacing, "Back", goto_mainmenu);
ii.width = 96;
ii.centered = true;

ii = gui_add_button(112, vert_spacing, "Next", play_menu_window_next_step);
ii.width = 96;
ii.centered = true;
ii.base_bg_color = select_color;

self.width = gamemode_pane.width;
self.height = gamemode_pane.height + 32 + vert_spacing;
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
