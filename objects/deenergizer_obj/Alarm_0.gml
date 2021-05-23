with(wall_obj)
{
    if(place_meeting(x,y,other))
    {
        if(other.go_dark)
        {
            energy = 0;
            my_next_color = g_dark;
        }
        else
        {
            energy = min(energy, 0.001);   
        }
    }
}

instance_destroy();
