with(wall_obj)
{
    if(place_meeting(x,y,other))
    {
        if(other.custom_energy)
        {
            energy = other.energy;
        }
        else
        {
            energy = max(energy, outburst_threshold);
        }
    }
}

instance_destroy();

