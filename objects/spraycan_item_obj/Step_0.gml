event_inherited();

if(used && instance_exists(my_guy))
{
    if(instance_exists(my_guy.charge_ball))
    {
        x = mean(my_guy.x, my_guy.charge_ball.x);
        y = mean(my_guy.y, my_guy.charge_ball.y);
        image_angle = point_direction(0, 0, my_guy.charge_ball.rel_x, my_guy.charge_ball.rel_y);
    }
    
    if(my_guy.lost_control)
    {
        instance_destroy();
    }
}

