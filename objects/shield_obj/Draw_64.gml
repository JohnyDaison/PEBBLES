if(draw_bar && !gamemode_obj.limit_reached && instance_exists(my_guy) && sprite_index != noone && my_color != -1)
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
                    view_num = camera.view;
                    
                    if(x > __view_get( e__VW.XView, view_num ) && x < (__view_get( e__VW.XView, view_num ) + __view_get( e__VW.WView, view_num ))
                    && y > __view_get( e__VW.YView, view_num ) && y < (__view_get( e__VW.YView, view_num ) + __view_get( e__VW.HView, view_num )))
                    {
                        // POSITION
                        xx = floor((x - __view_get( e__VW.XView, view_num ))*camera.zoom_level + __view_get( e__VW.XPort, view_num ));
                        yy = floor((y - __view_get( e__VW.YView, view_num ))*camera.zoom_level + __view_get( e__VW.YPort, view_num ));
    
                        // SIZE
                        base_charge = max_charge + overcharge;
                        
                        base_bar_width = base_charge*60 * camera.zoom_level;
                        feed_bar_width = collapse_threshold*60 * camera.zoom_level;
                        total_bar_width = base_bar_width + feed_bar_width;

                        bar_dist = base_radius*max_charge*size_coef -16;
                        
                        left_border = round(xx - base_bar_width/2);
                        right_border = round(xx + base_bar_width/2);
                        top_border = yy + bar_dist;
                        bottom_border = yy + bar_dist + bar_height;
                        
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
                        draw_rectangle(left_border, top_border, right_border-1, bottom_border, false);
                        
                        base_bar_ratio = 1 - 2*charge/base_charge;
                        base_bar_ratio = clamp(base_bar_ratio,-1,1);
                        /*
                        base_bar_color = make_color_rgb((max(base_bar_ratio,0)-1)*-255,(min(base_bar_ratio,0)+1)*255,0);
                        base_bar_color = merge_color(base_bar_color,c_white,0.5);
                        */
                        
                        draw_set_color(base_bar_color);
                        draw_rectangle(left_border, top_border, left_border+floor((charge/base_charge)*(base_bar_width-1)), bottom_border,false);
                        feed_width = 0;
                        if(charge > base_charge)
                        {
                            draw_set_color(feed_bar_color);
                            feed_width = floor(((charge-base_charge)/collapse_threshold)*(feed_bar_width-1));
                            draw_rectangle(left_border + base_bar_width, top_border,
                                left_border + base_bar_width + feed_width, bottom_border,false);
                        }
                        
                        draw_set_color(border_color);
                        draw_rectangle(left_border-1, top_border-1, right_border-1, bottom_border,true);
                        if(feed_width > 0)
                        {
                            draw_rectangle(right_border, top_border-1, right_border+feed_width, bottom_border,true);
                        }
                    }
                }
            }
        }
    }
}

event_inherited();
