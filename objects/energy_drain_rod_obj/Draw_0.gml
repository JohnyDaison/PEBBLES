var list, count, target, dist;

for(dir = 0; dir < 4; dir++)
{
    if(enabled[? dir])
    {
        var xx = 1, xcor = 0;
        var yy = 1, ycor = 0;
        if(dir==1)
            ycor = 1;   
        if(dir==2)
            xcor = 1;
        if(dir>1)
            xx = -1;
                   
        draw_sprite_ext(sprite_index, image_index, x+xcor,y+ycor, xx,yy, (dir mod 2)*90, tint, 1);
        
        draw_set_colour(lightning_tint);
        draw_set_alpha(lightning_alpha);
        
        list = drain_target_list[? dir];
        count = ds_list_size(list);
        
        var hdir = 0;
        var vdir = 0;
        
        if(dir mod 2 == 0)
            hdir = -(dir -1);
        else
            vdir = (dir -2);
 
            
        for(i = 0; i < count; i++)
        {
            target = list[| i];
            
            if(instance_exists(target))
            {
                dist = point_distance(x + hdir*drain_point_dist, y + vdir*drain_point_dist, target.x, target.y);
                    
                draw_lightning_width(x + hdir*drain_point_dist, y + vdir*drain_point_dist,
                    target.x, target.y,
                    lightning_width, lightning_steps*dist/grid_size, lightning_thickness);
            }
        }
        draw_set_alpha(1);
    }
}

action_inherited();
