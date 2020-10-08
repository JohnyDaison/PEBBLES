function movement_mountain_quest() {
	var transition, condition;

	// LVL1 Mountain-side quest
	quest_node_create("tutorial_movement", "Scaling the mountain", "Learn how to get around");
                                        
	transition = quest_transition_create("tutorial_movement", "active", "success");
	condition = quest_add_condition(transition, "subtasks", "success");

	var i=1, node;

	// Welcome
	quest_create_subtask("tutorial_movement", "simple_nav", "welcome", "Welcome", "", i++, true);

	// First jump
	quest_create_subtask("tutorial_movement", "simple_nav", "first_jump", "First jump", "", i++, true);

	// Second jump
	quest_create_subtask("tutorial_movement", "simple_nav", "second_jump", "Second jump", "", i++, true);

	// Get double jump
	quest_create_subtask("tutorial_movement", "simple_nav", "doublejump_pickup", "Get the Jump Jet", "", i++, true);

	// Double jump
	quest_create_subtask("tutorial_movement", "simple_nav", "double_jump", "Double jump", "", i++, true);

	// Double jump up
	quest_create_subtask("tutorial_movement", "simple_nav", "double_jump_up", "Double jump up", "", i++, true);

	// Double jump
	quest_create_subtask("tutorial_movement", "simple_nav", "double_jump2", "Double jump 2", "", i++, true);

	// Drop jump
	quest_create_subtask("tutorial_movement", "simple_nav", "drop_jump", "Drop jump", "", i++, true);

	// Triple jump
	quest_create_subtask("tutorial_movement", "simple_nav", "triple_jump", "Triple jump", "", i++, true);

	// Charged jump
	quest_create_subtask("tutorial_movement", "simple_nav", "charged_jump", "Charged jump", "", i++, true);

	// Charged jump up
	quest_create_subtask("tutorial_movement", "simple_nav", "charged_jump_up", "Charged jump up", "", i++, true);

	// Gloves pickup
	quest_create_subtask("tutorial_movement", "simple_nav", "gloves_pickup", "Pick up Gloves", "", i++, true);

	// Wall climb
	quest_create_subtask("tutorial_movement", "simple_nav", "wall_climb", "Wall-Climb", "", i++, true);

	// Reach wall jump
	quest_create_subtask("tutorial_movement", "simple_nav", "reach_wall_jump", "Reach Wall Jump", "", i++, true);

	// Wall jump
	node = quest_create_subtask("tutorial_movement", "simple_nav", "wall_jump", "Wall Jump", "", i++, true);
	node[? "guide_failure_limit"] = 1;

	// Reach jump pad
	quest_create_subtask("tutorial_movement", "simple_nav", "reach_jump_pad", "Reach Jump pad", "", i++, true);

	// Use jump pad
	quest_create_subtask("tutorial_movement", "simple_nav", "use_jump_pad", "Use Jump pad", "", i++, true);

	// Reach exit
	quest_create_subtask("tutorial_movement", "simple_nav", "reach_exit", "Exit", "", i++, true);



}
