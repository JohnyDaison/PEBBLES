if(instance_exists(my_camera))
{
    if(my_camera.on)
    {
        // FIX FOR GUI
        if(!main_camera_obj.gui_fix_applied)
        {
            with(non_terrain_obj)
            {
                //my_console_log("GUI FIX");
                if(!invisible && !visible)
                {
                    visible = true;
                    //my_console_log("GUI FIX WHAT");
                }
            }
            main_camera_obj.gui_fix_applied = true;
        }
        
        if(surface_exists(my_camera.view_surface))
        {
            if(my_camera.death_cover_show)
            {
                shader_set(shd_greyscale);
            }
            
            draw_set_alpha(1);
            
            var surface_x = __view_get( e__VW.XPort, my_camera.view ) + x;
            var surface_y = __view_get( e__VW.YPort, my_camera.view ) + y;
            //my_console_log("DISPLAY " + string(my_camera.view) + " SURFACE: " + string(surface_x) + ";" + string(surface_y));
            
            draw_surface(my_camera.view_surface, surface_x, surface_y);
            
            
            if(my_camera.death_cover_show)
            {
                shader_reset();
            }
        }
    }
}
