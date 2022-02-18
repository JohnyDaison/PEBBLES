/// @description  BEFORE VIEW
if(view > -1 && view_enabled)
{
    if(on && view_get_visible(view))
    {
        // RE-CREATE VIEW SURFACE
        if (camera_ready && !surface_exists(view_surface)) {
            view_surface = surface_create(surface_width, surface_height);
            view_set_surface_id(view, view_surface);
        }
        
        // DARKNESS
        if (view_current == view && darkness_alpha > 0) {
            var camera = view_get_camera(view);
            light_x_offset = -camera_get_view_x(camera);
            light_y_offset = -camera_get_view_y(camera);
            surface_width = camera_get_view_width(camera);
            surface_height = camera_get_view_height(camera);
            light_size_coef = darkness_light_size_coef;
            
            if (!surface_exists(darkness_surface)) {
                darkness_surface = surface_create(surface_width, surface_height);
            } else {
                surface_resize(darkness_surface, surface_width, surface_height);
            }
            
            // draw darkness surface
            surface_set_target(darkness_surface);
            
            draw_set_color(merge_color(c_white, c_black, darkness_alpha));
            draw_set_alpha(1);
            draw_rectangle(0, 0, surface_width, surface_height, false);
            
            with (bg_light) {
                event_perform(ev_draw, 0);
            }
            with (main_light) {
                event_perform(ev_draw, 0);
            }
            
            surface_reset_target();
            
            // draw darkness to view surface
            draw_set_blend_mode_ext(bm_dest_color, bm_zero);
            
            draw_surface_ext(darkness_surface, -light_x_offset, -light_y_offset, 1, 1, 0, c_white, 1);
            
            draw_set_blend_mode(bm_normal);
        }
        
        light_x_offset = 0;
        light_y_offset = 0;
        light_size_coef = 1;
        
        // CAMERA BEFORE VIEW
        if (view > 1 && view_current == view-1) {
            camera_before_view();
        }
    }
}
