event_inherited();

if(instance_exists(my_guy) && object_is_ancestor(my_guy.object_index, terrain_obj))
{
    if(my_guy.image_speed == 0)
    {
        my_guy.falling = true;
        trigger_terrainfall = true;
    }
    else
    {
        trigger_terrainfall = false;
    }
}

if(image_index+image_speed >= image_number)
{
    instance_destroy();
}

