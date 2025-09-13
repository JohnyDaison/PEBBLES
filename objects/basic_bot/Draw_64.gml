event_inherited();

if (my_player == gamemode_obj.environment || my_player.my_guy != id)
{
    with(camera_obj)
    {
        if (on)
        {
            var cam = id;
            var view_num = view;
            
            with(other)
            {
                var viewCamera = view_get_camera(view_num);
                var viewX = camera_get_view_x(viewCamera);
                var viewY = camera_get_view_y(viewCamera);
                var viewWidth = camera_get_view_width(viewCamera);
                var viewHeight = camera_get_view_height(viewCamera);
                
                if (x > viewX && x < (viewX + viewWidth)
                 && y > viewY && y < (viewY + viewHeight))
                {
                    var xx = floor( (x - viewX) * cam.zoom_level + view_get_xport( view_num ) );
                    var yy = floor( (y - viewY) * cam.zoom_level + view_get_yport( view_num ) );
                    
                    var base_bar_width = floor(hp_bar_width * cam.zoom_level);
                    
                    var left_border = floor(xx - base_bar_width / 2);
                    var right_border = floor(xx + base_bar_width / 2);
                    var top_border = floor(yy + bar_dist);
                    var bottom_border = floor(yy + bar_dist + bar_height);
                    
                    if (damage > min_damage)
                    {
                        draw_set_color(c_dkgray);
                        draw_rectangle(left_border, top_border, right_border, bottom_border, false);
                        
                        var bar_width = floor((1 - damage / hp) * base_bar_width);
                        draw_set_color(health_bar_color);
                        draw_rectangle(left_border, top_border, left_border + bar_width, bottom_border, false);
                        
                        draw_set_color(c_ltgray);
                        draw_rectangle(left_border, top_border, right_border, bottom_border, true);
                    }
                }
            }
        }
    }
}
