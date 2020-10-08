/// @description  ASSIGN PLAYER AND STATS
if(my_player == gamemode_obj.environment)
{
    var closest_spawner = get_closest_spawner(x+16, y+16, true);
    
    if(instance_exists(closest_spawner) && instance_exists(closest_spawner.my_player))
    {
        my_player = closest_spawner.my_player;
    }
}

gamemode_obj.stats[? "terrain_original_total"] += 1;
//if(my_player != gamemode_obj.environment)
//{
    increase_stat(my_player, "terrain_side_original", 1, false);
//}

if(core == core_energy && cover == cover_none)
{
    gamemode_obj.stats[? "terrain_original_destroyable"] += 1;
    //if(my_player != gamemode_obj.environment)
    //{
        increase_stat(my_player, "terrain_side_original_destroyable", 1, false);
    //}
}

