event_inherited();

self.my_player = noone;

self.nonfocusable = true;
self.draw_border = false;
self.bg_color = c_black;
self.bg_alpha = 0.8;

self.width = 416;
self.height = 302;
self.abi_panel_height = 64;
self.margin = 8;
self.line_height = 24;

// to prevent visual blink in initial position
self.x = -1000;
self.y = -1000;

// LEFT TOP CORNER
self.eloffset_x = self.x + self.margin;
self.eloffset_y = self.y + self.margin;


// POWER PANE
self.power_pane = gui_add_color_power_pane(0, 0);
self.power_pane.centered = true;


// SECOND COLUMN
self.eloffset_x += self.power_pane.width + self.margin;
self.eloffset_y = y + self.power_pane.margin + self.power_pane.heading_height;


var inst;
var second_column_width = sprite_get_width(color_wheel_info_spr);
var label_column_offset = self.line_height + self.margin;
var label_column_width = second_column_width - label_column_offset;


// ATTACK ICON
inst = gui_add_label(0, 0, "");

inst.icon = row_arrow_spr;
inst.width = self.line_height;
inst.height = self.line_height;
inst.show_icon = true;
inst.center_icon = true;
inst.centered = true;

//attack_icon = ii;


// ATTACK LABEL
inst = gui_add_label(label_column_offset, 0, "ATTACK");

inst.centered = true;
inst.width = label_column_width;
inst.height = 24;

//attack_label = ii;


// NEW LINE
self.eloffset_y += self.line_height + self.margin;


// DEFENSE ICON
inst = gui_add_label(0, 0, "");

inst.icon = column_circle_spr;
inst.width = self.line_height;
inst.height = self.line_height;
inst.show_icon = true;
inst.center_icon = true;
inst.centered = true;

//defense_icon = ii;


// DEFENSE LABEL
inst = gui_add_label(label_column_offset, 0, "DEFENSE");

inst.centered = true;
inst.width = label_column_width;
inst.height = 24;

//defense_label = ii;


// NEW LINE
self.eloffset_y += self.line_height + self.margin;


// HEAL ICON
inst = gui_add_label(0, 0, "");

inst.icon = heal_power_spr;
inst.width = self.line_height;
inst.height = self.line_height;
inst.show_icon = true;
inst.center_icon = true;
inst.centered = true;

//healing_icon = ii;


// HEAL LABEL
inst = gui_add_label(label_column_offset, 0, "HEAL");

inst.centered = true;
inst.width = label_column_width;
inst.height = 24;

//healing_label = ii;


// NEW LINE
self.eloffset_y += self.line_height + self.margin;


// COLOR WHEEL
inst = gui_add_label(0, 0, "");

inst.icon = color_wheel_info_spr;
inst.width = sprite_get_width(inst.icon) - 1;
inst.height = sprite_get_height(inst.icon) - 1;
inst.show_icon = true;
inst.center_icon = true;
inst.centered = true;
inst.draw_bg_color = false;

self.color_wheel = inst;

self.color_wheel.rel_y = self.power_pane.height - self.color_wheel.height - 1;
