if (!singleton_obj.paused && room != mainmenu && room != match_summary) {
    game_set_speed(singleton_obj.game_speed, gamespeed_fps);

    if (!instance_exists(self.battlefeed)) {
        self.battlefeed = add_frame(battlefeed_overlay);
    }

    if (!self.shown_welcome) {
        instance_create(0, 0, screen_fade_obj);
        /*
        background_color = make_color_rgb(56,131,192);
        background_index[0] = medium_clouds_bg;
        background_index[1] = big_clouds_bg;
        */

        var bgColor = make_color_rgb(0, 0, 12);
        singleton_obj.changeBackgroundColor(bgColor);

        var bgLayer0 = __background_get_element(0)[0];
        var bgLayer1 = __background_get_element(1)[0];

        layer_background_sprite(bgLayer0, stars1_bg);
        layer_background_sprite(bgLayer1, hexgrid_big_bg);

        layer_background_stretch(bgLayer0, false);
        layer_background_stretch(bgLayer1, false);

        layer_background_visible(bgLayer0, true);
        layer_background_visible(bgLayer1, true);


        frame_manager.enable_focus_shift = false;

        add_frame(center_overlay);
        var centerOverlay = center_overlay.id;

        if (self.is_coop) {
            centerOverlay.message = self.arena_name;
        }
        else {
            centerOverlay.message = "WELCOME to " + self.arena_name + "!";
        }

        if (!self.is_campaign) {
            var tipIndex = irandom(ds_list_size(DB.tips) - 1);
            centerOverlay.tip = DB.tips[| tipIndex];

            if (is_undefined(centerOverlay.tip)) {
                centerOverlay.tip = "";
            }
        }

        self.shown_welcome = true;

        self.prespawn_delay = 90;
        /*
        self.pixelating_left = 0;
        self.pixelate_steps = 1;
        */
        self.alarm[0] = self.prespawn_delay;
        self.alarm[1] = -1;
        self.alarm[2] = -1;
        self.alarm[3] = -1;
        self.alarm[4] = -1;

        with (player_obj) {
            player_quests_clear(self.id);
        }

        instance_destroy(place_controller_obj);

        if (instance_exists(self.world) && self.world.current_place != noone && self.world.current_place.controller != noone) {
            instance_create(0, 0, self.world.current_place.controller);
        }

        /*
        pixelate_time = prespawn_delay;
    
        pixelate_base = 45;
        pixels_y = pixelate_base;
        pixels_x = pixelate_base*display_get_gui_width()/display_get_gui_height();
        pixelate_steps = ceil(log2(display_get_gui_height()/pixelate_base));
        */
    }
}
else {
    game_set_speed(60, gamespeed_fps);
}

if (room == mainmenu || room == match_summary) {
    frame_manager.enable_focus_shift = true;
}
