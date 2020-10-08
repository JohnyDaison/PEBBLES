/// @description quest_item_pickup_create(quest_id, name, description)
/// @function quest_item_pickup_create
/// @param quest_id
/// @param  name
/// @param  description
/// @param  context_id
function quest_item_pickup_create(argument0, argument1, argument2, argument3) {
	var quest_id = argument0;
	var name = argument1;
	var description = argument2;
	var context_id = argument3;

	var transition, condition;

	var node = quest_node_create(quest_id, name, description);
	node[? "subtask_type"] = "item_pickup";
	node[? "target_item"] = all;
	node[? "target_color"] = -1;
	//node[? "target_amount"] = 1;

	transition = quest_transition_create(quest_id, "init", "start");
	//condition = quest_add_condition(transition, "subtask", "order");

	transition = quest_transition_create(quest_id, "nonsuccess", "success");
	condition = quest_add_condition(transition, "item", "pickup");

	return node;


}
