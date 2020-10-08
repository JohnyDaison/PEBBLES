/// @description player_quest_state_destroy(player, context)
/// @function player_quest_state_destroy
/// @param player
/// @param  context
function player_quest_state_destroy() {
	var player = argument[0];
	var context = argument[1];

	var quest_state = player.quest_states[? context];
	var root_index = ds_list_find_index(player.root_quest_list, context);

	//SUBTASKS
	var quest_id = quest_state[? "quest_id"];
	var quest_node = DB.quest_nodes[? quest_id];
	var subtasks_list = quest_node[? "subtasks_list"];
	var i, count = ds_list_size(subtasks_list);
	var subtasks = quest_node[? "subtasks"];

	for(i = count-1; i >= 0; i--)
	{
	    var subtask_id = subtasks_list[| i];
	    //subtask = subtasks[? subtask_id];
    
	    player_quest_state_destroy(player, context + DB.quest_context_divider + subtask_id);
	}

	// MAIN TASK

	// TRANSITIONS - UNSUBCRIBE CONDITIONS
	var cond_list, cond_i, cond_count, cond_str, cond_states, condition;
	var tr_list, tr_i, tr_count, transition, tr_str, tr_cond_str;

	tr_list = quest_node[? "state_transitions"];
	tr_count = ds_list_size(tr_list);
	cond_states = quest_state[? "transition_condition_states"];

	for(tr_i = 0; tr_i < tr_count; tr_i++)
	{
	    transition = tr_list[| tr_i];
    
	    cond_list = transition[? "conditions"];
	    cond_count = ds_list_size(cond_list);

	    for(cond_i = 0; cond_i < cond_count; cond_i++)
	    {
	        condition = cond_list[| cond_i];
	        cond_str = condition[? "type"] + "_" + condition[? "verb"];
	        tr_cond_str = string(tr_i) + " " + string(cond_i);        
        
	        if(condition[? "event_based"])
	        {
	            with(player)
	            {
	                unsubscribe_event(cond_str, condition_event_script, all);
	            }
	        }
	    }

	}

	// DESTROY
	if(root_index != -1)
	{
	    ds_list_delete(player.root_quest_list, root_index);
	}
	ds_list_delete(player.all_quest_list, ds_list_find_index(player.all_quest_list, context));

	ds_map_destroy(quest_state[? "transition_condition_states"]);
	ds_map_destroy(quest_state[? "state_reps"]);
	ds_map_destroy(quest_state);
	ds_map_delete(player.quest_states, context);




}
