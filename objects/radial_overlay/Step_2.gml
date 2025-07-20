event_inherited();

/// @description INIT, GUI RADIUS
if(!ready)
{
    if(instance_exists(my_player) && instance_exists(my_guy) && view_enabled)
    {
        my_camera = my_player.my_camera;
        if(instance_exists(my_camera))
        {
            var offset_set = false;
            if(__view_get( e__VW.Visible, my_camera.view ) && __view_get( e__VW.Object, my_camera.view ) = my_camera)
            {
                self.view_x_offset = __view_get( e__VW.XPort, my_camera.view );
                self.view_y_offset = __view_get( e__VW.YPort, my_camera.view );
                x = self.view_x_offset + floor(__view_get( e__VW.WPort, my_camera.view )/2);
                y = self.view_y_offset + floor(__view_get( e__VW.HPort, my_camera.view )/2);
                //height = 0.04*view_hport[my_camera.view];
                offset_set = true;
                ready = true;
            }
        }
    }
}

// gui radius
gui_radius = base_gui_radius;
    
if(singleton_obj.player_port_height < singleton_obj.current_height)
{
    gui_radius = small_gui_radius;
}
