window_axis = x+self.width/2;

// TOP LINE

eloffset_x = x+32;
eloffset_y = y+32;

ii = gui_add_button(0,0,"",structure_erase_onup,false);
ii.width = 32;
ii.height = 32;
ii.icon = bigX_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Erase Structures";

eloffset_x += 48;

ii = gui_add_button(0,0,"",guy_spawner_onup,false);
ii.width = 32;
ii.height = 32;
ii.icon = structure_placer_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Guy Spawner";

eloffset_x += 48;

ii = gui_add_button(0,0,"",jump_pad_onup,false);
ii.width = 32;
ii.height = 32;
ii.icon = jump_pad_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Jump Pad";

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

eloffset_x = x+32;
eloffset_y += 48;

ii = gui_add_button(0,0,"",turret_onup,false);
ii.width = 32;
ii.height = 32;
ii.icon = turret_mount_spr;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Turret";


