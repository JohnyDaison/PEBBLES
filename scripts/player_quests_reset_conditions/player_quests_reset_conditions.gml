/// @param {Id.Instance} player
function player_quests_reset_conditions(player) {
    var count = ds_list_size(player.all_quest_list);
        
    for (var i = 0; i < count; i++) {
        var context = player.all_quest_list[| i];
        var quest_state = player.quest_states[? context];
        var quest_id = quest_state[? "quest_id"];
        var quest_node = DB.quest_nodes[? quest_id];
        var cond_states = quest_state[? "transition_condition_states"];
        
        var tr_list = quest_node[? "state_transitions"];
        var tr_count = ds_list_size(tr_list);
        
        for (var tr_i = 0; tr_i < tr_count; tr_i++) {
            var transition = tr_list[| tr_i];
            
            var cond_list = transition[? "conditions"];
            var cond_count = ds_list_size(cond_list);
        
            for (var cond_i = 0; cond_i < cond_count; cond_i++) {
                var condition = cond_list[| cond_i];
                var tr_cond_str = string(tr_i) + " " + string(cond_i);
                
                if (quest_state[? "current_state"] != "success" && condition[? "event_based"]) {
                    cond_states[? tr_cond_str] = false;
                }
            }
        }
    }
    
    return count;
}
