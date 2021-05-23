var amb, dir, high_tint;
var light_layer = self.light_layer;

if(on && singleton_obj.draw_lights && instance_exists(my_camera) && view_current == my_camera.view)
{   
    // AMBIENT LIGHT
    if(draw_ambient)
    {
        if(light_layer == "bg")
        {
            draw_set_blend_mode(bm_add);
        }
        if(light_layer == "main")
        {
            draw_set_blend_mode_ext(bm_dest_color, bm_one);
        }
        
        with(game_obj)
        {
            if(gives_light && visible && my_color > g_dark && ambient_light > 0)
            {
                var light_shape = shape;
                if(self.light_shape != shape_inherit)
                {
                    light_shape = self.light_shape;
                }

                //amb = min(ambient_light*holo_alpha, 1.5);
                //draw_set_alpha(amb*other.ambient_light_coef);
                switch(light_shape)
                {
                    case shape_circle:
                        amb = min(ambient_light*holo_alpha, 1.5);
                        draw_set_alpha(amb*other.ambient_light_circle_coef);
                        
                        //draw_circle_colour(x+light_xoffset, y+light_yoffset, amb*radius*other.ambient_radius_coef, tint, c_black, false);        
                        draw_light_circle(amb*other.ambient_radius_coef, tint);
                    break;
                    case shape_rect:
                        amb = min(ambient_light*holo_alpha, 1.5);
                        dir = min(direct_light*holo_alpha, 1.5);
                        
                        if(light_layer == "bg")
                        {
                            draw_set_alpha(amb*other.ambient_light_rectangle_coef);
                            draw_light_rectangle(amb*other.ambient_rectangle_coef, tint, dir*other.direct_rectangle_coef);
                        }
                        
                        if(light_layer == "main")
                        {
                            draw_set_alpha(dir*other.direct_light_rectangle_coef);
                            draw_light_rectangle(dir*other.direct_rectangle_coef, tint);
                        }
                        //radius = width/4.5;
                        //draw_circle_colour(x+light_xoffset, y+light_yoffset, amb*radius*other.ambient_radius_coef, tint, c_black, false);
                        
                        
                    break;
                }
            }
        }
    }
 
    // DIRECT LIGHT
    if(draw_direct)
    {
        //draw_set_alpha(direct_light_coef);
        //draw_set_blend_mode_ext(bm_dest_color, bm_one);
        draw_set_blend_mode(bm_add);
        
        with(game_obj)
        {
            if(gives_light && visible && my_color > g_dark && direct_light > 0)
            {
                high_tint = merge_color(tint,c_white,0.5);
                var light_shape = shape;
                if(self.light_shape != shape_inherit)
                {
                    light_shape = self.light_shape;
                }

                switch(light_shape)
                {
                    case shape_circle:
                        dir = min(direct_light*holo_alpha, 1.5);
                        draw_set_alpha(dir*other.direct_light_circle_coef);
                        
                        //draw_circle_color(x+light_xoffset, y+light_yoffset, dir*radius*other.direct_radius_coef, high_tint, c_black, false);
                        draw_light_circle(dir*other.direct_radius_coef, high_tint);
                    break;
                    case shape_rect:
                        dir = min(direct_light*holo_alpha, 1.5);
                        draw_set_alpha(dir*other.direct_light_rectangle_coef);
                        
                        //radius = width/3;
                        //draw_circle_color(x+light_xoffset, y+light_yoffset, dir*radius*other.direct_radius_coef, high_tint, c_black, false);
                        draw_light_rectangle(dir*other.direct_rectangle_coef, high_tint);
                    break;
                }
            }
        }   
    }
    
    // RESET MODE     
    draw_set_blend_mode(bm_normal); 
    draw_set_alpha(1);
}
