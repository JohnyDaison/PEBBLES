if(source != noone && other.source != noone)
{
    if(source == other.source && my_color == other.my_color)
    {
        if(other.y > y)
        {
            other.energy += energy;
            instance_destroy();
        }
    }
    else
    {
        if(other.x > x)
        {
            other.x += 1;
            x -= 1;
        }
    }
}

