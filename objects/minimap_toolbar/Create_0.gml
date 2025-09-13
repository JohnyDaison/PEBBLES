event_inherited();

self.width = singleton_obj.current_width / 7;
self.height = self.width;
self.text = "";
self.map_margin = 7;
self.heading_offset = 0;

self.font = label_font;
self.bg_alpha = 1.5;
self.border_alpha = 1.5;

//make_color_rgb(0,29,43);
//bg_color = background_color;
mini_block_size = 3;

minimap_left = x + map_margin;
minimap_top = y + map_margin;
minimap_right = x + width - map_margin - 1;
minimap_bottom = y + height - map_margin - 1;

minimap_width = minimap_right - minimap_left;
minimap_height = minimap_bottom - minimap_top;

myViewCamera = view_get_camera(0);
var viewWidth = camera_get_view_width(myViewCamera);
var viewHeight = camera_get_view_height(myViewCamera);

minimap_view_width = floor(viewWidth / 32) * mini_block_size;
minimap_view_height = floor(viewHeight / 32) * mini_block_size;

minimap_view_left = minimap_left + floor(minimap_width / 2 - minimap_view_width / 2);
minimap_view_top = minimap_top + floor(minimap_height / 2 - minimap_view_height / 2);
minimap_view_right = minimap_view_left + minimap_view_width;
minimap_view_bottom = minimap_view_top + minimap_view_height;
