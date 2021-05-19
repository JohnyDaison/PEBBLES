self.color = c_white;
self.text_color = c_white;
self.bg_color = c_gray;
self.border_color = c_dkgray;
self.base_border_color = merge_colour(c_purple, c_white, 0.7);
self.disabled_border_color = merge_colour(c_gray, c_black, 0.7);
self.base_bg_color = merge_colour(c_gray, c_white, 0.85);
self.base_text_color = c_white;
self.enabled_icon_color = c_white;

self.highlight_color = c_purple;
self.highlight_text_color = merge_colour(c_silver, c_white, 0.5);
self.highlighted_icon_color = merge_colour(c_silver, c_white, 0.5);

self.select_color = merge_color(c_lime, c_black, 0.2);
self.select_text_color = c_white;
self.depressed_color = c_yellow;
self.depressed_text_color = c_black;

self.disabled_color = c_dkgray;
self.disabled_icon_color = c_gray;


self.draw_border = false;
self.round_corners = false;
self.draw_bg_color = false;
self.border_alpha = 1;
self.bg_alpha = 1;
self.center_icon = false;
self.hidden = false;

self.width = 0;
self.height = 0;

self.parent_frame = noone;
self.gui_parent = noone;
self.gui_content = ds_list_create();
self.eloffset_x = 0;
self.eloffset_y = 0;

self.want_focus = false;
self.focused = false;
self.had_focus = false;
self.mouse_over = false;
self.content_focused = -1;
self.focused_child = noone;
self.active = false;
self.was_active = false;
self.modal = false;

self.repeat_wait = 15;
self.repeat_rate = 8;

self.enabled = true;
self.depressed = false;
self.depressed_dir = 1;
self.sticky = false;
self.repeater = false;
self.text = "";
self.autoclick_text = "";
self.icon = noone;
self.icon_alpha = 1;
self.image_speed = 0;
self.show_icon = false;
self.tooltip = "";
self.rel_position = "relative";

self.shift_stop_dir = -1;
self.left_hand_object = noone;
self.right_hand_object = noone;

