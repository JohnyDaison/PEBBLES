if(instance_exists(my_shield))
{
    with(my_shield)
    {
        instance_destroy();
    }
}

event_inherited();
