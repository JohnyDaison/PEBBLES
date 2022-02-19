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
preset_names = ds_list_create();
preset_ids = ds_list_create();
gmmod_controls = ds_map_create();
gmmod_customs = ds_map_create();

show_hidden_rules = false;

summary_list = ds_list_create();

var hor_spacing = 16;
var vert_spacing = 8;
var heading_start = y + 2 * vert_spacing;
var heading_bg_alpha = 0.25;
var heading_bg_color = c_gray;
var content_start = heading_start + 32 + vert_spacing;

var picker_height = 360;
var gamemode_picker_width = 256;
var level_picker_width = 280;

var summary_width = gamemode_picker_width + hor_spacing + level_picker_width;
var summary_line_count = 14;
var summary_height = summary_line_count * 20 + 8;
var summary_start = content_start + picker_height + vert_spacing;

var rules_grid_unit = 58;
var rules_column_count = 11;
var rules_margins = 40;
var rules_width = rules_column_count * rules_grid_unit + rules_margins;
var rules_height = y + height - content_start - 64 - 48;

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


// Summary SECTION
eloffset_y = summary_start;

ii = gui_add_text_display_scroll_list(0,0);
ii.width = summary_width;
ii.height = summary_height;

summary_scroll_list = ii.id;

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

eloffset_x += place_picker.width + hor_spacing;


// Rules COLUMN
var rules_x_start = eloffset_x;
eloffset_y = heading_start;

ii = gui_add_label(rules_width/2, 16, "Rules");
ii.width = rules_width;
ii.bg_alpha = heading_bg_alpha;
ii.bg_color = heading_bg_color;

eloffset_y = content_start + vert_spacing;

ii = gui_add_label(0, 0, "Preset");
ii.width = 96;
ii.centered = true;

eloffset_x += ii.width + hor_spacing * 0.5;

ii = gui_add_dropdown(0, 0, "text", noone, 0);
ii.width = 256;
ii.text_align = "left";
ii.align_items = "left";
ii.item_change_script = rule_preset_dropdown_script;
preset_dropdown = ii;

eloffset_x = rules_x_start + rules_width;

ii = gui_add_button(0,0, "Reset to default", reset_custom_mod_controls);
ii.centered = true;
gui_move_element(ii, ii.x - ii.width, ii.y);

eloffset_x = rules_x_start;
eloffset_y += 32 + vert_spacing;

ii = gui_add_scroll_list2(0,0);
ii.width = rules_width;
ii.height = rules_height;
ii.centered = true;

rules_scroll_list = ii.id;

var count = DB.rule_categories.count;
var list = DB.rule_categories.list;

for (var index = 0; index < count; index++) {
    var category = list[| index];
    
    gui_add_rules_category_pane(category, gmmod_controls, rules_grid_unit);
}

add_frame(mod_tooltip_window);

eloffset_x = width;
eloffset_y = height;

var button_pane = gui_add_pane(0, 0, "");

with (button_pane) {
    eloffset_x = x + hor_spacing;
    eloffset_y = y;
    height = 32 + 2 * vert_spacing;
    draw_bg_color = true;
    centered = true;
    
    rules_checkbox = gui_add_checkbox(12, height/2, play_menu_window.show_hidden_rules);
    with (rules_checkbox) {
        onchange_function = function() {
            play_menu_window.show_hidden_rules = checked;
            mods_controls_update();
        }
    }
    
    eloffset_x += rules_checkbox.width + hor_spacing * 0.5;
    
    ii = gui_add_label(0, vert_spacing, "Show Hidden Rules");
    ii.width = 196;
    ii.centered = true;
    
    eloffset_x += ii.width + hor_spacing * 1.5;
    
    ii = gui_add_button(0, vert_spacing, "Back", goto_mainmenu);
    ii.width = 96;
    ii.centered = true;

    eloffset_x += ii.width + hor_spacing;

    ii = gui_add_button(0, vert_spacing, "Next", play_menu_window_next_step);
    ii.width = 96;
    ii.centered = true;
    ii.base_bg_color = select_color;
    
    eloffset_x += ii.width + hor_spacing;
    
    width = eloffset_x - x;
}

gui_move_element(button_pane, button_pane.x - button_pane.width - hor_spacing, button_pane.y - button_pane.height - vert_spacing);

// DESTROY ELEPHANT
if(instance_exists(menu_elephant_obj))
{
    instance_destroy(menu_elephant_obj.id);
}

alarm[0] = 2;


load_from_gamemode = function () {
    if (instance_exists(gamemode_obj)) {
        gamemode_picker.select_item_by_id(gamemode_obj.mode);
        preset_dropdown.list_picker.select_item_by_id(gamemode_obj.rule_preset.str_id);
        preset_dropdown.inited = true;
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
