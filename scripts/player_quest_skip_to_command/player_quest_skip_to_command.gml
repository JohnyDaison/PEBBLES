/// @param {Real} player_number
/// @param {Real} skip_to_quest
function player_quest_skip_to_command(player_number, skip_to_quest) {
    if(!instance_exists(gamemode_obj)) {
        return 0;
    }

    var player = gamemode_obj.players[? player_number];

    if(is_undefined(player)) {
        return 0;
    }

    var quest_state = player_quest_state_find(player, "", "", "main");

    if (is_undefined(quest_state)) {
        return 0;
    }

    var quest_id = quest_state[? "quest_id"];
    var context = quest_state[? "context"];
    var quest_node = DB.quest_nodes[? quest_id];

    var subtasks_list, subtask_count, subtasks, subtask_state, subtask, subtask_node, context_id, sub_i;
    var subtask_state, mandatory_subtask_chosen, subtask_chosen, subtasks_progress, mandatory_subtasks_progress;
    var subtasks_unskipped_todo, last_subtask;

    subtasks_list = quest_node[? "subtasks_list"];
    subtask_count = ds_list_size(subtasks_list);
    subtasks = quest_node[? "subtasks"];

    subtask_chosen = "";
    mandatory_subtask_chosen = "";
    subtasks_progress = quest_state[? "subtasks_progress"];
    mandatory_subtasks_progress = quest_state[? "mandatory_subtasks_progress"]
    subtasks_unskipped_todo = 0;

    for(sub_i = 0; sub_i < subtask_count; sub_i++) {
        context_id = subtasks_list[| sub_i];
        subtask_state = player.quest_states[? context + DB.quest_context_divider + context_id];
        subtask = subtasks[? context_id];
        subtask_node = DB.quest_nodes[? (subtask_state[? "quest_id"])];
                    
        if(sub_i == subtask_count-1) {
            last_subtask = subtask;
        }
        
        if(subtask[? "order_index"] < skip_to_quest) {
            if(subtask_node[? "subtask_type"] == "item_pickup") {
                auto_pickup_quest_item(player, subtask_node);
            }
            
            subtask_state[? "current_state"] = "success";
            
            if(mandatory_subtasks_progress < subtask[? "order_index"]) {
                mandatory_subtasks_progress = subtask[? "order_index"];
            }
            
            subtask_chosen = context_id;
            
            continue;
        }
        
        if(subtask[? "order_index"] == skip_to_quest) {
            if(mandatory_subtask_chosen == "") {
                subtask_state[? "current_state"] = "start";
                
                if(subtask_chosen == "" || subtasks_unskipped_todo == 0) {
                    subtask_chosen = context_id;
                    subtasks_progress = subtask[? "order_index"];
                }
                
                if(subtask[? "mandatory"]) {
                    mandatory_subtask_chosen = context_id;
                    if(mandatory_subtasks_progress < subtask[? "order_index"]) {
                        mandatory_subtasks_progress = subtask[? "order_index"];
                    }
                }
            }
            
            subtasks_unskipped_todo++;
        }
    }

    // SAVE RESULT
    quest_state[? "subtasks_progress"] = subtasks_progress;
    quest_state[? "mandatory_subtasks_progress"] = mandatory_subtasks_progress;
    
    if(mandatory_subtask_chosen != "") {
        quest_state[? "selected_subtask"] = mandatory_subtask_chosen;
    } else if(subtask_chosen != "") {
        quest_state[? "selected_subtask"] = subtask_chosen;
    }

    // RETURN PROGRESS
    return subtasks_progress;
}
