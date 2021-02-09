if(!gamemode_obj.limit_reached && instance_exists(my_guy) && sprite_index != noone && my_color != -1 && display_exhaustion_ratio > 0)
{
    if(my_guy != id && !object_is_ancestor(my_guy.object_index, turret_obj) && my_guy.my_player != gamemode_obj.environment)
    {
        var xx, yy, scale = 1;
        var camera = my_guy.my_player.my_camera;
        if(!instance_exists(camera) && main_camera_obj.on)
        {
            camera = main_camera_obj.id;
        }
        var camera_found = instance_exists(camera);
        
        if(!camera_found)
        {
            exit;   
        }
        
        // POSITION
        if(my_guy.object_index == cannon_base_obj)
        {
            scale = 0.6;
            xx = my_guy.gui_x;
            yy = my_guy.gui_y + 24;
        }
        else //if(object_is_ancestor(my_guy.object_index, guy_obj))
        {
            scale = camera.zoom_level;
            xx = floor((my_guy.x - __view_get( e__VW.XView, camera.view ))*camera.zoom_level + __view_get( e__VW.XPort, camera.view ));
            yy = floor((my_guy.y - __view_get( e__VW.YView, camera.view ))*camera.zoom_level + __view_get( e__VW.YPort, camera.view ));
        }
        
        bar_dist = (base_radius * 0.5 + 16) * scale;
        
        // SIZE
        var base_charge = max(charge_step, max_charge + overcharge) * display_exhaustion_ratio;
        
        var base_bar_width = scale*base_charge*60; //*color_exhaustion_ratio;
        var total_bar_width = base_bar_width;
        
        var left_border = floor(xx - total_bar_width/2);
        var right_border = ceil(xx + total_bar_width/2);
        var top_border = yy + bar_dist;
        var bottom_border = yy + bar_dist + bar_height;

        // COLOR
        var bg_color, border_color;
        
        if(my_color == g_black)
        {
            bg_color = light_bg_color;
            border_color = light_bg_color;
        }
        else if(my_color == g_white)
        {
            bg_color = dark_bg_color;
            border_color = dark_bg_color;
        }
        else
        {
            bg_color = dark_bg_color;
            border_color = light_bg_color;
        }
        
        // DRAW        
        draw_set_color(bg_color);
        draw_rectangle(left_border, top_border, right_border, bottom_border, false);
        
        draw_set_color(base_bar_color);
        draw_rectangle(left_border, top_border, left_border+floor((charge/base_charge)*(base_bar_width)), bottom_border,false);        
        
        draw_set_color(border_color);
        draw_rectangle(left_border, top_border, right_border, bottom_border, true);
        
        my_draw_set_font(label_font);
        //draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        //my_draw_text(left_border, bottom_border, string(chargerate));
        
        if(self.autofire)
        {
            draw_set_color(c_white);
            draw_set_halign(fa_center);
            my_draw_text(left_border + total_bar_width, bottom_border, "A");
        }        
    }
}
