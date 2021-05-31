function quest_add_subtask(quest_id, subquest_id, context_id, order_index, mandatory) {
    if(string_pos(DB.quest_context_divider, context_id) > 0)
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
