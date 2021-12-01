if(!singleton_obj.paused && room != mainmenu && room != match_summary)
{
    game_set_speed(singleton_obj.game_speed, gamespeed_fps);
    
    if(!instance_exists(battlefeed))
        battlefeed = add_frame(battlefeed_overlay);
    if(!shown_welcome)
    {
        instance_create(0,0,screen_fade_obj);
        /*
        background_color = make_color_rgb(56,131,192);
        background_index[0] = medium_clouds_bg;
        background_index[1] = big_clouds_bg;
        */
        __background_set_colour( make_color_rgb(0,0,12 ));
        __background_set( e__BG.Index, 0, stars1_bg );
        __background_set( e__BG.Index, 1, hexgrid_big_bg );
        
        __background_set( e__BG.Stretch, 0, false );
        __background_set( e__BG.Stretch, 1, false );
        
        __background_set( e__BG.Visible, 0, true );
        __background_set( e__BG.Visible, 1, true );
        
        
        frame_manager.enable_focus_shift = false;
        
        add_frame(center_overlay);
        
        if(is_coop)
        {
            center_overlay.message = arena_name;
        }
        else
        {
            center_overlay.message = "WELCOME to "+arena_name+"!";
        }
        
        if(!is_campaign)
        {
            center_overlay.tip = DB.tips[|(irandom(ds_list_size(DB.tips)-1))];
            if(is_undefined(center_overlay.tip))
            {
               center_overlay.tip = ""; 
            }
        }
        shown_welcome = true;
        
        prespawn_delay = 90;
        /*
        pixelating_left = 0;
        pixelate_steps = 1;
        */
        alarm[0] = prespawn_delay;
        alarm[1] = -1;
        alarm[2] = -1;
        alarm[3] = -1;
        alarm[4] = -1;
        
        with(player_obj)
        {
            player_quests_clear(id);
        }
        
        with(place_controller_obj)
        {
            instance_destroy();
        }
        
        if(instance_exists(world) && world.current_place != noone && world.current_place.controller != noone)
        {
            instance_create(0,0, world.current_place.controller);
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
else
{
    game_set_speed(60, gamespeed_fps);
}
if(room == mainmenu || room == match_summary)
{
    frame_manager.enable_focus_shift = true;
}
