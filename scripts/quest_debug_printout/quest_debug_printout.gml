/// @description quest_debug_printout([string])
/// @function quest_debug_printout
/// @param [string]
function quest_debug_printout() {
	var filter_str = "";
	if(argument_count > 0)
	{
	    filter_str = argument[0];
	}

	var i, quest_count, filtered_count = 0, quest_id, quest_node;
	var tr_list, tr_i, tr_count, transition, tr_str;
	var state_list, state_i, state_count, from_str, cond_list, cond_i, cond_count, cond_str, condition;
	var sub_i, subtasks_list, subtask_count, context_id, subtasks, subtask;

	quest_count = ds_list_size(DB.quest_node_ids);

	my_console_write("--------------------------------------");
	my_console_write("QUESTS TOTAL: " + string(quest_count));

	for(i = 0; i < quest_count; i++)
	{
	    quest_id = DB.quest_node_ids[| i];
    
	    if(filter_str != "" && string_pos(filter_str, quest_id) == 0)
	    {
	        continue;
	    }
    
	    quest_node = DB.quest_nodes[? quest_id];
    
	    // HEADER
	    my_console_write("--------------------------------------");
	    my_console_write(string(i) + " - " + quest_id);
    
	    my_console_write("Name: " + quest_node[? "name"]);
	    my_console_write("Description: " + quest_node[? "description"]);
    
	    // TRANSITIONS
	    tr_list = quest_node[? "state_transitions"];
	    tr_count = ds_list_size(tr_list);

	    my_console_write("transitions: "+ string(tr_count));
        
	    for(tr_i = 0; tr_i < tr_count; tr_i++)
	    {
	        transition = tr_list[| tr_i];
	        tr_str = "";
        
	        // FROM STATES
	        state_list = transition[? "from_states"];
	        state_count = ds_list_size(state_list);
	        from_str = "";
        
	        for(state_i = 0; state_i < state_count; state_i++)
	        {
	            if(from_str != "")
	                from_str += ", ";
	            from_str += state_list[| state_i];
	        }
        
	        // CONDITIONS
	        cond_list = transition[? "conditions"];
	        cond_count = ds_list_size(cond_list);
        
	        cond_str = "";
	        for(cond_i = 0; cond_i < cond_count; cond_i++)
	        {
	            condition = cond_list[| cond_i];
            
	            if(cond_str != "")
	                cond_str += " & ";
            
	            cond_str += condition[? "type"] + " " + condition[? "verb"];
	        }
        
	        tr_str = string(tr_i) + " FROM " + from_str + " TO " + transition[? "to_state"];
	        if(cond_count > 0)
	        {
	            tr_str += " IF " + cond_str;
	        }
        
	        my_console_write(tr_str);
	    }
    
	    // SUBTASKS
	    subtasks_list = quest_node[? "subtasks_list"];
	    subtask_count = ds_list_size(subtasks_list);
	    subtasks = quest_node[? "subtasks"];
    
	    my_console_write("subtasks: "+ string(subtask_count));
    
	    for(sub_i = 0; sub_i < subtask_count; sub_i++)
	    {
	        context_id = subtasks_list[| sub_i];
	        subtask = subtasks[? context_id];
	        var mand_str = "";
	        if(!subtask[? "mandatory"])
	        {
	            mand_str = " O";
	        }
	        my_console_write(context_id + ": " + subtask[? "quest_id"] + "(" + string(subtask[? "order_index"]) + mand_str + ")");
	    }
    
	    // BLANK LINE
	    my_console_write("");
    
	    filtered_count++;
	}

	my_console_write("DISPLAYED: " + string(filtered_count) + " of " + string(quest_count));

	return filtered_count;



}
