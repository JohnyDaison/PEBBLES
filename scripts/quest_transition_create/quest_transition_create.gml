/// @description quest_transition_create(quest_id, from_states, to_state)
/// @function quest_transition_create
/// @param quest_id
/// @param  from_states
/// @param  to_state
function quest_transition_create() {
	var quest_id = argument[0];
	var from_str = argument[1];
	var to_str = argument[2];

	var transition, quest_node = DB.quest_nodes[? quest_id];

	transition = ds_map_create();

	transition[? "from_states"] = ds_list_create();
	string_explode(from_str, ",", transition[? "from_states"]);

	transition[? "to_state"] = to_str;

	transition[? "conditions"] = ds_list_create();
	transition[? "effects"] = ds_list_create();

	ds_list_add(quest_node[? "state_transitions"], transition);

	return transition;



}
