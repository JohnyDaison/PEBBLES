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

    // Pickup Charged Jump
    node = quest_create_subtask(quest_id, "item_pickup", "charged_jump_pickup", "Charged Jump pickup", "", i++, true);
    node[? "target_item"] = charged_jump_item_obj;
    
    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");

    // Charged jump up
    node = quest_create_subtask(quest_id, "simple_nav_reached_start", "charged_jump_up", "Charged jump: Up", "", i++, true);
    node[? "display_group"] = "charged_jump_up";
    
    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "trigger", "displays");
    
    // Pickup Double Jump
    node = quest_create_subtask(quest_id, "item_pickup", "double_jump_pickup", "Double Jump pickup", "", i++, true);
    node[? "target_item"] = pulse_booster_item_obj;
    
    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");
    
    // Double jump
    node = quest_create_subtask(quest_id, "simple_nav_reached_start", "double_jump", "Double jump", "", i++, true);
    node[? "display_group"] = "double_jump";
    
    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "trigger", "displays");

    // Charged jump run
    quest_create_subtask(quest_id, "simple_nav", "charged_jump_run", "Running Charged jump", "", i++, true);
    
    // Pickup Wall climb
    node = quest_create_subtask(quest_id, "item_pickup", "wall_climb_pickup", "Wall Climb pickup", "", i++, true);
    node[? "target_item"] = wallclimb_item_obj;
    
    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");
    
    // Wall climb
    node = quest_create_subtask(quest_id, "simple_nav_reached_start", "wall_climb", "Climb the wall", "", i++, true);
    node[? "display_group"] = "wall_climb";
    
    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "trigger", "displays");

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
