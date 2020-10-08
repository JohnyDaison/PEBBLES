window_axis = x+self.width/2;

// TOP LINE

eloffset_x = x+32;
eloffset_y = y+32;

ii = gui_add_button(0,0,"",terrain_erase_onup,false);
ii.width = 32;
ii.height = 32;
ii.icon = bigX_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Erase Terrain";

eloffset_x += 48;

ii = gui_add_button(0,0,"",indestructible_onup,false);
ii.width = 32;
ii.height = 32;
ii.icon = indestructible_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Indestructible Terrain";

eloffset_x += 48;

ii = gui_add_button(0,0,"",destructible_onup,false);
ii.width = 32;
ii.height = 32;
ii.icon = destructible_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Destructible Terrain";

eloffset_x += 96;

ii = gui_add_label(0,0,"Create");
ii.width = 64;
ii.height = 32;
ii.visible = true;

eloffset_x += 48;

ii = gui_add_checkbox(0,0);
ii.checked = true;
ii.show_icon = true;
ii.visible = true;
create_checkbox = ii;

eloffset_x += 80;

ii = gui_add_label(0,0,"Overwrite");
ii.width = 96;
ii.height = 32;
ii.visible = true;

eloffset_x += 64;

ii = gui_add_checkbox(0,0);
ii.visible = true;
overwrite_checkbox = ii;

// BOTTOM LINE

eloffset_x = x+32;
eloffset_y = y+80;

ii = gui_add_button(0,0,"",terrain_hor_shift,false);
ii.width = 32;
ii.height = 32;
ii.icon = hor_shift_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Shift Terrain Horizontally";

eloffset_x += 56;

ii = gui_add_int_input(0,0,1,-99,99);
ii.max_digits = 2;
ii.visible = true;
hor_shift_input = ii;

eloffset_x += 72;

ii = gui_add_button(0,0,"",terrain_vert_shift,false);
ii.width = 32;
ii.height = 32;
ii.icon = vert_shift_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Shift Terrain Vertically";

eloffset_x += 56;

ii = gui_add_int_input(0,0,1,-99,99);
ii.max_digits = 2;
ii.visible = true;
vert_shift_input = ii;

