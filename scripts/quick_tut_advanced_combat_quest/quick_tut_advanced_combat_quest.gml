function quick_tut_advanced_combat_quest() {
    var transition, condition;

    // LVL5 Advanced Combat quest
    var quest_id = "quick_tutorial_advanced_combat";

    quest_node_create(quest_id, "Advanced combat", "Woooosh! Wooosh! Woosh!");
                                        
    transition = quest_transition_create(quest_id, "active", "success");
    condition = quest_add_condition(transition, "subtasks", "success");

    var i=1, node;

    /*
    // Dark orb pickup
    node = quest_create_subtask(quest_id, "item_pickup", "dark_orb_pickup", "Dark orb pickup", "", i++, true);
    node[? "target_item"] = color_orb_obj;
    node[? "target_color"] = g_dark;
    */

    // Red body
    // This should be a nav quest
    node = quest_create_subtask(quest_id, "simple_condition", "red_color_body", "Red body", "", i++, true);

    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "my_body_color", "change");
    condition[? "body_color"] = g_red;


    // Dark body
    node = quest_create_subtask(quest_id, "simple_condition", "dark_color_body", "Dark body", "", i++, true);

    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");

    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "my_body_color", "change");
    condition[? "body_color"] = g_dark;


    // Pickup Shield using Vortex
    node = quest_create_subtask(quest_id, "item_pickup", "shield_pickup", "Vortex", "", i++, true);
    node[? "target_item"] = shield_item_obj;


    // Open the Gate (Red)
    /*
    node = quest_create_subtask(quest_id, "simple_condition", "open_gate_red", "Open the Gate (Red)", "", i++, false);

    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "gatezone", "open", "open_gate_red");
    */

    // Get past the Guards  
    node = quest_create_subtask(quest_id, "simple_nav", "get_past_guards", "Get past the Guards", "", i++, true);

    // Pickup Invisibility
    node = quest_create_subtask(quest_id, "item_pickup", "invis_pickup", "Invisibility", "", i++, true);
    node[? "target_item"] = ability_pickup_obj;
    node[? "target_color"] = g_cyan;


    // Use Invisibility
    node = quest_create_subtask(quest_id, "simple_condition", "use_invis", "Use Invisibility", "", i++, true);

    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");

    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "zone", "enter", "use_invis/success");


    // Pickup Blink
    node = quest_create_subtask(quest_id, "item_pickup", "teleport_pickup", "Blink", "", i++, true);
    node[? "target_item"] = ability_pickup_obj;
    node[? "target_color"] = g_blue;


    // Use Blink
    node = quest_create_subtask(quest_id, "simple_nav", "use_teleport", "Use Blink", "", i++, true);


    // Exit level
    node = quest_create_subtask(quest_id, "simple_nav", "exit_level", "Exit level", "", i++, true);
}
