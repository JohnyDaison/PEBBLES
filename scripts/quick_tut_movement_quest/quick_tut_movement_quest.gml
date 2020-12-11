function quick_tut_movement_quest() {
	var transition, condition;

	// LVL1 Mountain-side quest
	var quest_id = "quick_tutorial_movement";

	quest_node_create(quest_id, "Jump, jump, jump!", "Learn how to get around");
                                        
	transition = quest_transition_create(quest_id, "active", "success");
	condition = quest_add_condition(transition, "subtasks", "success");

	var i=1, node;

	// Skip me (fix for Welcome, is still needed?)
	node = quest_create_subtask(quest_id, "simple_condition", "skip", "Skip", "", i++, true);

	// Welcome
	node = quest_create_subtask(quest_id, "simple_time_delay", "welcome", "Welcome", "", i++, true);
	node[? "from_start"] = 7*60;

	// Intro
	node = quest_create_subtask(quest_id, "simple_time_delay", "intro", "Intro", "", i++, true);
	node[? "from_start"] = 9*60;

	// Intro_exit
	node = quest_create_subtask(quest_id, "simple_time_delay", "intro_exit", " Intro Exit", "", i++, true);
	node[? "from_start"] = 11.5*60;
	node[? "display_group"] = "run";

	transition = quest_transition_find(node, "", "start");
	condition = quest_add_condition(transition, "trigger", "displays");

	transition = quest_transition_create(quest_id + "_" + "intro_exit", "nonsuccess", "success");
	condition = quest_add_condition(transition, "zone", "enter", "intro_exit/success");

	// Jump
	quest_create_subtask(quest_id, "simple_nav", "jump", "Jump", "", i++, true);

	// Climb
	node = quest_create_subtask(quest_id, "simple_nav_reached_start", "climb", "Climb", "", i++, true);

	// Pickup Jump Suit
	node = quest_create_subtask(quest_id, "item_pickup", "jump_suit_pickup", "Jump suit pickup", "", i++, true);
	node[? "target_item"] = jump_suit_item_obj;

	// Charged jump up
	quest_create_subtask(quest_id, "simple_nav", "charged_jump_up", "Charged jump: Up", "", i++, true);

	// Charged jump run
	quest_create_subtask(quest_id, "simple_nav", "charged_jump_run", "Running Charged jump", "", i++, true);

	// Wall climb
	quest_create_subtask(quest_id, "simple_nav", "wall_climb", "Climb the wall", "", i++, true);

	// Wall jump
	quest_create_subtask(quest_id, "simple_nav", "wall_jump", "Wall Jump", "", i++, false);
    
    // Impact mechanic
	quest_create_subtask(quest_id, "simple_nav", "impact_mechanic", "Impact mechanic", "", i++, true);
    
    // Get to Dive Jump
	quest_create_subtask(quest_id, "simple_nav", "get_to_dive_jump", "Get to Dive Jump", "", i++, true);

	// Dive Jump
	quest_create_subtask(quest_id, "simple_nav", "dive_jump", "Dive Jump", "", i++, true);

	// Exit level
	node = quest_create_subtask(quest_id, "simple_nav", "exit_level", "Exit level", "", i++, true);


}
