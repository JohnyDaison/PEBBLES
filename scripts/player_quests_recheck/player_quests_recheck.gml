/// @param {Id.Instance} player
/// @return {Real}
function player_quests_recheck(player) {
    var count = ds_list_size(player.root_quest_list);
    var checks_done = 0;

    for (var i = 0; i < count; i++) {
        var context_id = player.root_quest_list[| i];
        checks_done += player_quest_recheck(player, context_id);
    }

    player.last_quests_recheck = singleton_obj.step_count;

    return checks_done;
}
