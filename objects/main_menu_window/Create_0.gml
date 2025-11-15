event_inherited();

update_display();

self.width = 480;
self.height = 704;

self.window_axis = display_get_gui_width() / 2;
self.x = self.window_axis - self.width / 2;
self.y = display_get_gui_height() / 2 - self.height / 2;
/*
x = room_width/2 - width/2;
y = room_height/2 - height/2;
*/

self.text = "Main Menu";
self.draw_heading = false;
self.draw_bg_color = false;
self.draw_border = false;

self.menu_start = 224;

self.modal = true;

var ii = instance_create(0, 0, gui_label);
ii.text = DB.version_string;
ii.gui_parent = self.id;
ii.align = "left"
ii.draw_bg_color = false;
ii.rel_position = "absolute";
ds_list_add(self.gui_content, ii);

self.eloffset_x = self.window_axis;

ii = gui_child_init(self.window_axis, 80, gui_big_text);
ii.text = "·P·E·B·B·L·E·S·";
ii.width = 2000;
ii.bg_color = c_black;
ii.bg_alpha = 0.9;
ii.gui_parent = self.id;

self.eloffset_y = self.menu_start;

var dist = 48;

var i = 1;

ii = gui_add_button(0, self.y + dist * i++, "Play", goto_playmenu);
ii.base_bg_color = self.select_color;

gui_add_button(0, self.y + dist * i++, "Settings", goto_graphic_settings);

gui_add_button(0, self.y + dist * i++, "Controls", goto_control_settings);

//inst = gui_add_button(0,y+dist*i++, "Level Editor", goto_level_editor);
//inst.enabled = false;

gui_add_button(0, self.y + dist * i++, "Exit", exit_game);


// ELEPHANT
if (!instance_exists(menu_elephant_obj)) {
    instance_create(self.x, self.y, menu_elephant_obj);
}
