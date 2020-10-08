with(wall_obj)
{
    if(other.x == x && other.y == y)
    {
        is_burner = true;
        burn_to_black = other.burn_to_black;
    }
}

instance_destroy();

