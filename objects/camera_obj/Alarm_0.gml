/// @description  CREATE THE SURFACE, LIGHTS AND DISPLAY
if(object_index != editor_camera)
{
    update_display();
    
    var surface_width = __view_get( e__VW.WPort, view );
    var surface_height = __view_get( e__VW.HPort, view );
    //my_console_log("CAMERA " + string(view) + " SURFACE: " + string(surface_width) + "x" + string(surface_height));
    
    self.view_surface = surface_create(surface_width, surface_height);
    __view_set( e__VW.SurfaceID, view, self.view_surface );
    
    i = instance_create(0,0,background_light_obj);
    i.my_camera = id;
    
    i = instance_create(0,0,main_light_obj);
    i.my_camera = id;
    
    //if(object_index == player_camera_obj)

    my_display = instance_create(0,0,player_display_obj);
    my_display.my_camera = id;
    my_display.depth -= view;
}


