/// @description quest_add_subtask(quest_id, subquest_id, context_id, order_index, mandatory);
/// @function quest_add_subtask
/// @param quest_id
/// @param  subquest_id
/// @param  context_id
/// @param  order_index
/// @param  mandatory
function quest_add_subtask() {
	var quest_id = argument[0];
	var subquest_id = argument[1];
	var context_id = argument[2];
	var order_index = argument[3];
	var mandatory = argument[4];

	if(string_pos(DB.quest_context_divider, context_id))
	{
	    return false;
	}

	var quest_node = DB.quest_nodes[? quest_id], 
	    subtasks = quest_node[? "subtasks"],
	    subtask;

	if(ds_list_find_index(quest_node[? "subtasks_list"], context_id) == -1)
	{
	    subtask = ds_map_create();
	    subtask[? "parent_id"] = quest_id;
	    subtask[? "quest_id"] = subquest_id;
	    subtask[? "context_id"] = context_id;
	    subtask[? "order_index"] = order_index;
	    subtask[? "mandatory"] = mandatory;
    
	    subtasks[? context_id] = subtask;
    
	    ds_list_add(quest_node[? "subtasks_list"], context_id);
	}



}
