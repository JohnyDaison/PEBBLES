if (!singleton_obj.paused) {
    if (instance_exists(gamemode_obj)) {
        load_level_configs();

        // UPDATE LEVELS
        if (room != last_room && room != match_summary) {
            ds_map_copy(levels_roomstart, levels);
        }
        else {
            ds_map_copy(levels, levels_roomstart);
        }
    }
    else {
        // UPDATE LEVELS
        ds_map_copy(levels_roomstart, levels);
    }

    init_stats(id, stats);

    for (var i = 1; i <= achiev_count; i++) {
        achiev_state[? i] = 0;
    }

    //player_quests_clear(id);

    last_room = room;
}
