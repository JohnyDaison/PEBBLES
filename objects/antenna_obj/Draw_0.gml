for(var i=0; i<4; i++)
{
    if(enabled[? i])
    {
        var xx = 1, xcor = 0;
        var yy = 1, ycor = 0;
        if(i==1)
            ycor = 1;   
        if(i==2)
            xcor = 1;
        if(i>1)
            xx = -1;
                   
        draw_sprite_ext(sprite_index, image_index, x+xcor,y+ycor, xx,yy, (i mod 2)*90, tint, 1);
        
        draw_set_colour(lightning_tint);
        draw_set_alpha(lightning_alpha);
        
        if(lightning_dist[? i] > 0)
        {
            var hdir = 0;
            var vdir = 0;
            
            if(i mod 2 == 0)
                hdir = -(i -1);
            else
                vdir = (i -2);
            
            var x1 = x + hdir * grid_size;
            var y1 = y + vdir * grid_size;
            var x2 = x + hdir * lightning_dist[? i];
            var y2 = y + vdir * lightning_dist[? i];
            
            draw_lightning_width(x1, y1, x2, y2,
                lightning_width, lightning_steps*lightning_dist[? i]/grid_size, lightning_thickness);
                
            if(!instance_exists(light_emitter[? i]))
            {
                light_emitter[? i] = instance_create(x,y, rectangle_light_emitter_obj);
                light_emitter[? i].direct_light = false;
            }
            
            var emitter = light_emitter[? i];
            
            emitter.gives_light = true;
            emitter.x = (x1 + x2) / 2;
            emitter.y = (y1 + y2) / 2;
            emitter.image_xscale = (abs(x1 - x2) + lightning_width) / emitter.base_width;
            emitter.image_yscale = (abs(y1 - y2) + lightning_width) / emitter.base_height;
            emitter.my_color = lightning_color;
            emitter.tint = lightning_tint;
        }
        else
        {
            if(instance_exists(light_emitter[? i]))
            {
                light_emitter[? i].gives_light = false;
            }
        }
        
        draw_set_alpha(1);
    }
}

event_inherited();
