function guy_capture_spawner(guy, spawner) {
    var player = guy.my_player;
    var player_num = player.number;

    if(is_undefined(spawner.spawn_points[? player_num]) && guy_can_capture_spawner(guy, spawner))
    {
        // CREATE SPAWN POINT
        guy_spawn_point_create(spawner, player);
    
        if(spawner.object_index == guy_spawner_obj)
        {
            if(ds_list_size(spawner.my_players) == 0)
            {
                spawner.my_player = player;
                spawner.shield_ready = true;
            
                if(instance_exists(spawner.base_cannon))
                {
                    spawner.base_cannon.assignPlayer(player);
                }
            }
        
            if(ds_list_find_index(spawner.my_players, player) == -1)
            {
                ds_list_add(spawner.my_players, player);
            }
        
            guy.my_base = spawner;
            player.my_base = spawner;
        }
    }
}
