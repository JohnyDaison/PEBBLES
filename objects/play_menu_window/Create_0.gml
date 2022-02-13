event_inherited();

update_display();

width = 1280;
height = 720;

self.text = "Play Menu";
self.draw_heading = false;
self.draw_bg_color = false;
self.draw_border = false;
self.world = noone;

self.modal = true;
self.update_summary = false;

eloffset_x = x;
eloffset_y = y;

gamemode_names = ds_list_create();
place_names = ds_list_create();
place_ids = ds_list_create();
gmmod_controls = ds_map_create();
gmmod_customs = ds_map_create();

gamemode_description_list = ds_list_create();
place_description_list = ds_list_create();

var hor_spacing = 16;
var vert_spacing = 8;
var heading_start = y + 2 * vert_spacing;
var heading_bg_alpha = 0.25;
var heading_bg_color = c_gray;
var content_start = heading_start + 32 + vert_spacing;
var picker_height = 352;
var gamemode_picker_width = 272;
var level_picker_width = 288;

var description_line_count = 13;
var description_height = description_line_count * 20 + 32;
var description_start = content_start + picker_height + vert_spacing;
var rules_grid_unit = 56;
var rules_column_count = 11;
var rules_margins = 40;
var rules_width = rules_column_count * rules_grid_unit + rules_margins;
var rules_height = y + height - content_start - 64;

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
ii.width = gamemode_picker_width;
ii.bg_alpha = heading_bg_alpha;
ii.bg_color = heading_bg_color;

ii.centered = true;

eloffset_y = content_start;

ii = gui_add_list_picker(0,0, "text", gamemode_names, DB.gamemode_list);
ii.width = gamemode_picker_width;
ii.height = picker_height;
ii.auto_items = true;
ii.centered = true;
ii.item_change_script = gamemode_picker_script;
gamemode_picker = ii.id;


// Description SECTION
eloffset_y = description_start;

ii = gui_add_text_display_scroll_list(0,0);
ii.width = gamemode_picker_width;
ii.height = description_height;

gamemode_description_scroll_list = ii.id;

eloffset_x += gamemode_picker.width + hor_spacing;


// Level COLUMN
eloffset_y = heading_start;

ii = gui_add_label(0,0, "Level");
ii.width = level_picker_width;
ii.bg_alpha = heading_bg_alpha;
ii.bg_color = heading_bg_color;

ii.centered = true;

eloffset_y = content_start;

ii = gui_add_list_picker(0,0, "text");
ii.width = level_picker_width;
ii.height = picker_height;
ii.auto_items = true;
ii.centered = true;
ii.align_items = "left";
ii.item_change_script = place_picker_script;
place_picker = ii.id;

// Description SECTION
eloffset_y = description_start;

ii = gui_add_text_display_scroll_list(0,0);
ii.width = level_picker_width;
ii.height = description_height;

level_description_scroll_list = ii.id;

eloffset_x += place_picker.width + hor_spacing;


// Rules COLUMN
eloffset_y = heading_start;

ii = gui_add_label(rules_width/2, 16, "Rules");
ii.width = rules_width;
ii.bg_alpha = heading_bg_alpha;
ii.bg_color = heading_bg_color;


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

add_frame(mod_tooltip_window);

eloffset_x = width - 224;
eloffset_y = height - 56;

ii = gui_add_button(0, vert_spacing, "Back", goto_mainmenu);
ii.width = 96;
ii.centered = true;

ii = gui_add_button(112, vert_spacing, "Next", play_menu_window_next_step);
ii.width = 96;
ii.centered = true;
ii.base_bg_color = select_color;

// DESTROY ELEPHANT
if(instance_exists(menu_elephant_obj))
{
    instance_destroy(menu_elephant_obj.id);
}

alarm[0] = 2;


load_from_gamemode = function () {
    if (instance_exists(gamemode_obj)) {
        gamemode_picker.select_item_by_id(gamemode_obj.mode);
        place_picker.select_item_by_id(gamemode_obj.world.current_place.room_id);
        
        ds_map_copy(gmmod_customs, gamemode_obj.custom_mods);
        mods_controls_update();
    }
    
    with(gamemode_obj)
    {
        instance_destroy();
    }
}

event_perform(ev_step, ev_step_end);
