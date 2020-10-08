window_axis = x+self.width/2;

// TOP LINE

eloffset_x = window_axis;
eloffset_y = y+height/2;

ii = gui_add_int_input(0,0,1,-99,99);
ii.max_digits = 2;
ii.visible = true;
add_input = ii;

ii = gui_add_button(0,-40,"",add_cells,false);
ii.width = 32;
ii.height = 32;
ii.icon = add_arrow_up;
ii.show_icon = true;
ii.visible = true;
ii.add_dir = up;

ii = gui_add_button(0,40,"",add_cells,false);
ii.width = 32;
ii.height = 32;
ii.icon = add_arrow_down;
ii.show_icon = true;
ii.visible = true;
ii.add_dir = down;

ii = gui_add_button(-56,0,"",add_cells,false);
ii.width = 32;
ii.height = 32;
ii.icon = add_arrow_left;
ii.show_icon = true;
ii.visible = true;
ii.add_dir = left;

ii = gui_add_button(56,0,"",add_cells,false);
ii.width = 32;
ii.height = 32;
ii.icon = add_arrow_right;
ii.show_icon = true;
ii.visible = true;
ii.add_dir = right;



