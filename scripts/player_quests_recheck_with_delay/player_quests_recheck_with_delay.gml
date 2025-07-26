/// @param {Id.Instance} player
function player_quests_recheck_with_delay(player) {
    if (singleton_obj.step_count - player.last_quests_recheck >= player.quest_recheck_delay) {
        player_quests_recheck(player);
    }
}