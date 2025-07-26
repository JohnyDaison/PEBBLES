/// @param {Id.Instance} player
/// @param {String} quest_id
/// @param {String} context_id
/// @param {String} category
/// @returns {Id.DsMap}
function player_receive_quest(player, quest_id, context_id, category) {
    var quest_state = player_quest_state_create(player, quest_id, undefined, context_id, category);
    
    if (!is_undefined(quest_state)) {
        player_quest_state_update(player, context_id, "setstate", "start");
    }

    return quest_state;
}
