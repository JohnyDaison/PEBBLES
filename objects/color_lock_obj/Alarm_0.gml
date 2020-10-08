with(wall_obj)
{
    if(other.x == x && other.y == y)
    {
        color_locked = true;
    }
}

instance_destroy();

