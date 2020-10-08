/// @description player_quest_state_printout(player, context, [level, level_of_detail])
/// @function player_quest_state_printout
/// @param player
/// @param context
/// @param [level]
/// @param [level_of_detail]
function player_quest_state_printout() {
	var player = argument[0];
	var context = argument[1];
	var level = 1;
	var level_of_detail = 2;

	if(argument_count > 2)
	{
	    level = argument[2];
	}

	if(argument_count > 3)
	{
	    level_of_detail = argument[3];
	}

	var quest_state, quest_id, quest_node, i, offset_str = "", index_str = "", state_str, parent_id, parent_node; 
	var subtasks_list, subtask_count, sub_i, subtasks, subtask_id, subtask;

	// LEVEL 0
	if(level_of_detail <= 0)
	{
	    return "";
	}

	// OFFSET
	i = level;

	while(i--)
	{
	    offset_str += "  ";
	}

	// INDEX
	quest_state = player.quest_states[? context];
	quest_id = quest_state[? "quest_id"];
	quest_node = DB.quest_nodes[? quest_id];
	parent_id = quest_state[? "parent_quest_id"]

	if(parent_id != "")
	{
	    parent_node = DB.quest_nodes[? parent_id];    
	    subtasks = parent_node[? "subtasks"];
	    subtask = subtasks[? (quest_state[? "context_id"])];
	    index_str = string(subtask[? "order_index"]) + " ";
	}

	// LEVEL 1
	if(level_of_detail >= 1)
	{
	    if(level == 1)
	    {
	        my_console_write(offset_str + "------------------------");        
	    }
    
	    if(level_of_detail == 1)
	    {
	        my_console_write(string(player.number) + " " + player.name);        
	    }

	    my_console_write(offset_str + index_str + quest_node[? "name"]);
	    my_console_write(offset_str + quest_node[? "subtask_type"]);
	    my_console_write(offset_str + quest_node[? "description"]);
    
	    state_str = offset_str;
    
	    if(level == 1)
	    {
	        if(quest_node[? "mandatory"])
	        {
	            state_str += "mandatory";
	        }
	        else
	        {
	            state_str += "optional";
	        }
	    }
	    else if(level > 1)
	    {
	        if(subtask[? "mandatory"])
	        {
	            state_str += "mandatory";
	        }
	        else
	        {
	            state_str += "optional";
	        }
	    }
    
	    state_str += "|" + quest_state[? "current_state"];
    
	    my_console_write(state_str);
    
	    var cond_states = quest_state[? "transition_condition_states"];
	    var key = ds_map_find_first(cond_states);
	    var cond_str = "";
	    while(!is_undefined(key))
	    {
	        cond_str += "|" + string(key) + ":" + string(cond_states[? key]);
	        key = ds_map_find_next(cond_states, key);
	    }
	    my_console_write(offset_str + cond_str);
    
	    var cur_reps = quest_state[? "state_reps"];
	    var rep_str = "";
	    var count = ds_list_size(DB.quest_states);
	    var state;
	    for (i = 0; i < count; i++)
	    {
	        state = DB.quest_states[| i];
	        rep_str += "|" + state + ":" + string(cur_reps[? state]);
	    }
	    my_console_write(offset_str + rep_str);
	    my_console_write("");
    
	    //SUBTASKS
	    if(level == 1)
	    {
	        my_console_write(offset_str + "subtask progress: " + string(quest_state[? "mandatory_subtasks_progress"]) + "|" + string(quest_state[? "subtasks_progress"]) + ", selected: " + string(quest_state[? "selected_subtask"]));
	        my_console_write("");
	    }
	}

	// LEVEL 2
	if(level_of_detail >= 2)
	{
	    //SUBTASKS
	    subtasks_list = quest_node[? "subtasks_list"];
	    subtask_count = ds_list_size(subtasks_list);
	    subtasks = quest_node[? "subtasks"];
    
	    for(sub_i = 0; sub_i < subtask_count; sub_i++)
	    {
	        subtask_id = subtasks_list[| sub_i];
	        //subtask = subtasks[? subtask_id];
        
	        player_quest_state_printout(player,  context + DB.quest_context_divider + subtask_id, 
	                                    level + 1,  max(0, level_of_detail - 1));
	    }
	}



}
