//if(my_shield.x != x || my_shield.y != y-hover_offset-loop_height/2)
if(instance_exists(my_shield))
{
    my_shield.x = x;
    //my_shield.y = y-hover_offset-loop_height/2;
    my_shield.y = y-hover_offset-step;
}

if(my_guy.object_index == guy_spawner_obj)
{
    var current_distance = my_distance * fade_counter;
    var xx = my_guy.x + (cos(my_angle) * current_distance);
    var yy = my_guy.y - (sin(my_angle) * current_distance);
        
    direction = point_direction(x, y, xx, yy);
    speed = orbiting_lerp_ratio * point_distance(x, y, xx, yy);
    
    visible = true;
}

event_inherited();