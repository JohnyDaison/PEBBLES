if(source != noone && other.source != noone)
{
    if(source == other.source && my_color == other.my_color && type == other.type)
    {
        if(other.y > y)
        {
            other.damage += damage;
            other.tint = tint;
            other.fade_ratio = max(0.6, other.fade_ratio);
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

