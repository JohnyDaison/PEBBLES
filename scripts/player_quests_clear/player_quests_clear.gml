/// @param {Id.Instance} player
function player_quests_clear(player) {
    var count = ds_list_size(player.root_quest_list);

    for (var i = count - 1; i >= 0; i--) {
        var context = player.root_quest_list[| i];
        player_quest_state_destroy(player, context);
    }

    return count;
}
