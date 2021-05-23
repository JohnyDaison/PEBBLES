function quick_tut_abilities_quest() {
    var transition, condition;

    // LVL6 Abilities quest
    var quest_id = "quick_tutorial_abilities";

    quest_node_create(quest_id, "Abilities", "The crazy things you can do.");
                                        
    transition = quest_transition_create(quest_id, "active", "success");
    condition = quest_add_condition(transition, "subtasks", "success");

    var i=1, node;


    // Intro
    node = quest_create_subtask(quest_id, "simple_nav", "intro", "Intro", "", i++, true);


    // Pickup Heal
    node = quest_create_subtask(quest_id, "item_pickup", "pickup_heal", "Get Heal", "", i++, true);
    node[? "target_item"] = ability_pickup_obj;
    node[? "target_color"] = g_green;


    // Use Heal
    node = quest_create_subtask(quest_id, "use_ability", "use_heal", "Use Heal", "", i++, true);
    node[? "target_color"] = g_green;
    node[? "display_group"] = "use_ability";
    
    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "trigger", "displays");


    // Move to Invisibility

    node = quest_create_subtask(quest_id, "simple_condition", "goto_invis", "Move to Invisibility", "", i++, true);
    node[? "display_group"] = "clear";

    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");

    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "zone", "enter", "goto_invis/success");
    condition = quest_add_condition(transition, "trigger", "displays");

    // Pickup Invisibility
    node = quest_create_subtask(quest_id, "item_pickup", "pickup_invis", "Get Invisibility", "", i++, false);
    node[? "target_item"] = ability_pickup_obj;
    node[? "target_color"] = g_cyan;


    // Use Invisibility
    node = quest_create_subtask(quest_id, "use_ability", "use_invis", "Use Invisibility", "", i++, false);
    node[? "target_color"] = g_cyan;


    i = quest_create_ability_subtasks(quest_id, "berserk", "Berserk", g_red, i);

    i = quest_create_ability_subtasks(quest_id, "haste", "Haste", g_yellow, i);

    i = quest_create_ability_subtasks(quest_id, "ubershield", "Ubershield", g_magenta, i);

    i = quest_create_ability_subtasks(quest_id, "rewind", "Rewind", g_dark, i);

    i = quest_create_ability_subtasks(quest_id, "teleport", "Blink", g_blue, i);

    // Blink Rush_a
    node = quest_create_subtask(quest_id, "simple_nav", "tp_rush_a", "Blink Rush Intro_a", "", i++, false);

    // Blink Rush Exit_a
    node = quest_create_subtask(quest_id, "simple_condition", "tp_rush_exit_a", "Blink Rush Exit_a", "", i++, false);

    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");
    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "zone", "enter", "tp_rush_exit_a/success");

    //i = quest_create_ability_subtasks(quest_id, "base_teleport", "Teleport", g_white, i);

    var abi_id = "base_teleport";
    var abi_name = "Teleport";
    var abi_color = g_white;

    // Move to Teleport
    node = quest_create_subtask(quest_id, "simple_nav", "goto_" + abi_id, "Move to " + abi_name, "", i++, true);


    // Blink Rush_b
    node = quest_create_subtask(quest_id, "simple_nav", "tp_rush_b", "Blink Rush Intro_b", "", i++, false);

    // Blink Rush Exit_b
    node = quest_create_subtask(quest_id, "simple_condition", "tp_rush_exit_b", "Blink Rush Exit_b", "", i++, false);

    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");
    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "zone", "enter", "tp_rush_exit_b/success");


    // Pickup Teleport
    node = quest_create_subtask(quest_id, "item_pickup", "pickup_" + abi_id, "Pickup " + abi_name, "", i++, false);
    node[? "target_item"] = ability_pickup_obj;
    node[? "target_color"] = abi_color;


    // Use Teleport
    node = quest_create_subtask(quest_id, "use_ability", "use_" + abi_id, "Use " + abi_name, "", i++, false);
    node[? "target_color"] = abi_color;



    // Return to start
    node = quest_create_subtask(quest_id, "simple_condition", "return_to_start", "Return to start", "", i++, true);

    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");
    condition = quest_add_condition(transition, "zone", "enter", "return_to_start/start");

    // Exit level
    node = quest_create_subtask(quest_id, "simple_condition", "exit_level", "Exit level", "", i++, true);

    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");

    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "zone", "enter", "exit_level/success");
}
