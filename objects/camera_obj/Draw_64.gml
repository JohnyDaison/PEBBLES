// DRAW FRAME
if(on)
{
    view_x = view_get_xport(view);
    view_y = view_get_yport(view);
    width = view_get_wport(view) - 1;
    height = view_get_hport(view) - 1; 
    
    if(instance_exists(my_guy))
    {
        if(draw_frame)
        {
            draw_set_alpha(1);
            draw_set_colour(c_black);
            draw_line(view_x, view_y, view_x, view_y + height);
            draw_line(view_x, view_y, view_x + width, view_y);
            draw_line(view_x + width, view_y, view_x + width, view_y + height);
            draw_line(view_x, view_y + height, view_x + width, view_y + height);
            
            body_color = ds_map_find_value(DB.colormap, g_dark);
            
            /*
            body_color = ds_map_find_value(DB.colormap,my_guy.my_color);
            
            if(object_is_ancestor(my_guy.object_index,guy_obj))
            {
                has_shield = (instance_exists(my_guy.my_shield));
            }
            else
            {
                has_shield = false;
            }
            
            if(has_shield)
            {
                shield_col = ds_map_find_value(DB.colormap,my_guy.my_shield.my_color);
            }
            else
            {
                shield_col = ds_map_find_value(DB.colormap,g_dark);
            }
            */
            if(object_is_ancestor(my_guy.object_index,guy_obj))
            {
                potential_color = DB.colormap[? my_guy.potential_color];
                body_color = DB.colormap[? my_guy.my_color];
                
                if(my_guy.channeling)
                {
                    potential_color = DB.colormap[? g_dark];
                    body_color = DB.colormap[? g_dark];
                }
                                
                /*
                if(my_guy.potential_abi_name != "" || my_guy.slots_triggered)
                {
                    body_color = inner_color;
                }
                */
                
            }
            
            //shield_col = body_color;
            inner_color = potential_color;
            //outer_color = body_color;
            //inner_color = body_color;
            outer_color = potential_color;
            
            draw_set_alpha(1);
            
            for(i=0; i<border_width; i+=1)
            {
                ratio = i/border_width;
                
                if(ratio <= 1/3)
                {
                    draw_set_colour(merge_colour(c_black, outer_color, sqrt(ratio * 3) ));
                }
                else
                {
                    if(ratio <= 2/3)
                    {
                        draw_set_colour(merge_colour(outer_color, inner_color, (ratio - 1/3) * 3 ));
                    }
                    else
                    {
                        draw_set_colour(merge_colour(inner_color, border_color, sqr(ratio - 2/3) * 3 ));
                    }
                    
                    //draw_set_colour(merge_colour(outer_color, inner_color, sqr((ratio - 1/3) * 3/2) ));
                }  
                
                draw_rectangle(view_x + i - 1, view_y + i - 1, view_x + width - i, view_y + height - i, true);
            }
        } 
        
        // STATUS STRING
        if(draw_status)
        {
            draw_set_colour(c_black);
            draw_set_alpha(0.8);
            draw_rectangle(view_x, status_y, view_x + width, view_y + height, false);
            draw_set_colour(c_orange);
            draw_set_alpha(1);
            my_draw_set_font(label_font);
            draw_set_valign(fa_top);
            draw_set_halign(fa_center);
            
            var camera = view_get_camera(view);
            var view_width = camera_get_view_width(camera);
            var view_height = camera_get_view_height(camera);
            var start_x = view_x + border_width*2;
            var status_y = view_y + height - 32;
            
            var x_str = string_format(x, 7, 2);
            var y_str = string_format(y, 7, 2);
            var wport_str = string_format(view_get_wport(view), 7, 2);
            var hport_str = string_format(view_get_hport(view), 7, 2);
            var wview_str = string_format(view_width, 7, 2);
            var hview_str = string_format(view_height, 7, 2);
            var zoom_str = string_format(zoom_level, 7, 2);
            
            my_draw_text(start_x + 100, status_y, "[" + x_str + "," + y_str + "] " );
            my_draw_text(start_x + 300, status_y, wport_str + " x " + hport_str );
            my_draw_text(start_x + 500, status_y, wview_str + " x " + hview_str );
            my_draw_text(start_x + 700, status_y, "(" + zoom_str + ")" );
        }
        
        // DEATH COVER
        if(death_cover_show)
        {
            draw_set_alpha(0.33);
            draw_set_colour(c_dkgray);
            draw_rectangle(view_x, view_y, view_x + width, view_y + height, false);
        }
        
        draw_set_alpha(1);
    
        // DEBUG RETICLES
        if(reticles)
        {   
            var camera = view_get_camera(view);
            var xview = camera_get_view_x(camera);
            var yview = camera_get_view_y(camera);
            var followed_gui_x = followed_x - xview + view_x;
            var followed_gui_y = followed_y - yview + view_y;
            var gui_x = x - xview + view_x;
            var gui_y = y - yview + view_y
            
            draw_set_alpha(1);
            
            draw_set_colour(c_red);            
            draw_rectangle(followed_gui_x-24,followed_gui_y-24,followed_gui_x+24,followed_gui_y+24,true);
            
            draw_set_colour(c_green);
            draw_rectangle(gui_x-16,gui_y-16,gui_x+16,gui_y+16,true);
        }
    }
}
