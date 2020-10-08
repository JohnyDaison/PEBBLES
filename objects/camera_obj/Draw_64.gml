// DRAW FRAME
if(on)
{
    view_x = __view_get( e__VW.XPort, view );
    view_y = __view_get( e__VW.YPort, view );
    width = __view_get( e__VW.WPort, view )-1;
    panel_height = singleton_obj.player_panel_height - 1;
    //view_height = view_hport[view] - panel_height - 2; 
    view_height = __view_get( e__VW.HPort, view ) - 1; 
    panel_y = __view_get( e__VW.HPort, view ) - panel_height - 1;  
    
    if(instance_exists(my_guy))
    {
        if(draw_frame)
        {
            draw_set_alpha(1);
            draw_set_colour(c_black);
            draw_line(view_x,view_y,view_x,view_y+view_height);
            draw_line(view_x,view_y,view_x+width,view_y);
            draw_line(view_x+width,view_y,view_x+width,view_y+view_height);
            draw_line(view_x,view_y+view_height,view_x+width,view_y+view_height);
            
            body_color = ds_map_find_value(DB.colormap,g_black);
            
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
                shield_col = ds_map_find_value(DB.colormap,g_black);
            }
            */
            if(object_is_ancestor(my_guy.object_index,guy_obj))
            {
                potential_color = DB.colormap[? my_guy.potential_color];
                body_color = DB.colormap[? my_guy.my_color];
                
                if(my_guy.channeling)
                {
                    potential_color = DB.colormap[? g_black];
                    body_color = DB.colormap[? g_black];
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
                
                draw_rectangle(view_x+i-1, view_y+i-1, view_x+width-i, view_y+view_height-i, true);
            }
        }
    
        if(draw_panel)
        {
            draw_set_colour(panel_bg_color);
            draw_set_alpha(1);
            
            draw_rectangle(view_x,panel_y,view_x+width,panel_y+panel_height,false);
            
            if(draw_frame)
            {
                for(i=0;i<border_width;i+=1)
                {
                    
                    ratio = i/border_width;
                    
                    if(ratio <= 1/3)
                    {
                        draw_set_colour(merge_colour(border_color,panel_frame_color,sqrt(ratio*3)));
                    }
                    else
                    {
                        if(ratio <= 2/3)
                        {
                            draw_set_colour(merge_colour(panel_frame_color,c_black,(ratio-1/3)*3));
                        }
                        else
                        {
                            draw_set_colour(c_black);
                        }
                    } 
                    
                    draw_rectangle(view_x+i-1,panel_y+i-1,view_x+width-i-1,panel_y+panel_height-i-1,true);
                }
            }
        }
        
        // STATUS STRING
        if(draw_status)
        {
            draw_set_colour(c_black);
            draw_set_alpha(0.8);
            draw_rectangle(view_x,panel_y,view_x+width,panel_y+32,false);
            draw_set_colour(c_orange);
            draw_set_alpha(1);
            my_draw_set_font(label_font);
            draw_set_valign(fa_top);
            draw_set_halign(fa_center);
            my_draw_text(view_x + border_width*2 + 100, panel_y, "[" + string_format(x,7,2) + "," + string_format(y,7,2) + "] " );
            my_draw_text(view_x + border_width*2 + 300, panel_y, string_format(__view_get( e__VW.WPort, view ),7,2) + " x " + string_format(__view_get( e__VW.HPort, view ),7,2) );
            my_draw_text(view_x + border_width*2 + 500, panel_y, string_format(__view_get( e__VW.WView, view ),7,2) + " x " + string_format(__view_get( e__VW.HView, view ),7,2) );
            my_draw_text(view_x + border_width*2 + 700, panel_y, "(" + string_format(zoom_level,7,2) + ")" );
        }
        
        // DEATH COVER
        if(death_cover_show)
        {
            draw_set_alpha(0.33);
            draw_set_colour(c_dkgray);
            draw_rectangle(view_x,view_y,view_x+width,panel_y+panel_height,false);
        }
        
        draw_set_alpha(1);
    
        // DEBUG RETICLES
        if(reticles)
        {   
            xview = __view_get( e__VW.XView, view );
            yview = __view_get( e__VW.YView, view );
            followed_gui_x = followed_x -xview +view_x;
            followed_gui_y = followed_y -yview +view_y;
            gui_x = x -xview +view_x;
            gui_y = y -yview +view_y
            draw_set_alpha(1);
            
            draw_set_colour(c_red);
            
            draw_rectangle(followed_gui_x-24,followed_gui_y-24,followed_gui_x+24,followed_gui_y+24,true);
            
            draw_set_colour(c_green);
            draw_rectangle(gui_x-16,gui_y-16,gui_x+16,gui_y+16,true);
        }
    }
}

/* */
/*  */
