if(instance_exists(my_shield))
{
    my_shield.x = x;
    //my_shield.y = y-hover_offset-loop_height/2;
    my_shield.y = y-hover_offset-step;
}

event_inherited();