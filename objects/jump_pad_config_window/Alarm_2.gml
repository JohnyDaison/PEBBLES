eloffset_x = x + 64;
eloffset_y = y + 24;

i = gui_add_label(0,0,"Max power");
i.width = 112;

eloffset_x += 32 + 64;
input = gui_add_int_input(0,0,my_pad.max_power,0,DB.max_jump_pad_power);

eloffset_x += 32 + 48;
but = gui_add_button(0,0,"OK",editor_jump_pad_update,false);
but.width = 64;


