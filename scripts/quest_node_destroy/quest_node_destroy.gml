/// @description quest_node_destroy(quest_id)
/// @function quest_node_destroy
/// @param quest_id
function quest_node_destroy(argument0) {
	var quest_id = argument0;

	var node, i, count, subtask_id, subtasks, subtask, transitions, state, node_props, state_props;

	node = DB.quest_nodes[? quest_id];

	count = ds_list_size(node[? "subtasks_list"]);
	subtasks = node[? "subtasks"];

	for(i = count - 1; i >= 0; i--)
	{
	    subtask_id = node[? "subtasks_list"];
	    subtask = subtasks[? "subtask_id"];
	    ds_map_destroy(subtask);
	}

	ds_map_destroy(node[? "subtasks"]);
	ds_list_destroy(node[? "subtasks_list"]);


	count = ds_list_size(node[? "state_transitions"]);

	for(i = count - 1; i >= 0; i--)
	{
	    quest_transition_destroy(node, i);
	}

	ds_list_destroy(node[? "state_transitions"]);


	count = ds_list_size(DB.quest_states);
	node_props = node[? "state_properties"];

	for(i = count - 1; i >= 0; i--)
	{
	    state = DB.quest_states[| i];
    
	    state_props = node_props[? state];
	    ds_list_of_map_destroy(state_props[? "effects"]);
	    ds_map_destroy(state_props);
	}

	ds_map_destroy(node_props);
	ds_map_destroy(node);

	ds_map_delete(DB.quest_nodes, quest_id);

	ds_list_delete(DB.quest_node_ids, ds_list_find_index(DB.quest_node_ids, quest_id));



}
