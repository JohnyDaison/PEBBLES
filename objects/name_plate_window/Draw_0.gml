var view_number = my_guy.my_player.number;

if(instance_exists(my_camera))
{
    view_number = my_camera.view;
}

var dodraw = view_current != 0 && 
            ((friend && view_current == view_number)
          || (!friend && view_current != view_number));

if(dodraw && instance_exists(my_guy))
{
    x = my_guy.x - width/2;
    y = my_guy.y -80 -height/2;
    //xx = x;
    //yy = y;
    
    draw_swapped = false;
    
    var camera = main_camera_obj.cameras[? view_current];
    var camera_on = !is_undefined(camera) && instance_exists(camera) && camera.on;

    if(camera_on)
    {
        view_width = __view_get( e__VW.WView, view_current );
        view_height = __view_get( e__VW.HView, view_current );
        self.view_x_offset = __view_get( e__VW.XView, view_current );
        self.view_y_offset = __view_get( e__VW.YView, view_current );
        
        view_center_x = self.view_x_offset + view_width/2;
        view_center_y = self.view_y_offset + view_height/2;
        
        xdist = my_guy.x - view_center_x;
        ydist = my_guy.y - view_center_y;
        
        if(abs(xdist) > view_width/2 || abs(ydist) > view_height/2)
        {
            draw_swapped = true;
            
            if(xdist != 0)
            {
                coef = ydist/xdist;
            }
            else
            {
                coef = 0;
            }
            
            vert_guide = 0;
            hor_guide = 0;
            
            if(sign(xdist) >= 0)
            {
                vert_guide = view_width/2 - border_width - width/2;   
            }
            
            if(sign(xdist) < 0)
            {
                vert_guide = -view_width/2 + border_width + width/2;   
            }
            
            if(sign(ydist) >= 0)
            {
                hor_guide = view_height/2 - border_width - height/2;   
            }
            
            if(sign(ydist) < 0)
            {
                hor_guide = -view_height/2 + border_width + height/2;   
            }
            
            if(xdist != 0 && coef != 0)
            {
                new_x = hor_guide/coef;
            }
            else
            {
                new_x = vert_guide;
            }
            new_y = vert_guide*coef;
            
            if(abs(new_x) <= abs(vert_guide))
            {
                x = view_center_x + new_x - width/2;
                y = view_center_y + hor_guide - height/2;
            }
            
            if(abs(new_y) <= abs(hor_guide))
            {
                x = view_center_x + vert_guide - width/2;
                y = view_center_y + new_y - height/2;
            }    
        }
    }

    window_axis = x+self.width/2;
    
    /*
    if(draw_swapped && bg_color == c_gray)
    {
        bg_color = c_ltgray;
    }
    
    if(!draw_swapped && bg_color == c_ltgray)
    {
        bg_color = c_gray;
    }
    */
    /*
    draw_set_alpha(self.bg_alpha);
    if(self.draw_bg_color)
    {
        if(draw_swapped)
        {
            draw_set_colour(self.color);
        }
        else
        {
            draw_set_colour(self.bg_color);
        }
        draw_roundrect(x,y,x+self.width,y+self.height,false)
    }
    draw_set_alpha(self.border_alpha);
    if(self.draw_border)
    {
        draw_set_colour(c_black);
        draw_roundrect(x,y,x+self.width,y+self.height,true)
    }
    draw_set_alpha(1);
    if(draw_swapped)
    {
        draw_set_colour(self.bg_color);
    }
    else
    {
        draw_set_colour(self.color);
    }
    */
    /*
    my_draw_set_font(self.font);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    my_draw_text(window_axis,y+16,self.text);
    */
    
    // FLAG
    var flag_tint = c_white;
    
    if(iff_check("allied", gamemode_obj.players[? view_current], my_guy))
    {
        flag_tint = allied_flag_tint;
    }
    if(iff_check("enemy", gamemode_obj.players[? view_current], my_guy))
    {
        flag_tint = enemy_flag_tint;
    }
    
    draw_sprite_ext(flag_icon, 0, window_axis, y+16,1,1,0,flag_tint,flag_alpha);
}
