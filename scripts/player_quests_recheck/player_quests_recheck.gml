function player_quests_recheck(player) {
    var i, context_id;
    var count = ds_list_size(player.root_quest_list);
    var checks_done = 0;

    with(player)
    {
        for(i = 0; i < count; i++)
        {
            context_id = root_quest_list[| i];
            checks_done += player_quest_recheck(player, context_id);
        }

        last_quests_recheck = singleton_obj.step_count;
    }

    return checks_done;
}
