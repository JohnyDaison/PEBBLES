action_inherited();
if(!instance_exists(my_guy) && instance_exists(my_player))
{
    my_guy = my_player.my_guy;
}

fire = false;
target_dir = direction;
    
with(guy_obj) 
{
    turret_line_of_sight();
}

if(!fire)
{
    with(mob_obj) 
    {
        turret_line_of_sight();
    }
}

aim_dir = target_dir;
if(autofire)
{
    aim_dir = direction;
}
else if(abs(angle_difference( target_dir, point_direction(0,0, charge_ball.rel_x, charge_ball.rel_y) )) > 5)
{
    fire = false;
}

if(charge_ball.charge >= charge_ball.threshold && !charging)
{
    if(fire && charge_ball.cur_dist > 1)
    {
        fire = false;
    }
    
    if(autofire)
    {
        fire = true;
    }
    
    if(fire)
    {
        trigger(charge_ball);
        fire = false;
    }
}

if(instance_exists(my_block) && charge_ball.charge == 0)
{
    if(my_block.my_color > g_black && my_block.my_color < g_white)
    {
        charging = true;
        turret.my_color = g_white - my_block.my_color;
        turret.tint_updated = false;
    }
    else
    {
        turret.my_color = g_white;
        turret.tint_updated = false;
    }
}

