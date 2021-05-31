function quest_node_create(quest_id, name, description) {
    var node = noone, node_props, state_props, i, count, state;

    if(is_string(quest_id) && quest_id != "")
    {
        if(!is_undefined(DB.quest_nodes[? quest_id]))
        {
            return false;
        }
    
        node = ds_map_create();
        node[? "quest_id"] = quest_id;
        node[? "name"] = name;
        node[? "description"] = description;
        node[? "subtask_type"] = "";
        node[? "state_properties"] = ds_map_create();
        node_props = node[? "state_properties"];
    
    
        DB.quest_nodes[? quest_id] = node;
        ds_list_add(DB.quest_node_ids, quest_id);
    
    
        count = ds_list_size(DB.quest_states);

        for(i = 0; i < count; i++)
        {
            state = DB.quest_states[| i];
        
            node_props[? state] = ds_map_create();
        
            state_props = node_props[? state];
        
            state_props[? "min_reps"] = 0;
            if(state == "success")
            {
                state_props[? "min_reps"] = 1;
            }
        
            state_props[? "max_reps"] = -1;
            state_props[? "effects"] = ds_list_create();
        }
    
        node[? "state_transitions"] = ds_list_create();
    
        quest_transition_create(quest_id, "start", "active");
    
        node[? "subtasks_list"] = ds_list_create();
        node[? "subtasks"] = ds_map_create();
    
        node[? "guide_failure_limit"] = -1;
    }

    return node;
}
