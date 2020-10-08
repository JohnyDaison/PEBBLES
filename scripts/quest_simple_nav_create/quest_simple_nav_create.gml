/// @description quest_simple_nav_create(quest_id, name, description, context_id)
/// @function quest_simple_nav_create
/// @param quest_id
/// @param  name
/// @param  description
/// @param  context_id
function quest_simple_nav_create(argument0, argument1, argument2, argument3) {
	var quest_id = argument0;
	var name = argument1;
	var description = argument2;
	var context_id = argument3;

	var transition, condition;

	var node = quest_node_create(quest_id, name, description);
	node[? "subtask_type"] = "simple_nav";

	transition = quest_transition_create(quest_id, "nonsuccess", "start");
	condition = quest_add_condition(transition, "zone", "enter", context_id + "/start");

	transition = quest_transition_create(quest_id, "nonsuccess", "success");
	condition = quest_add_condition(transition, "zone", "enter", context_id + "/success");

	transition = quest_transition_create(quest_id, "nonsuccess", "failure");
	condition = quest_add_condition(transition, "zone", "enter", context_id + "/failure");

	return node;


}
