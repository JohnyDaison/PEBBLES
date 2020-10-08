event_inherited();

update_display();

self.width = 480;
self.height = 704;

x = view_wport[0]/2 - width/2;
y = view_hport[0]/2 - height/2;
/*
x = room_width/2 - width/2;
y = room_height/2 - height/2;
*/

window_axis = x+self.width/2;
self.text = "Main Menu";
self.draw_heading = false;
self.draw_bg_color = false;
self.draw_border = false;

menu_start = 224;

self.modal = true;

ii = instance_create(0,0,gui_label);
ii.text = DB.version_string;
ii.gui_parent = id;
ii.align = "left"
ii.draw_bg_color = false;
ii.rel_position = "absolute";
ds_list_add(self.gui_content,ii);

eloffset_x = window_axis;

ii = gui_child_init(window_axis,80,gui_big_text);
ii.text = "·P·E·B·B·L·E·S·";
ii.width = 2000;
ii.bg_color = c_black;
ii.bg_alpha = 0.9;
ii.gui_parent = id;
ds_list_add(self.gui_content,ii);

eloffset_y = menu_start;

var dist = 48;

var i=1, ii;

ii = gui_add_button(0,y+dist*i++, "Play", goto_playmenu);
ii.base_bg_color = merge_color(c_lime, c_black, 0.2);
ii.base_text_color = c_white;

gui_add_button(0,y+dist*i++, "Settings", goto_graphic_settings);

gui_add_button(0,y+dist*i++, "Controls", goto_control_settings);

//inst = gui_add_button(0,y+dist*i++, "Level Editor", goto_level_editor);
//inst.enabled = false;

gui_add_button(0,y+dist*i++, "Exit", exit_game);


// ELEPHANT
if(!instance_exists(menu_elephant_obj))
{
    instance_create(x,y, menu_elephant_obj);
}

