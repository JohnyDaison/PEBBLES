event_inherited();

singleton_obj.display_updated = false;
update_display();

self.width = 560;
self.height = 608;
x = view_wport[0]/2 - width/2;
y = view_hport[0]/2 - height/2;
window_axis = view_wport[0]/2;
self.text = "Pause Menu";
self.draw_heading = false;
self.draw_bg_color = false;
self.draw_border = false;

menu_start = 128;

self.modal = true;

ii = instance_create(0,0,gui_label);
ii.text = DB.version_string;
ii.gui_parent = id;
ii.align = "left"
ii.draw_bg_color = false;
ii.rel_position = "absolute";
ds_list_add(self.gui_content,ii);

eloffset_x = window_axis;

ii = instance_create(window_axis,y+80,gui_big_text);
ii.text = "·P·E·B·B·L·E·S·";
ii.width = 2000;
ii.bg_color = c_black;
ii.bg_alpha = 0.9;
ii.gui_parent = id;
ii.rel_position = "absolute";
ds_list_add(self.gui_content,ii);

eloffset_y = menu_start;

dist = 48;

var i=1, restart_str, finish_str;

if(gamemode_obj.object_index == match_obj)
{
    restart_str = "Restart match"
    finish_str = "End match";
}

if(gamemode_obj.object_index == campaign_obj)
{
    restart_str = "Restart level"
    finish_str = "Return to Play menu";
}

gui_add_button(0,y+dist*i++, "Resume game", resume_game);

gui_add_button(0,y+dist*i++, restart_str, pause_menu_restart);

gui_add_button(0,y+dist*i++, finish_str, match_force_finish);

gui_add_button(0,y+dist*i++, "Exit game", exit_game);

// ELEPHANT
if(!instance_exists(menu_elephant_obj))
{
    instance_create(x,y, menu_elephant_obj);
}