if(draw_bar && !gamemode_obj.limit_reached && instance_exists(my_guy) && sprite_index != no_sprite && my_color != -1)
{
    if(my_guy != id && !(my_guy.object_index == crystal_obj && my_guy.my_player.my_base == my_guy.my_guy))
    {
        var camera, i, count = ds_map_size(main_camera_obj.cameras), xx, yy;
        
        for(i=1; i<=count; i++)
        {
            camera = main_camera_obj.cameras[? i];
            if(main_camera_obj.on)
            {
                camera = main_camera_obj.id;
                count = 1;
            }
            if(!is_undefined(camera) && instance_exists(camera))
            {
                if(camera.on)
                {
                    var viewCamera = view_get_camera(camera.view);
                    var viewX = camera_get_view_x(viewCamera);
                    var viewY = camera_get_view_y(viewCamera);
                    var viewWidth = camera_get_view_width(viewCamera);
                    var viewHeight = camera_get_view_height(viewCamera);
                    
                    if (x > viewX && x < (viewX + viewWidth)
                     && y > viewY && y < (viewY + viewHeight))
                    {
                        // POSITION
                        xx = floor( (x - viewX) * camera.zoom_level + view_get_xport( camera.view ) );
                        yy = floor( (y - viewY) * camera.zoom_level + view_get_yport( camera.view ) );
    
                        // SIZE
                        var base_charge = max_charge + overcharge;
                        
                        var base_bar_width = floor(base_charge * 60 * camera.zoom_level);
                        var feed_bar_width = floor(collapse_threshold * 60 * camera.zoom_level);

                        bar_dist = (base_radius - 8) * max_charge * size_coef * camera.zoom_level;
                        
                        var left_border = floor(xx - base_bar_width/2);
                        var right_border = floor(xx + base_bar_width/2);
                        var top_border = floor(yy + bar_dist);
                        var bottom_border = floor(yy + bar_dist + bar_height);
                        
                        // COLOR
                        var bg_color, border_color;
                        
                        if(my_color == g_white)
                        {
                            bg_color = dark_bg_color;
                            border_color = dark_bg_color;
                        }
                        else
                        {
                            bg_color = dark_bg_color;
                            border_color = light_bg_color;
                        }
                        
                        draw_set_color(bg_color);
                        draw_rectangle(left_border, top_border, right_border, bottom_border, false);
                        
                        var bar_width = floor((charge / base_charge) * base_bar_width);
                        draw_set_color(base_bar_color);
                        draw_rectangle(left_border, top_border, left_border + bar_width, bottom_border, false);
                        var feed_width = 0;
                        if(charge > base_charge)
                        {
                            draw_set_color(feed_bar_color);
                            feed_width = floor( ((charge-base_charge) / collapse_threshold) * feed_bar_width);
                            draw_rectangle(right_border + 2, top_border,
                                right_border + 2 + feed_width, bottom_border, false);
                        }
                        
                        
                        draw_set_color(border_color);
                        draw_rectangle(left_border, top_border, right_border, bottom_border,true);
                        if(feed_width > 0)
                        {
                            draw_rectangle(right_border + 2 , top_border, right_border + 2 + feed_width, bottom_border,true);
                        }
                    }
                }
            }
        }
    }
}

event_inherited();
