function update_display() {
    with(singleton_obj)
    {   
        var is_menu = !instance_exists(gamemode_obj) || room == pausemenu || room == match_summary;
        
        if(aa_level != aa_level_set || vsync != vsync_set)
        {
            display_reset(aa_level, vsync);
            aa_level_set = aa_level;
            vsync_set = vsync;
            display_updated = false;
        }
        
        if(is_menu && interpolate_menu != interpolate_set)
        {
            gpu_set_texfilter(interpolate_menu);
            interpolate_set = interpolate_menu;
            display_updated = false;
        }
        
        if(!is_menu && interpolate_game != interpolate_set)
        {
            gpu_set_texfilter(interpolate_game);
            interpolate_set = interpolate_game;
            display_updated = false;
        }
    
        if(fullscreen)
        {
            if(current_width != fullscreen_width || current_height != fullscreen_height)
            {
                //window_set_fullscreen(false);
                fullscreen_set = false;
                display_updated = false;
            }
        
            current_width = fullscreen_width;
            current_height = fullscreen_height;
        } 
        else
        {
            if(current_width != windowed_width || current_height != windowed_height)
            {
                //window_set_fullscreen(true);
                fullscreen_set = true;
                display_updated = false;
            }
        
            current_width = windowed_width; // fullscreen_width;
            current_height = windowed_height; // fullscreen_height;
        }
    
        if(!display_updated)
        {
            window_set_size(current_width,current_height);
            display_set_gui_size(current_width,current_height);

            if(singleton_obj.scale_up_gui && is_menu)
            {
                display_set_gui_size(1280, 720);
            }
        
            if(display_get_gui_width() > display_get_width() || display_get_gui_height() > display_get_height())
            {
                display_set_gui_maximize(1, 1, 0, 0);
            
            }

            if(alarm[3] == -1)
            {
                alarm[3] = 1;
            }
        }
    
        if(fullscreen)
        {
            if(!fullscreen_set)
            {
                window_set_fullscreen(true);
                fullscreen_set = true;
                display_updated = false;
            }
        }
        else
        {
            if(fullscreen_set)
            {
                window_set_fullscreen(false);
                //window_center();
                fullscreen_set = false;
                display_updated = false;
            }
        }
    
        //my_console_log("UD current: " + string(current_width) + "x" + string(current_height));
                
        player_port_width = current_width/2;
        player_port_height = current_height;
    
        //my_console_log("UD player_port: " + string(player_port_width) + "x" + string(player_port_height));
    
        if(instance_exists(gamemode_obj))
        {
            if(gamemode_obj.player_count > 2 && gamemode_obj.human_player_count > 2)
            {
                player_port_height /= 2;   
            }
        }
    
        player_view_width = player_port_width;
        player_view_height = player_port_height;
    
        //my_console_log("UD player_view: " + string(player_view_width) + "x" + string(player_view_height));
    }

    if(object_is_ancestor(object_index,camera_obj) || object_index == editor_camera)
    {
        __view_set( e__VW.HBorder, view, 0 );
        __view_set( e__VW.VBorder, view, 0 );
        __view_set( e__VW.HSpeed, view, -1 );
        __view_set( e__VW.VSpeed, view, -1 );

        var zoom = zoom_level;
    
        if(only_cam)
        {
            __view_set( e__VW.WView, view, singleton_obj.current_width/zoom );
            __view_set( e__VW.HView, view, singleton_obj.current_height/zoom );
            __view_set( e__VW.WPort, view, singleton_obj.current_width );
            __view_set( e__VW.HPort, view, singleton_obj.current_height );
            __view_set( e__VW.XPort, view, 0 );
            __view_set( e__VW.YPort, view, 0 );
        }
        else
        {       
            __view_set( e__VW.WView, view, singleton_obj.player_view_width/zoom );
            __view_set( e__VW.HView, view, singleton_obj.player_view_height/zoom );
            __view_set( e__VW.WPort, view, singleton_obj.player_port_width );
            __view_set( e__VW.HPort, view, singleton_obj.player_port_height );
            __view_set( e__VW.XPort, view, 0+singleton_obj.player_port_width*((view-1) mod 2) );
            __view_set( e__VW.YPort, view, 0+singleton_obj.player_port_height*(floor((view-1)/2)) );        
        }
    }
    else
    {
    
        view_wport[0] = singleton_obj.current_width;
        view_hport[0] = singleton_obj.current_height;
    
        if(singleton_obj.scale_up_gui)
        {
            if(!instance_exists(gamemode_obj) || room == pausemenu || room == match_summary)
            {
                view_wport[0] = 1280;
                view_hport[0] = 720;
            }
        }
    
    }



}
