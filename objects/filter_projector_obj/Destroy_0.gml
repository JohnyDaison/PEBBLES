if(instance_exists(my_field))
{
    with(my_field)
    {
        instance_destroy();
    }
}


event_inherited();
