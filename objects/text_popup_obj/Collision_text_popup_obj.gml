if(str != "")
{
    if(str == other.str)
    {
        if(y > other.y)
        {
            instance_destroy();
        }
    }
    else
    {
        var dir = sign(y - other.y);
        y += dir;   
    }
}