action_inherited();
self.width = 288;
self.height = 288;
x = room_width/2-self.width/2;
y = room_height/2-self.height/2;
self.text = "Mod Tooltip";
self.draw_heading = false;
depth = -20;
bg_alpha = 0.95;
nonfocusable = true;
mod_button = noone;

var ii;
text_padding = 4;
spacing = 16;
mod_button_margin = 8;

eloffset_x = x + spacing;
eloffset_y = y + spacing;

ii = gui_add_label(0,0, "");
ii.width = 48;
ii.height = 48;
ii.icon = item_placeholder_spr
ii.show_icon = true;
ii.center_icon = true;
ii.centered = true;
mod_icon_label = ii;


eloffset_x += mod_icon_label.width + spacing;

ii = gui_add_label(0,0, "name");
ii.width = 192;
ii.height = 48;
ii.centered = true;
mod_name_label = ii;

eloffset_x = x + spacing;
eloffset_y += mod_icon_label.height + spacing;


ii = gui_add_label(0,0, "description");
ii.width = 256;
ii.height = 192;
ii.centered = true;
ii.text_align = "lefttop";
ii.multiline = true;
mod_description_label = ii;

gui_hide_element(self);