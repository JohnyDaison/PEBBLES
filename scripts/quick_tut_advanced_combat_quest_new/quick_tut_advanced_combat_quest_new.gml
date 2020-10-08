function quick_tut_advanced_combat_quest_new() {
	var transition, condition;

	// LVL5 Advanced Combat quest
	var quest_id = "quick_tutorial_advanced_combat_new";

	quest_node_create(quest_id, "Advanced combat", "Woooosh! Wooosh! Woosh!");
                                        
	transition = quest_transition_create(quest_id, "active", "success");
	condition = quest_add_condition(transition, "subtasks", "success");

	var i=1, node;


	// Red body
	node = quest_create_subtask(quest_id, "simple_condition", "pass_red_filter", "Pass Red filter", "", i++, true);

	transition = quest_transition_find(node, "", "success");
	condition = quest_add_condition(transition, "zone", "enter", "pass_red_filter/success");


	// Dark body
	node = quest_create_subtask(quest_id, "simple_condition", "dark_color_body", "Dark body", "", i++, true);
	//node[? "display_group"] = "turn_dark";

	transition = quest_transition_find(node, "", "start");
	condition = quest_add_condition(transition, "subtask", "reached");
	//condition = quest_add_condition(transition, "trigger", "displays");

	transition = quest_transition_find(node, "", "success");
	condition = quest_add_condition(transition, "my_body_color", "change");
	condition[? "body_color"] = g_black;


	// Pickup Card using Vortex
	node = quest_create_subtask(quest_id, "item_pickup", "card1_pickup", "Vortex", "", i++, true);
	node[? "target_item"] = access_card_obj;
	node[? "display_group"] = "dark_shot";

	transition = quest_transition_find(node, "", "start");
	condition = quest_add_condition(transition, "subtask", "reached");
	condition = quest_add_condition(transition, "trigger", "displays");


	// Knockdown the dummy with Vortex
	node = quest_create_subtask(quest_id, "simple_condition", "dummy_vortex_knockdown", "Vortex the dummy", "", i++, true);
	node[? "knockdown_target"] = basic_bot;
	node[? "target_color"] = -1;

	transition = quest_transition_find(node, "", "start");
	condition = quest_add_condition(transition, "subtask", "reached");
	transition = quest_transition_find(node, "", "success");
	condition = quest_add_condition(transition, "vortex", "knockdown");


	// Pickup Shield using Vortex
	node = quest_create_subtask(quest_id, "item_pickup", "shield_pickup", "Vortex", "", i++, true);
	node[? "target_item"] = shield_item_obj;

	transition = quest_transition_find(node, "", "start");
	condition = quest_add_condition(transition, "subtask", "reached");


	// Shield yourself
	node = quest_create_subtask(quest_id, "simple_nav_reached_start", "shield_yourself", "Shield yourself", "", i++, true);
	node[? "display_group"] = "shield";

	transition = quest_transition_find(node, "", "start");
	condition = quest_add_condition(transition, "trigger", "displays");


	// Color sheet
	node = quest_create_subtask(quest_id, "simple_nav", "color_sheet", "Color sheet", "", i++, true);


	// Gate 90
	node = quest_create_subtask(quest_id, "simple_nav_reached_start", "gate_90", "Gate 90", "", i++, true);


	// Open Gate Up
	node = quest_create_subtask(quest_id, "simple_condition", "open_gate_up", "Open Gate Up", "", i++, true);

	transition = quest_transition_find(node, "", "start");
	condition = quest_add_condition(transition, "zone", "enter", "open_gate_up/start");
	transition = quest_transition_find(node, "", "success");
	condition = quest_add_condition(transition, "gatezone", "close", "open_gate_up");


	// Grenades aim
	node = quest_create_subtask(quest_id, "simple_nav_reached_start", "grenades_aim", "Grenades aim", "", i++, true);


	// White Pad
	node = quest_create_subtask(quest_id, "simple_nav", "white_pad", "White Pad", "", i++, true);

	// Capture Base Crystal
	node = quest_create_subtask(quest_id, "simple_condition", "capture_base_crystal", "Capture Base Crystal", "", i++, true);
	node[? "spawner_group"] = "base_crystal";

	transition = quest_transition_find(node, "", "start");
	condition = quest_add_condition(transition, "zone", "enter", "capture_base_crystal");
	condition = quest_add_condition(transition, "trigger", "spawners");
	transition = quest_transition_find(node, "", "success");
	condition = quest_add_condition(transition, "zone", "enter", "capture_base_crystal");

	// Crystal
	node = quest_create_subtask(quest_id, "simple_nav", "crystal", "Crystal", "", i++, true);
	/*node[? "display_group"] = "crystal";

	transition = quest_transition_find(node, "", "start");
	condition = quest_add_condition(transition, "trigger", "displays");
	*/


	// Cannon orbs
	node = quest_create_subtask(quest_id, "simple_nav", "cannon_orbs", "Cannon orbs", "", i++, false);


	// Cannon shoot
	node = quest_create_subtask(quest_id, "simple_nav", "cannon_shoot", "Cannon shoot", "", i++, false);


	// Last fight
	node = quest_create_subtask(quest_id, "simple_nav", "last_fight", "Last fight", "", i++, true);


	// Exit level
	node = quest_create_subtask(quest_id, "simple_nav", "exit_level", "Exit level", "", i++, true);




}
