/// @param {Id.Instance} player
/// @param {String} context
function player_quest_state_destroy(player, context) {
    var quest_state = player.quest_states[? context];
    var root_index = ds_list_find_index(player.root_quest_list, context);

    //SUBTASKS
    var quest_id = quest_state[? "quest_id"];
    var quest_node = DB.quest_nodes[? quest_id];
    var subtasks_list = quest_node[? "subtasks_list"];
    var count = ds_list_size(subtasks_list);

    for (var i = count - 1; i >= 0; i--) {
        var subtask_id = subtasks_list[| i];

        player_quest_state_destroy(player, context + DB.quest_context_divider + subtask_id);
    }

    // MAIN TASK

    // TRANSITIONS - UNSUBCRIBE CONDITIONS
    var tr_list = quest_node[? "state_transitions"];
    var tr_count = ds_list_size(tr_list);
    var cond_states = quest_state[? "transition_condition_states"];

    for (var tr_i = 0; tr_i < tr_count; tr_i++) {
        var transition = tr_list[| tr_i];

        var cond_list = transition[? "conditions"];
        var cond_count = ds_list_size(cond_list);

        for (var cond_i = 0; cond_i < cond_count; cond_i++) {
            var condition = cond_list[| cond_i];
            var cond_str = condition[? "type"] + "_" + condition[? "verb"];
            var tr_cond_str = string(tr_i) + " " + string(cond_i);

            if (condition[? "event_based"]) {
                with (player) {
                    unsubscribe_event(cond_str, condition_event_script, all);
                }
            }
        }
    }

    // DESTROY
    if (root_index != -1) {
        ds_list_delete(player.root_quest_list, root_index);
    }
    ds_list_delete(player.all_quest_list, ds_list_find_index(player.all_quest_list, context));

    ds_map_destroy(quest_state[? "transition_condition_states"]);
    ds_map_destroy(quest_state[? "state_reps"]);
    ds_map_destroy(quest_state);
    ds_map_delete(player.quest_states, context);
}
