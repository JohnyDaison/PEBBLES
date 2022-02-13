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
    var rules_grid_unit = 56;
    var rules_column_count = 9;
    var margins = 40;
    var rules_width = rules_column_count * rules_grid_unit + margins;
    
    height = description_start + description_height + vert_spacing - y;
    
    var rules_height = height - content_start - vert_spacing;

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
    
    ii = gui_add_label(rules_width/2, 16, "Rules");
    ii.width = rules_width;
    //ii.width = 64;
    
    eloffset_y = content_start;
    
    ii = gui_add_scroll_list2(0,0);
    ii.width = rules_width;
    ii.height = rules_height;
    ii.centered = true;
    
    rules_scroll_list = ii.id;
    
    var count = DB.rule_categories.count;
    var list = DB.rule_categories.list;
    
    for (var index = 0; index < count; index++) {
        var category = list[| index];
        
        gui_add_rules_category_pane(category, gmmod_controls);
    }
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
