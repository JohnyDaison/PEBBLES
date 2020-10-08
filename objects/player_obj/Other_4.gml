if(!singleton_obj.paused)
{
    if(instance_exists(gamemode_obj))
    {
        // LOAD LEVEL CONFIGS
        if(instance_exists(gamemode_obj.world) && instance_exists(gamemode_obj.world.current_place))
        {
            var place = gamemode_obj.world.current_place;
            var i, count = ds_list_size(place.level_configs_list);
        
            with(gamemode_obj)
            {
                for(i=0; i<count; i++)
                {
                    levels_load_config(place.level_configs_list[| i]);
                }
            }
            init_levels_player();
        }
    
    
        // UPDATE LEVELS
        if(last_room != room)
        {
            ds_map_copy(levels_roomstart, levels);
        }
        else
        {
            ds_map_copy(levels, levels_roomstart);
        }
    }
    else
    {
        // UPDATE LEVELS
        ds_map_copy(levels_roomstart, levels);
    }
    
    init_stats(id, stats);
    
    for(var i = 1; i <= achiev_count; i++)
    {
        achiev_state[? i] = 0;
    }
    
    //player_quests_clear(id);
    
    last_room = room;
}

