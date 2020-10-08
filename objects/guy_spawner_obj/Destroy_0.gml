if(instance_exists(my_player))
{
    my_player.my_spawner = noone;
    my_player.my_base = noone;
}
if(instance_exists(my_guy))
{
    my_guy.my_spawner = noone;
    my_guy.my_base = noone;
}

ds_list_destroy(my_players);

ds_list_destroy(crystals);

spawn_points_destroy();

event_inherited();
