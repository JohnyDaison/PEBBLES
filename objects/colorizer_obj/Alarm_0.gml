with(wall_obj)
{
    if(place_meeting(x,y,other))
    {
        my_next_color = my_next_color | other.my_color;
        energy = max(energy,status_threshold);
    }
}
with(piezoplate_obj)
{
    if(place_meeting(x,y,other))
    {
        my_color = my_color | other.my_color;
        my_last_color = my_color;
        energy = max_energy;
        tint_updated = false;
    }
}
with(universal_pad_obj)
{
    if(place_meeting(x,y,other))
    {
        pad_color = pad_color | other.my_color;
    }
}

with(slime_mob_obj)
{
    if(place_meeting(x,y,other))
    {
        my_color = my_color | other.my_color;
        tint_updated = false;
    }
}

with(spark_obj)
{
    if(place_meeting(x,y,other))
    {
        if(my_color >= g_octarine)
        {
            my_color = g_dark;
        }
        while(abs(hspeed) < 1)
        {
            hspeed = random(6)-3;
        }
        my_color = my_color | other.my_color;
        tint_updated = false;
    }
}

instance_destroy();
