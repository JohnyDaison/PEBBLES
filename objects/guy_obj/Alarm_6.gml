/// @description DELETE PLACEHOLDER
if(instance_exists(place_holder) && my_player.my_camera != noone)
{
    my_player.my_camera.my_guy = id;
    my_player.my_camera.my_spawner = my_spawner;
    place_holder.die = true;
}

