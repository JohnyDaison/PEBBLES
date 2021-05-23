/// BOUNCE, FALLING

// BOUNCE
if(bounced || corner_bounced)
{   
    x += x_return;
    y += y_return;
}

/*if(!place_meeting(x,y, solid_terrain_obj))
{*/
    self.bounced = false;
//}



// START FALLING IF STOPPED
if(speed < 0.5)
{
    was_stopped = true;
    is_resting = false;
    
    ter = instance_nearest(x-16,y, solid_terrain_obj);
    if(!is_resting && instance_exists(ter)
    && place_meeting(x,y+1, ter) && !place_meeting(x,y-core_radius, ter))
    {
        is_resting = true;
        /*
        if(ter.object_index == wall_obj && singleton_obj.step_count mod 5 == 0)
        {        
            other.my_next_color = irandom_range(g_red, g_cyan);
        }
        */
    }

    if(!is_resting)
    {
        var other_smoke = instance_place(x,y+1, energy_smoke_obj);
        if(instance_exists(other_smoke) && other_smoke.y > y)
        {
            is_resting = true;
        }
    }
}

if(!is_resting)
{
    gravity = fall_gravity;
}
else
{
    gravity = 0;
}

if(singleton_obj.step_count mod 10 == 0 && random(1) < 0.2)
{
    image_index = irandom(image_number-1);   
}

// LIGHT BOOST
ambient_light = orig_ambient_light*light_boost;
direct_light = orig_direct_light*light_boost;
light_boost = 1;


consolidated = false;

event_inherited();