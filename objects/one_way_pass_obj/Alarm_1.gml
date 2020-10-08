/// @description  ASSIGN PLAYER
if(for_player == -1)
{
    var closest_spawner = get_closest_spawner(x,y, true);

    if(instance_exists(closest_spawner) && instance_exists(closest_spawner.my_player))
    {
        my_player = closest_spawner.my_player;
    }
}
else
{
    var player = gamemode_obj.players[| for_player];
    if(!is_undefined(player))
    {
        my_player = player;
    }
}

if(place_meeting(x,y-2,one_way_pass_obj))
{
    walkable = false;
}

