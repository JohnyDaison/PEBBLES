/// @function quest_create_ability_subtasks
/// @param  parent_quest_id
/// @param  abi_id
/// @param  abi_name
/// @param  abi_color
/// @param  starting_order_index
function quest_create_ability_subtasks() {
	var quest_id = argument[0];
	var abi_id = argument[1];
	var abi_name = argument[2];
	var abi_color = argument[3];
	var starting_order_index = argument[4];

	var node, i = starting_order_index;


	// Move to Ability
	node = quest_create_subtask(quest_id, "simple_nav", "goto_" + abi_id, "Move to " + abi_name, "", i++, true);


	// Pickup Ability
	node = quest_create_subtask(quest_id, "item_pickup", "pickup_" + abi_id, "Pickup " + abi_name, "", i++, false);
	node[? "target_item"] = ability_pickup_obj;
	node[? "target_color"] = abi_color;


	// Use Ability
	node = quest_create_subtask(quest_id, "use_ability", "use_" + abi_id, "Use " + abi_name, "", i++, false);
	node[? "target_color"] = abi_color;


	return i;


}
