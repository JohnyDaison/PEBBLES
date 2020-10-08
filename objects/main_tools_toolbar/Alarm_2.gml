window_axis = x+self.width/2;


eloffset_x = x+32;
eloffset_y = y+64;

ii = gui_add_button(0,0,"",tool_reset_onup,false);
ii.width = 32;
ii.height = 32;
ii.icon = cursor_arrow;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Basic Cursor";

eloffset_y += 48;

ii = gui_add_button(0,0,"",selection_tool_onup,false);
ii.width = 32;
ii.height = 32;
ii.icon = select_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Select";

eloffset_y += 48;

ii = gui_add_button(0,0,"",pan_tool_onup,false);
ii.width = 32;
ii.height = 32;
ii.icon = hand_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Pan Tool";

eloffset_y += 48;

ii = gui_add_button(0,0,"",terrain_placer_toggle,false);
ii.width = 32;
ii.height = 32;
ii.icon = terrain_placer_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Terrain Placer";

eloffset_y += 48;

ii = gui_add_button(0,0,"",empty_script,false);
ii.width = 32;
ii.height = 32;
ii.icon = bigX_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Terrain Painter";

eloffset_y += 48;

ii = gui_add_button(0,0,"",structure_placer_toggle,false);
ii.width = 32;
ii.height = 32;
ii.icon = structure_placer_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Structure Placer";

eloffset_y += 48;

ii = gui_add_button(0,0,"",empty_script,false);
ii.width = 32;
ii.height = 32;
ii.icon = bigX_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Zoning Tool";

eloffset_y += 48;

ii = gui_add_button(0,0,"",empty_script,false);
ii.width = 32;
ii.height = 32;
ii.icon = bigX_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Background Tool";

eloffset_y += 48;

ii = gui_add_button(0,0,"",empty_script,false);
ii.width = 32;
ii.height = 32;
ii.icon = bigX_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Wire/Link Tool";

eloffset_y += 48;

ii = gui_add_button(0,0,"",empty_script,false);
ii.width = 32;
ii.height = 32;
ii.icon = bigX_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Phenomena Tool";

eloffset_y += 48;



