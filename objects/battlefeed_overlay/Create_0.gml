event_inherited();

self.width = 576;
self.height = 0;
self.bg_alpha = 0.9;
self.bg_color = c_dkgray;
self.item_bg_alpha = 0.75;
self.msg_list = ds_list_create();
self.msg_max = 3;
self.msg_height = 64;
self.msg_font = text_popup_font;
self.msg_count = 0;
self.last_msg_count = 0;
self.fade_ratio = 0;
self.fade_speed = 0.004;
self.content_spacing = 9;
self.corner_radius = 18;
self.padding_size = 3;
self.my_player = gamemode_obj.environment;
