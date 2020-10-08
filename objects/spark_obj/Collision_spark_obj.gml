if(hor_dir == 0)
{
    if(other.hor_dir == 0)
    {
        hor_dir = 1;
        other.hor_dir = -1;
    }
    else
    {
        hor_dir = -other.hor_dir;
    }
}

