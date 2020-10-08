//x = other.x+ other.facing*16;
//y = other.y;

if(other.aim_dist == 0)
{
    if(other.facing == 1)
    {
        direction = 30;
    } 
    else
    {
        direction = 150;
    }
}
else
{
    if(instance_exists(my_guy.charge_ball))
    {
        direction = point_direction(0, 0, my_guy.charge_ball.rel_x, my_guy.charge_ball.rel_y);
    }
    else
    {
        var hor_coef = lengthdir_x(sign(my_guy.desired_aim_dist), my_guy.desired_aim_dir);
        var ver_coef = lengthdir_y(sign(my_guy.desired_aim_dist), my_guy.desired_aim_dir);
        
        hspeed = hor_coef;
        vspeed = ver_coef;
        
        /*
        hspeed = 0;
        if(other.hor_dir_held)
            hspeed = other.facing;
        if(!other.looking_down)
            vspeed = -1;
        else 
            vspeed = 1;
        */
    }
}
speed = throw_speed;
hspeed += other.hspeed;
vspeed += other.vspeed; 

placed = true;
sticky = true;
increase_stat(my_player, "grenades_thrown", 1, false);

