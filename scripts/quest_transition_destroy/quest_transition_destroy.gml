/// @description quest_transition_destroy(quest_id, index)
/// @function quest_transition_destroy
/// @param quest_id
/// @param  index
function quest_transition_destroy() {
	var quest_id = argument[0];
	var index = argument[1];

	var count, i, transitions, transition;
	var conditions, condition, effects, effect;

	quest_node = DB.quest_nodes[? quest_id];
	transitions = quest_node[? "state_transitions"];
	transition = transitions[| index];
	/*
	if(is_undefined(transition))
	{
	    return false;
	}
	*/
	ds_list_destroy(transition[? "from_states"]);

	ds_list_of_map_destroy(transition[? "conditions"]);

	ds_list_of_map_destroy(transition[? "effects"]);

	ds_map_destroy(transition);

	ds_list_delete(transitions, index);



}
