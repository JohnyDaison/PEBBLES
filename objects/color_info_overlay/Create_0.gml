event_inherited();

my_player = noone;

nonfocusable = true;
draw_border = false;
self.bg_color = c_black;
self.bg_alpha = 0.8;

self.width = 362;
self.height = 248;
abi_panel_height = 64;
margin = 8;
line_height = 24;

// to prevent visual blink in initial position
x = -1000;
y = -1000;

window_x_center = x + self.width / 2;
window_y_center = y + self.height / 2;


eloffset_x = x + margin;
eloffset_y = y + margin;


power_pane = gui_add_color_power_pane(0, 0);
power_pane.centered = true;


eloffset_x += power_pane.width + margin;
eloffset_y += margin;


var ii, second_column_width = sprite_get_width(color_wheel_info_spr);
var label_column_offset = line_height + margin;
var label_column_width = second_column_width - label_column_offset;


ii = gui_add_label(0, 0, "");
ii.icon = row_arrow_spr;
ii.width = line_height;
ii.height = line_height;
ii.show_icon = true;
ii.center_icon = true;
ii.centered = true;

attack_icon = ii;


ii = gui_add_label(label_column_offset, 0, "ATTACK");
ii.centered = true;
ii.width = label_column_width;
ii.height = 24;

attack_label = ii;


eloffset_y += line_height + margin;


ii = gui_add_label(0, 0, "");
ii.icon = column_circle_spr;
ii.width = line_height;
ii.height = line_height;
ii.show_icon = true;
ii.center_icon = true;
ii.centered = true;

defense_icon = ii;


ii = gui_add_label(label_column_offset, 0, "DEFENSE");
ii.centered = true;
ii.width = label_column_width;
ii.height = 24;

defense_label = ii;


eloffset_y += line_height + margin;


ii = gui_add_label(0, 0, "");
ii.icon = heal_power_spr;
ii.width = line_height;
ii.height = line_height;
ii.show_icon = true;
ii.center_icon = true;
ii.centered = true;

healing_icon = ii;


ii = gui_add_label(label_column_offset, 0, "HEAL");
ii.centered = true;
ii.width = label_column_width;
ii.height = 24;

healing_label = ii;


eloffset_y += line_height + margin;


ii = gui_add_label(0, 0, "");
ii.icon = color_wheel_info_spr;
ii.width = sprite_get_width(ii.icon);
ii.height = sprite_get_height(ii.icon);
ii.show_icon = true;
ii.center_icon = true;
ii.centered = true;

color_wheel = ii;