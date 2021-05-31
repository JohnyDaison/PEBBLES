/// @description  DRAIN WALLS AND SLIMES UPDATE
// TODO: THIS SHOULD COMPILE LIST OF ALL SOURCES AND THEN COMPUTE THE MAX OF THEM

alarm[6] = drain_update_delay;

if(my_guy != id && my_guy.channeling)
{
    var max_energy = 0;
    drained_object = noone;
    
    for(var i=0; i<ter_list_length; i++)
    {
        var ter = ter_list[| i];
        if(!is_undefined(ter) && instance_exists(ter) && ter.object_index == wall_obj)
        { 
            if ((ter.my_color & my_color) && point_distance(x,y, ter.x +15, ter.y +15) < drain_radius)
            {
                if(ter.energy > max_energy)
                {
                    max_energy = ter.energy;
                    drained_object = ter.id;
                }   
            }
        }
    }
    
    if(drained_object == noone)
    {
        var mob;
        with(slime_mob_obj)
        {
            mob = id;   
            with(other)
            {
                if ((mob.my_color & my_color) && point_distance(x,y, mob.x, mob.y) < drain_radius)
                {
                    if(mob.energy > max_energy)
                    {
                        max_energy = mob.energy;
                        drained_object = mob.id;
                    }   
                }
            }
        }
    }
}
else
{
    drained_object = noone;
    read_terrain = false;
    alarm[6] = -1;
}
