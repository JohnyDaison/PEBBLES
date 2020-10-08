/// @description  RESET TRANSITION CONDITIONS AND RECHECK QUESTS
var context, quest_state, quest_id, quest_node;
var tr_list, tr_i, tr_count, transition,;
var cond_list, cond_i, cond_count, tr_cond_str, cond_states;

var i, count = ds_list_size(all_quest_list);

for(i = 0; i < count; i++)
{
    context = all_quest_list[| i];
    quest_state = quest_states[? context];
    quest_id = quest_state[? "quest_id"];
    quest_node = DB.quest_nodes[? quest_id];
    cond_states = quest_state[? "transition_condition_states"];
    
    tr_list = quest_node[? "state_transitions"];
    tr_count = ds_list_size(tr_list);
    
    for(tr_i = 0; tr_i < tr_count; tr_i++)
    {
        transition = tr_list[| tr_i];
        
        cond_list = transition[? "conditions"];
        cond_count = ds_list_size(cond_list);
    
        for(cond_i = 0; cond_i < cond_count; cond_i++)
        {
            condition = cond_list[| cond_i];
            tr_cond_str = string(tr_i) + " " + string(cond_i);
            
            if(quest_state[? "current_state"] != "success" && condition[? "event_based"])
            {
                cond_states[? tr_cond_str] = false;
            }
        }
    }

}

if(singleton_obj.step_count - last_quests_recheck >= quest_recheck_delay)
{
    player_quests_recheck(id);
}
