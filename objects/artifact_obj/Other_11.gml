if(damage >= hp)
{
    instance_destroy();
}
else
{
    image_alpha = 1 - 0.66*(damage/hp);
    image_index = irandom(10); 
    if(invisible)
    {
        alarm[0] = irandom(180)+1;
        visible = true;
        invisible = false;
    }
}

