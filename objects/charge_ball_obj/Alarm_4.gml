/// @description  SMOKE
if(instance_exists(my_guy))
{   
    i = instance_create(x+irandom(10)-5, y+irandom(10)-5, energy_smoke_obj);
    i.my_player = my_guy.my_player;
    i.my_guy = my_guy.id;
    i.my_source = object_index;
    i.holographic = self.holographic;
    if(charge >= smoke_charge)
    {
        i.force = smoke_charge;
    }
    else
    {
        i.force = charge;
    }
    i.max_force = i.force;
    
    i.direction = point_direction(0,0, rel_x, rel_y);

    if(desired_dist != 0)
    {
        i.speed = 5 + 3*self.trig_charge*point_distance(0,0, rel_x, rel_y)/desired_dist;
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
}

if(charge > 0)
{
    alarm[4] = smoke_delay;
}
else
{
    firing = false;
}

