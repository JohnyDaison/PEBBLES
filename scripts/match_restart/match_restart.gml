function match_restart() {
    with(player_obj)
    {
        my_spawner = noone;
        my_base = noone;
        my_camera = noone;
        my_guy = noone;
        winner = false;
        loser = false;
    
        init_stats(id, stats);
    
        for(var i = 1; i <= achiev_count; i++)
        {
            achiev_state[? i] = 0;
        }
    
        battlefeed = noone;
    
        player_quests_clear(id);
    }

    with(gamemode_obj)
    {
        shown_welcome = false;
        closed_welcome = false;
        created_gui = false;
        match_started = false;
        limit_reached = false;
        reached_limit_name = "";
        match_finished = false;
        game_ended = false;
    
        winner = noone;
        loser = noone;
        ds_list_clear(losers);
        time_window = noone;
        battlefeed = noone;
    
        init_match_stats();
    }

    DB.mob_spawner_start_offset = 0;

    chunk_deoptimizer();

    with(empty_frame)
    {
        close_frame(id);
    }


    singleton_obj.alarm[2] = 1;

    return 1;
}
