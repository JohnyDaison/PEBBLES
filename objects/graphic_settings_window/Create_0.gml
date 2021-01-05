event_inherited();

self.width = 992;
self.height = 576;

update_display();

x = view_wport[0] / 2 - self.width / 2;
y = view_hport[0] / 2 - self.height / 2;

self.text = "Settings";
self.modal = true;

var top_line = 80;
var left_line_height = 64;
var center_line_height = 48;
var checkbox_column_x = 40;
var checkbox_label_x = 64;

var i,ii;


eloffset_x = x + 16;
eloffset_y = y + top_line;


fullscreen_checkbox = gui_add_checkbox(checkbox_column_x, 0, singleton_obj.fullscreen);

i = gui_add_label(checkbox_label_x,-16, "Fullscreen");
i.centered = true;


eloffset_y += left_line_height;


vsync_checkbox = gui_add_checkbox(checkbox_column_x, 0, singleton_obj.vsync);

i = gui_add_label(checkbox_label_x,-16, "V-Sync");
i.centered = true;


eloffset_y += left_line_height;


scale_gui_checkbox = gui_add_checkbox(checkbox_column_x, 0, singleton_obj.scale_up_gui);

i = gui_add_label(checkbox_label_x,-16, "Upscale Menu");
i.centered = true;


eloffset_y += left_line_height;


interpolate_menu_checkbox = gui_add_checkbox(checkbox_column_x, 0, singleton_obj.interpolate_menu);

i = gui_add_label(checkbox_label_x,-16, "Interpolate Menu");
i.centered = true;
i.width += 32;


eloffset_y += left_line_height;


interpolate_game_checkbox = gui_add_checkbox(checkbox_column_x, 0, singleton_obj.interpolate_game);

i = gui_add_label(checkbox_label_x,-16, "Interpolate Game");
i.centered = true;
i.width += 32;


eloffset_y += left_line_height;


var half_checkbox = 12;
i = gui_add_label(checkbox_column_x - half_checkbox, -16, "Anti-aliasing");
i.centered = true;

ii = gui_add_int_input(checkbox_column_x - half_checkbox + 196, 0, singleton_obj.aa_level, 0, 2);
ii.value_step = 2;
aa_input = ii.id;


eloffset_y += left_line_height;


ff_checkbox = gui_add_checkbox(checkbox_column_x, 0, singleton_obj.force_feedback);

i = gui_add_label(checkbox_label_x,-16, "Controller Vibration");
i.centered = true;
i.width += 64;


eloffset_y += left_line_height;


labels_checkbox = gui_add_checkbox(checkbox_column_x, 0, singleton_obj.draw_object_labels);

i = gui_add_label(checkbox_label_x,-16, "Show Labels");
i.centered = true;


eloffset_x += 360;
eloffset_y = y + top_line;

i = gui_add_label(40,-16, "Resolution");
i.centered = true;

eloffset_y += 24;

ii = gui_add_list_picker(0,0, "text", DB.resolution_list);
ii.auto_items = true;
ii.item_height = 36;
ii.height = 176;
resolution_picker = ii.id;


eloffset_y += 216;

i = gui_add_label(0,-16, "Master Volume");
i.centered = true;

ii = gui_add_int_input(196,0, singleton_obj.master_volume, 0, 100);
ii.value_step = 5;
ii.is_percent = true;
master_volume_input = ii.id;

eloffset_y += center_line_height;

i = gui_add_label(0,-16, "Game Speed");
i.centered = true;

ii = gui_add_int_input(196,0, singleton_obj.game_speed, 30, 60);
gamespeed_input = ii.id;

eloffset_y += center_line_height;

i = gui_add_label(0,-16, "Speech Speed");
i.centered = true;

ii = gui_add_int_input(196,0, (DB.max_npc_speech_tick + 1) - DB.npc_speech_tick, 1, DB.max_npc_speech_tick);
speechspeed_input = ii.id;


eloffset_x = x;
eloffset_y = height - 16;

ii = gui_add_button(self.width/2,0, "Apply", graphic_config_apply);
ii.icon = big_tick_spr;
ii.center_icon = true;
ii.show_icon = true;


eloffset_y += center_line_height;


ii = gui_add_button(self.width/2,0, "Back to Menu", graphic_config_OK);


alarm[2] = 2;
