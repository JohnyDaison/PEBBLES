/// @description  CREATE THE SURFACE, LIGHTS AND DISPLAY
if (self.object_index != editor_camera) {
    update_display();

    self.surface_width = view_get_wport(self.view);
    self.surface_height = view_get_hport(self.view);
    //my_console_log("CAMERA " + string(view) + " SURFACE: " + string(surface_width) + "x" + string(surface_height));

    self.view_surface = surface_create(self.surface_width, self.surface_height);
    view_set_surface_id(self.view, self.view_surface);

    self.bg_light = instance_create(0, 0, background_light_obj);
    self.bg_light.my_camera = self.id;

    self.main_light = instance_create(0, 0, main_light_obj);
    self.main_light.my_camera = self.id;

    var my_display = instance_create(0, 0, player_display_obj);
    my_display.my_camera = self.id;
    my_display.depth -= self.view;

    self.camera_ready = true;
}
