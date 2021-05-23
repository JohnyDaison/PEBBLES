action_inherited();
if(!instance_exists(my_guy) && instance_exists(my_player))
{
    my_guy = my_player.my_guy;
}

fire = false;

if(charge_ball.charge >= charge_ball.threshold && !charging)
{
    with(guy_obj) 
    {
        beam_turret_line_of_sight();
    }
    
    if(!fire)
    {
        with(sprinkler_body_obj) 
        {
            beam_turret_line_of_sight();
        }
    }
    
    if(fire && my_block.my_color != g_octarine)
    {
        trigger(charge_ball);
        fire = false;
    }
}

if(instance_exists(my_block) && my_block.my_color > g_dark && charge_ball.charge == 0)
{
    charging = true;
    turret.my_color = my_block.my_color;
    turret.tint_updated = false;
}
