/// @description player_quest_state_create(player, quest_id, parent_state, context_id, category)
/// @function player_quest_state_create
/// @param player
/// @param  quest_id
/// @param  parent_state
/// @param  context_id
/// @param  category
function player_quest_state_create() {
	var player = argument[0];
	var quest_id = argument[1];
	var parent_state = argument[2];
	var context_id = argument[3];
	var category = argument[4];

	var address = "", parent_context = "", parent_quest_id = "";
	var root_context, context, count, i, quest_state, state, state_reps;
	var cond_list, cond_i, cond_count, cond_str, cond_states, condition;
	var tr_list, tr_i, tr_count, transition, tr_str, tr_cond_str;
	var quest_node, subtasks_list, subtask_id, subtasks, subtask, sub_quest_state;

	//context_id IS VALID?
	if(context_id == "" || string_pos(DB.quest_context_divider, context_id))
	{
	    return undefined;
	}

	root_context = context_id;

	if(parent_state != noone)
	{
	    address = parent_state[? "context"] + DB.quest_context_divider;
	    parent_context = parent_state[? "context"];
	    parent_quest_id = parent_state[? "quest_id"];
	    root_context = string_copy(address, 1, string_pos(DB.quest_context_divider, address)-1);
	}

	context = address + context_id;

	//context_id IS UNIQUE?
	if(ds_list_find_index(player.all_quest_list, context) != -1)
	{
	    return undefined;
	}


	//IS ROOT?
	if(string_pos(DB.quest_context_divider, context) == 0)
	{
	    ds_list_add(player.root_quest_list, context);
	}

	//ALL LIST
	ds_list_add(player.all_quest_list, context);

	// CATEGORY
	if(ds_list_find_index(player.quest_category_list, category) == -1)
	{
	    ds_list_add(player.quest_category_list, category);
	}


	quest_node = DB.quest_nodes[? quest_id];

	// STATE
	quest_state = ds_map_create();

	quest_state[? "quest_id"] = quest_id;
	quest_state[? "context_id"] = context_id;
	quest_state[? "context"] = context;
	quest_state[? "parent_context"] = parent_context;
	quest_state[? "parent_quest_id"] = parent_quest_id;
	quest_state[? "root_context"] = root_context;
	quest_state[? "category"] = category;
	quest_state[? "current_state"] = "init";
	quest_state[? "last_state"] = "init";
	quest_state[? "locked"] = true;
	quest_state[? "mandatory_subtasks_progress"] = 1;
	quest_state[? "subtasks_progress"] = 1;
	quest_state[? "selected_subtask"] = "";
	quest_state[? "transition_condition_states"] = ds_map_create();
	quest_state[? "guide_failure_limit"] = quest_node[? "guide_failure_limit"];

	// STATE REPS
	state_reps = ds_map_create();

	count = ds_list_size(DB.quest_states);

	for(i = 0; i < count; i++)
	{
	    state = DB.quest_states[| i];
    
	    state_reps[? state] = 0;
	}

	quest_state[? "state_reps"] = state_reps;

	player.quest_states[? context] = quest_state;


	// SUBSCRIBE CONDITION EVENTS

	// TRANSITIONS
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
	        cond_states[? tr_cond_str] = false;
        
	        if(condition[? "event_based"])
	        {
	            with(player)
	            {
	                subscribe_event(cond_str, condition_event_script, all, context+"|"+tr_cond_str);
	            }
	        }
	    }

	}

	// SUBTASKS
	subtasks_list = quest_node[? "subtasks_list"];
	count = ds_list_size(subtasks_list);
	subtasks = quest_node[? "subtasks"];

	for(i = 0; i < count; i++)
	{
	    subtask_id = subtasks_list[| i];
	    subtask = subtasks[? subtask_id];
    
	    sub_quest_state = player_quest_state_create(player, subtask[? "quest_id"], quest_state, subtask[? "context_id"], category);
	}

	return quest_state;



}
