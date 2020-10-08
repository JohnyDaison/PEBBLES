event_inherited();

if(my_player == gamemode_obj.environment)
{
    with(camera_obj)
    {
        if(on)
        {
            var cam = id;
            var view_num = view;
            
            with(other)
            {
                if(x > __view_get( e__VW.XView, view_num ) && x < (__view_get( e__VW.XView, view_num ) + __view_get( e__VW.WView, view_num ))
                && y > __view_get( e__VW.YView, view_num ) && y < (__view_get( e__VW.YView, view_num ) + __view_get( e__VW.HView, view_num )))
                {
                    var xx = (x - __view_get( e__VW.XView, view_num ))*cam.zoom_level + __view_get( e__VW.XPort, view_num );
                    var yy = (y - __view_get( e__VW.YView, view_num ))*cam.zoom_level + __view_get( e__VW.YPort, view_num );
                    
                    left_border = floor(xx - hp_bar_width/2);
                    right_border = ceil(xx + hp_bar_width/2);
                    top_border = yy + bar_dist;
                    bottom_border = yy + bar_dist + bar_height;
                    
                    if(damage > min_damage)
                    {
                        draw_set_color(c_dkgray);
                        draw_rectangle(left_border, top_border, right_border, bottom_border, false);
                        
                        draw_set_color(health_bar_color);
                        draw_rectangle(left_border, top_border, left_border+floor((1-(damage/hp)) * hp_bar_width), bottom_border,false);
                        
                        draw_set_color(c_ltgray);
                        draw_rectangle(left_border-1, top_border-1, right_border, bottom_border,true);
                    }
                }
            }
        }
    }
}

