event_inherited();

///@description INIT

if (!ready) {
    if (instance_exists(my_player) && instance_exists(my_guy) && view_enabled) {
        my_camera = my_player.my_camera;
        
        if (instance_exists(my_camera)) {
            var offset_set = false;
            
            if (__view_get( e__VW.Visible, my_camera.view )) {
                self.view_x_offset = __view_get( e__VW.XPort, my_camera.view );
                self.view_y_offset = __view_get( e__VW.YPort, my_camera.view );
                //height = 0.04*view_hport[my_camera.view];
                offset_set = true;
            }
            
            if (!offset_set) {
                self.view_x_offset = __view_get( e__VW.XPort, 0 ) + (__view_get( e__VW.WPort, 0 )/2)*(my_camera.view-1);
                self.view_y_offset = __view_get( e__VW.YPort, 0 );
                //height = 0.04*view_hport[0];
            }
            
           ready = true;
        }
    }
}
