window_axis = x+self.width/2;
// FIRST LINE

eloffset_x = x + spacing;
eloffset_y = y + spacing;
left_offset = eloffset_x;

eloffset_x += 96;
eloffset_y += 12;

ii = gui_add_text_input(0,0,"(Enter name here)");
ii.width = 192;
ii.height = 24;
ii.font = small_font;
ii.visible = true;
ii.tooltip = "Name";
placename_input = ii;

eloffset_x += 144 + spacing;

ii = gui_add_button(0,0,"Save Name",place_rename_script,false);
ii.width = 96;
ii.height = 24;
ii.font = small_font;
ii.visible = true;
ii.tooltip = "Save Name";


elem_width = 128 + 3*spacing;
eloffset_x = x + width - (elem_width/2+1.5*spacing);

ii = gui_add_label(0,0,"32x32");
ii.width = elem_width;
ii.height = 24;
ii.font = label_font;
ii.visible = true;
ii.tooltip = "Place Size";
placesize_label = ii;

// SECOND LINE

eloffset_x = left_offset +16;
eloffset_y += 28 + spacing;

ii = gui_add_button(0,0,"",editor_exit,false);
ii.width = 32;
ii.height = 32;
ii.icon = exit_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Exit";

eloffset_x += 32 + spacing;

ii = gui_add_button(0,0,"",grid_drawer_toggle,false);
ii.width = 32;
ii.height = 32;
ii.icon = grid_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Toggle Grid";

eloffset_x += 32 + spacing;

ii = gui_add_button(0,0,"",place_tool_toggle,false);
ii.width = 32;
ii.height = 32;
ii.icon = place_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Show Place Tool";

eloffset_x += 32 + spacing;

ii = gui_add_button(0,0,"",selection_tool_onup,false);
ii.width = 32;
ii.height = 32;
ii.icon = select_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Select";

eloffset_x += 32 + spacing;

ii = gui_add_button(0,0,"",empty_script,false);
ii.width = 32;
ii.height = 32;
ii.icon = drag_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Drag ??!!";

eloffset_x += 32 + spacing;

ii = gui_add_button(0,0,"",empty_script,false);
ii.width = 32;
ii.height = 32;
ii.icon = cut_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Cut";

eloffset_x += 32 + spacing;

ii = gui_add_button(0,0,"",empty_script,false);
ii.width = 32;
ii.height = 32;
ii.icon = copy_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Copy";

eloffset_x += 32 + spacing;

ii = gui_add_button(0,0,"",empty_script,false);
ii.width = 32;
ii.height = 32;
ii.icon = paste_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Paste";

eloffset_x += 32 + spacing;

eloffset_x += 3*(32 + spacing);

eloffset_x += 24;
 
ii = gui_add_button(0,0,"",test_level_script,false);
ii.width = 64+spacing;
ii.height = 32;
ii.icon = test_icon;
ii.show_icon = true;
ii.center_icon = true;
ii.visible = true;
ii.tooltip = "Test";

// THIRD LINE

eloffset_x = left_offset+16;
eloffset_y += 32 + spacing;

ii = gui_add_button(0,0,"",new_place_onup,false);
ii.width = 32;
ii.height = 32;
ii.icon = new_file_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "New Place";

eloffset_x += 32 + spacing;

ii = gui_add_button(0,0,"",load_place_onup,false);
ii.width = 32;
ii.height = 32;
ii.icon = load_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Load Place";

eloffset_x += 32 + spacing;

ii = gui_add_button(0,0,"",save_place_onup,false);
ii.width = 32;
ii.height = 32;
ii.icon = save_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Save Place";

eloffset_x += 32 + spacing;

ii = gui_add_button(0,0,"",pan_tool_onup,false);
ii.width = 32;
ii.height = 32;
ii.icon = hand_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Pan Tool";

eloffset_x += 32 + spacing;

ii = gui_add_button(0,0,"",terrain_placer_toggle,false);
ii.width = 32;
ii.height = 32;
ii.icon = terrain_placer_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Terrain Placer";

eloffset_x += 32 + spacing;

ii = gui_add_button(0,0,"",tool_reset_onup,false);
ii.width = 32;
ii.height = 32;
ii.icon = cursor_arrow;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Default Tool";

eloffset_x += 32 + spacing;

ii = gui_add_button(0,0,"",minimap_toolbar_toggle,false);
ii.width = 32;
ii.height = 32;
ii.icon = minimap_icon;
ii.show_icon = true;
ii.visible = true;
ii.tooltip = "Minimap";

eloffset_x += 32 + spacing;

eloffset_x += 4*(32 + spacing) + 24;

ii = gui_add_label(0,0,"Gamepads");
ii.width = 128 + 3*spacing;
ii.height = 32;
ii.visible = true;

eloffset_x -= 32 + spacing + 20;

ii = gui_add_checkbox(0,0);
ii.visible = true;
ii.depth -= 2;
gamepad1_checkbox = ii;

eloffset_x += 3*(32 + spacing);

ii = gui_add_checkbox(0,0);
ii.visible = true;
ii.depth -= 2;
gamepad2_checkbox = ii;

height = eloffset_y + 16 + spacing;

placename_input.text = place_obj.name;    
placename_input.was_active = true;

placesize_label.text = string(place_obj.width/32)+"x"+string(place_obj.height/32);
