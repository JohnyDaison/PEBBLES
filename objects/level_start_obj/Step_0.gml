if(activated)
{
    channeled = false;
    /*
    platform = instance_create(x,y+32,platform_obj);
    platform.invisible = true;
    */
}

if(instance_exists(my_guy) && !my_guy.dead && !channeling && !channeled)
{
    /*
    my_guy.forced_channel = true;
    alarm[0] = 120;
    channeling = true;
    */
    alarm[0] = 1;
    
    //activated = false;
}

if(channeling)
{
    my_guy.speed = 0;
}
/*
angle += 5;
angle = angle mod 360;
scale = 0.9 + sin(degtorad(angle))*0.2;

if(activated)
{
    alpha = 1;
}
else if(alpha > 0)
{
    alpha = max(0, alpha - alpha_decay);
}
*/