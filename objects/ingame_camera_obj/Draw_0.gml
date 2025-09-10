if (instance_exists(source_cam)) {
    if (view_current == source_cam.view) {
        if (!surface_exists(surface)) {
            width = floor(ingame_screen_obj.width / zoom_level);
            height = floor(ingame_screen_obj.height / zoom_level);
            
            surface = surface_create(width, height);
        }
        
        if (surface_exists(surface)) {
            if (surface_exists(source_cam.view_surface))
            {
                var w = floor(width * source_cam.zoom_level);
                var h = floor(height * source_cam.zoom_level);
                
                var viewCamera = view_get_camera(view_current);
                var view_x = camera_get_view_x(viewCamera);
                var view_y = camera_get_view_y(viewCamera);

                var x1 = floor((floor(x) - view_x) * source_cam.zoom_level) - floor(w/2);
                var y1 = floor((floor(y) - view_y) * source_cam.zoom_level) - floor(h/2);
                
                surface_resize(surface, w, h);
                surface_copy_part(surface, 0, 0, source_cam.view_surface, x1, y1, w, h)
            }
        }
    }
}

event_inherited();
