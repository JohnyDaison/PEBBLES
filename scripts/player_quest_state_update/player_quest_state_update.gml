/// @param {Id.Instance} player
/// @param {String} context
/// @param {String} type
/// @param {Any} [value]
function player_quest_state_update(player, context, type, value = undefined) {
    var quest_state = player.quest_states[? context];
    var cur_reps = quest_state[? "state_reps"];

    if (type == "setstate") {
        quest_state[? "last_state"] = quest_state[? "current_state"];
        quest_state[? "current_state"] = value;
        cur_reps[? value]++;
    
        // this should schedule a recheck of the root_context?
    }
}
