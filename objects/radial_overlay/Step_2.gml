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
            var camera = view_get_camera(my_camera.view);
            
            if (view_get_visible(my_camera.view) && camera_get_view_target(camera) == my_camera) {
                self.view_x_offset = view_get_xport( my_camera.view );
                self.view_y_offset = view_get_yport( my_camera.view );
                x = self.view_x_offset + floor(view_get_wport( my_camera.view )/2);
                y = self.view_y_offset + floor(view_get_hport( my_camera.view )/2);
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
