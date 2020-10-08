medal_label = gui_add_label(x+8, y+8, "");
medal_label.centered = true;
medal_label.width = 31;
medal_label.height = 31;
medal_label.draw_bg_color = false;
medal_label.show_icon = true;

time = instance_create(x+8,y+8,gui_time);
time.centered = true;
time.gui_parent = id;
time.depth = depth-1;
ds_list_add(self.gui_content,time);
