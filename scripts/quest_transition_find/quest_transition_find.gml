/// @description quest_transition_find(quest_node, from_states, to_state)
/// @function quest_transition_find
/// @param quest_node
/// @param from_states
/// @param to_state
function quest_transition_find() {
	var quest_node = argument[0];
	var from_str = argument[1];
	var to_str = argument[2];

	var i, transition;
	//var quest_node = DB.quest_nodes[? quest_id];
	var transitions = quest_node[? "state_transitions"];
	var count = ds_list_size(transitions);

	for(i = 0; i < count; i++)
	{
	    transition = transitions[| i];
	    if(transition[? "to_state"] == to_str)
	    {
	        return transition;
	    }
	}

	return undefined;





}
