/// @description SMOKE
if(instance_exists(my_guy) && instance_exists(my_guy.charge_ball))
{   
    i = instance_create(x+irandom(4)-2, y+irandom(4)-2, energy_smoke_obj);
    i.my_player = my_guy.my_player;
    i.my_guy = my_guy.id;
    with(i)
    {
        has_left_update(my_guy, false);
    }
    i.my_source = object_index;
    if(charge >= smoke_charge)
    {
        i.force = smoke_charge;
    }
    else
    {
        i.force = charge;
    }
    i.max_force = i.force;

    i.direction = point_direction(0, 0, my_guy.charge_ball.rel_x, my_guy.charge_ball.rel_y);
    
    if(my_guy.charge_ball.desired_dist != 0)
    {
        i.speed = 5 + 3*self.trig_charge*point_distance(0,0, my_guy.charge_ball.rel_x, my_guy.charge_ball.rel_y)/my_guy.charge_ball.desired_dist;
    }
    else
    {
        i.speed = 5 + 3*self.trig_charge;
    }
    i.hspeed += my_guy.hspeed;
    i.vspeed += my_guy.vspeed;
    
    i.my_color = g_octarine;
    i.tint_updated = false;
    charge -= i.force;
    
    increase_stat(my_player, "smoke_sprayed", 1, false);
}

if(charge > 0)
{
    alarm[4] = smoke_delay;
}
else
{
    instance_destroy();
}

