/// @param {Id.Instance} player
/// @param {String} quest_id
/// @param {String} context
/// @param {String} category
/// @return {Id.DsMap}
function player_quest_state_find(player, quest_id, context, category) {
    var count = ds_list_size(player.all_quest_list);
    
    for (var i = 0; i < count; i++) {
        var quest_context = player.all_quest_list[| i];
        var quest_state = player.quest_states[? quest_context];

        if ((context == "" || context == quest_context)
            && (quest_id == "" || quest_id == quest_state[? "quest_id"])
            && (category == "" || category == quest_state[? "category"])) {
            return quest_state;
        }
    }

    return undefined;
}
