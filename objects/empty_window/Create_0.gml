event_inherited();

self.font = window_font;
self.draw_border = false;
self.draw_bg_color = true;
self.border_color = merge_color(c_dkgray,c_black,0.5);
self.border_alpha = 0.3;
self.bg_alpha = 0.75;
self.bg_color = merge_color(c_green,c_black,0.95);
//self.unique = false; //e.g. whether the window is a singleton NOT DONE

self.view_x_offset = 0;
self.view_y_offset = 0;
self.offset_x = 0;
self.offset_y = 0;
self.window_axis = 0;
self.keep_inside = true;

self.shifted = false;
self.draggable = false;
self.has_active_elem = false;

alarm[0] = 3;

