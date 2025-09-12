event_inherited();

///@description INIT

if (!ready) {
    if (instance_exists(my_player) && instance_exists(my_guy) && view_enabled) {
        my_camera = my_player.my_camera;
        
        if (instance_exists(my_camera)) {
            var offset_set = false;
            
            if (view_get_visible( my_camera.view )) {
                self.view_x_offset = view_get_xport( my_camera.view );
                self.view_y_offset = view_get_yport( my_camera.view );
                //height = 0.04*view_hport[my_camera.view];
                offset_set = true;
            }
            
            if (!offset_set) {
                self.view_x_offset = view_get_xport( 0 ) + (view_get_wport( 0 )/2)*(my_camera.view-1);
                self.view_y_offset = view_get_yport( 0 );
                //height = 0.04*view_hport[0];
            }
            
           ready = true;
        }
    }
}
