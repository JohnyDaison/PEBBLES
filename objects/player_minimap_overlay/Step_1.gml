action_inherited();
if(!self.ready)
{
    self.width = singleton_obj.current_width/7;
    if(instance_exists(place_obj)) {
        self.height = self.width*(place_obj.height/place_obj.width);
    }
    else
    {
        self.height = self.width*(room_height/room_width);
    }
    
    if(instance_exists(my_player) && instance_exists(my_guy) && view_enabled)
    {
        my_camera = my_player.my_camera;
        if(instance_exists(my_camera))
        {            
            offset_set = false;
            if(__view_get( e__VW.Visible, my_camera.view ))
            {
                self.view_x_offset = __view_get( e__VW.XPort, my_camera.view );
                self.view_y_offset = __view_get( e__VW.YPort, my_camera.view );
                offset_set = true;
            }
            if(!offset_set)
            {
                  self.view_x_offset = __view_get( e__VW.XPort, 0 ) + (__view_get( e__VW.WPort, 0 )/2)*(my_camera.view-1);
                  self.view_y_offset = __view_get( e__VW.YPort, 0 );
            }
            
            x = __view_get( e__VW.WPort, my_camera.view )/2 - width/2 + self.view_x_offset;
            y = my_camera.border_width * 3 + self.view_y_offset;
            
            // MINIMAP AREA
            minimap_left = x + map_margin;
            minimap_top = y + map_margin;
            minimap_right = x + width - map_margin - 1;
            minimap_bottom = y + height - map_margin - 1;
            
            minimap_width = minimap_right - minimap_left;
            minimap_height = minimap_bottom - minimap_top;
            
            minimap_view_width = floor(__view_get( e__VW.WView, my_camera.view )/32)*mini_block_size;
            minimap_view_height = floor(__view_get( e__VW.HView, my_camera.view )/32)*mini_block_size;
            
            //minimap_view_center_x = minimap_left + floor(minimap_width/2);
            //minimap_view_center_y = minimap_top + floor(minimap_height/2);
            
            minimap_view_left = minimap_left + floor(minimap_width/2 - minimap_view_width/2);
            minimap_view_top = minimap_top + floor(minimap_height/2 - minimap_view_height/2);
            minimap_view_right = minimap_view_left + minimap_view_width;
            minimap_view_bottom = minimap_view_top + minimap_view_height;
            
            self.ready = true;
        }
    }
}

