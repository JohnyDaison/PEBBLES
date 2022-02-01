/// @description ASSIGN PLAYER
if(my_player == gamemode_obj.environment)
{
    var closest_spawner = get_closest_spawner(x, y, true);
    
    if(instance_exists(closest_spawner) && instance_exists(closest_spawner.my_player))
    {
        my_player = closest_spawner.my_player;
        my_team_number = my_player.team_number;
        flag_icon = my_player.icon;
    }
}
