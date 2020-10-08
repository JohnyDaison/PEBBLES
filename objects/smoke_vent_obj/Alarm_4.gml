/// @description  SMOKE

if(charge >= full_charge)
{
    active = true;
}

if(ready && active)
{   
    i = instance_create(x+irandom(32)-16, y+32 + irandom(10), energy_smoke_obj);
    i.my_player = my_player;
    i.my_guy = id;
    i.my_source = object_index;
    i.force = smoke_charge;
    i.max_force = i.force;

    i.direction = point_direction(0, 0, (i.x - x)/4, i.y - y);
    i.speed = 12;
    
    i.my_color = g_octarine;
    i.tint_updated = false;
    
    charge -= smoke_charge;
    
    if(charge <= 0)
    {
        active = false;
    }
}

alarm[4] = smoke_delay;

