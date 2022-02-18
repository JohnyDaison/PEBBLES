/// @description  CREATE THE SURFACE, LIGHTS AND DISPLAY
if(object_index != editor_camera)
{
    update_display();
    
    surface_width = view_get_wport(view);
    surface_height = view_get_hport(view);
    //my_console_log("CAMERA " + string(view) + " SURFACE: " + string(surface_width) + "x" + string(surface_height));
    
    self.view_surface = surface_create(surface_width, surface_height);
    view_set_surface_id(view, self.view_surface);
    
    bg_light = instance_create(0, 0, background_light_obj);
    bg_light.my_camera = id;
    
    main_light = instance_create(0, 0, main_light_obj);
    main_light.my_camera = id;
    
    //if(object_index == player_camera_obj)

    my_display = instance_create(0, 0, player_display_obj);
    my_display.my_camera = id;
    my_display.depth -= view;
    
    camera_ready = true;
}
