//if(my_shield.x != x || my_shield.y != y-hover_offset-loop_height/2)
if(instance_exists(my_shield))
{
    my_shield.x = x;
    //my_shield.y = y-hover_offset-loop_height/2;
    my_shield.y = y-hover_offset-step;
}

if(my_guy.object_index == guy_spawner_obj)
{  
    if(visible)
    {
        var xx = my_guy.x + (cos(my_angle)*my_distance); // *(-my_guy.facing)
        var yy = my_guy.y - sin(my_angle)*my_distance;
        
        direction = point_direction(x,y,xx,yy);
        speed = 0.5*point_distance(x,y,xx,yy);
    }
    else 
    {
        x = my_guy.x + (cos(my_angle)*my_distance); // *(-my_guy.facing)
        y = my_guy.y - sin(my_angle)*my_distance;
        speed = 0;
    }
    
    visible = true;
}

event_inherited();