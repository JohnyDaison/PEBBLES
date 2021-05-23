with(wall_obj)
{
    if(other.x == x && other.y == y)
    {
        is_burner = true;
        burn_to_dark = other.burn_to_dark;
    }
}

instance_destroy();
