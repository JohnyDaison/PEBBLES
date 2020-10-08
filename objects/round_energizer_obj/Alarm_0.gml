with(wall_obj)
{
    if(place_meeting(x,y,other))
    {
        energy = max(energy, outburst_threshold);
    }
}

instance_destroy();

