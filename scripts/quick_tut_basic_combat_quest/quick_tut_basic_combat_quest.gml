function quick_tut_basic_combat_quest() {
	var transition, condition, node;
	var i=1;

	// LVL4 Quick Combat quest
	var quest_id = "quick_tutorial_basic_combat";

	quest_node_create(quest_id, "Basic Combat", "Getting Offensive");
                                        
	transition = quest_transition_create(quest_id, "active", "success");
	condition = quest_add_condition(transition, "subtasks", "success");



	// 1 Climb the tower
	node = quest_create_subtask(quest_id, "simple_nav", "climb_tower", "Climb the tower", "", i++, true);


	// 2 Use the Recharge pad
	node = quest_create_subtask(quest_id, "simple_condition", "recharge_pad", "Use the Recharge pad", "", i++, false);

	transition = quest_transition_find(node, "", "start");
	condition = quest_add_condition(transition, "subtask", "reached");
	transition = quest_transition_find(node, "", "success");
	condition = quest_add_condition(transition, "zone", "enter", "recharge_pad/success");


	// 3 Approach Barrage
	node = quest_create_subtask(quest_id, "simple_nav", "approach_barrage", "Approach Barrage", "", i++, true);


	// 4 Barrage pickup
	node = quest_create_subtask(quest_id, "item_pickup", "barrage_pickup", "Barrage pickup", "", i++, true);
	node[? "target_item"] = barrage_item_obj;


	// 5 Barrage Shot
	node = quest_create_subtask(quest_id, "simple_destroy_target", "barrage_shot", "Barrage shot", "", i++, false);
	node[? "destroy_target"] = spitter_body_obj;

	transition = quest_transition_find(node, "", "start");
	condition = quest_add_condition(transition, "subtask", "reached");


	// 6 Approach Channeling
	node = quest_create_subtask(quest_id, "simple_nav", "approach_channeling", "Approach Channeling", "", i++, true);


	// 7 Channeling pickup
	node = quest_create_subtask(quest_id, "item_pickup", "channeling_pickup", "Channeling pickup", "", i++, true);
	node[? "target_item"] = channeling_item_obj;


	// 8 Channeling
	node = quest_create_subtask(quest_id, "simple_condition", "channeling", "Channeling", "", i++, false);

	transition = quest_transition_find(node, "", "start");
	condition = quest_add_condition(transition, "subtask", "reached");
	transition = quest_transition_find(node, "", "success");
	condition = quest_add_condition(transition, "channel", "duration");
	condition[? "duration"] = 120;


	// 9 Reach Dash-Wave
	node = quest_create_subtask(quest_id, "simple_nav", "reach_dashwave", "Reach Dash-Wave", "", i++, true);


	// 10 Reach2 Dash-Wave
	node = quest_create_subtask(quest_id, "simple_nav", "reach2_dashwave", "Reach2 Dash-Wave", "", i++, true);


	// 11 Reach3 Dash-Wave
	node = quest_create_subtask(quest_id, "simple_condition", "reach3_dashwave", "Reach3 Dash-Wave", "", i++, true);

	transition = quest_transition_find(node, "", "start");
	condition = quest_add_condition(transition, "zone", "enter", "reach3_dashwave");
	transition = quest_transition_find(node, "", "success");
	condition = quest_add_condition(transition, "zone", "enter", "reach3_dashwave");


	// 12 Dash-Wave pickup
	node = quest_create_subtask(quest_id, "item_pickup", "dashwave_pickup", "Dash-Wave pickup", "", i++, true);
	node[? "target_item"] = dashwave_item_obj;
	node[? "display_group"] = "dashwave";

	transition = quest_transition_find(node, "", "start");
	condition = quest_add_condition(transition, "trigger", "displays");


	// 13 Dash-Wave Shot
	node = quest_create_subtask(quest_id, "simple_destroy_target", "dashwave_shot", "Dash-Wave shot", "", i++, false);
	node[? "destroy_target"] = basic_bot;

	transition = quest_transition_find(node, "", "start");
	condition = quest_add_condition(transition, "subtask", "reached");


	// 14 Reach Sprinkler
	node = quest_create_subtask(quest_id, "simple_nav", "reach_sprinkler", "Reach Sprinkler", "", i++, true);

	// TODO: Add extra quest to say Meet Sprinkler, so that kill can be not mandatory

	// 15 Kill Sprinkler
	node = quest_create_subtask(quest_id, "simple_destroy_target", "kill_sprinkler", "Kill Sprinkler", "", i++, true);
	node[? "destroy_target"] = sprinkler_body_obj;

	transition = quest_transition_find(node, "", "start");
	condition = quest_add_condition(transition, "subtask", "reached");


	// 16 Open the Gate
	node = quest_create_subtask(quest_id, "simple_condition", "open_gate", "Open the Gate", "", i++, false);

	transition = quest_transition_find(node, "", "start");
	condition = quest_add_condition(transition, "subtask", "reached");
	transition = quest_transition_find(node, "", "success");
	condition = quest_add_condition(transition, "my_body_color", "change");
	condition[? "body_color"] = g_octarine; // non successable


	// 17 Exit level
	node = quest_create_subtask(quest_id, "simple_nav", "exit_level", "Exit level", "", i++, true);



}
