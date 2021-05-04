function quick_tut_base_colors_quest() {
    var transition, condition, effect;

    // LVL2 Quick Base colors quest
    var quest_id = "quick_tutorial_base_colors";

    quest_node_create(quest_id, "Base Colors", "Get the basics");
                                        
    transition = quest_transition_create(quest_id, "active", "success");
    condition = quest_add_condition(transition, "subtasks", "success");

    var i=1, node, child_node;
    

    // 1 Belts pickup
    node = quest_create_subtask(quest_id, "item_pickup", "color_belts_pickup", "Color Belts pickup", "", i++, true);
    node[? "target_item"] = three_color_belts_item_obj;
    
    transition = quest_transition_find(node, "", "active");
    condition = quest_add_condition(transition, "zone", "enter", "color_belts_pickup/start");
    effect = quest_add_effect(transition, "displays", "trigger", "color_belts");


    // 2 Green floor
    node = quest_create_subtask(quest_id, "simple_nav_reached_start", "green_floor", "Green floor", "", i++, true);

    transition = quest_transition_find(node, "", "success");
    effect = quest_add_effect(transition, "subtasks", "complete");


        // 2.1 Weak Effect
        child_node = quest_create_subtask(node[? "quest_id"], "simple_nav", "weak_effect", "Weak Effect", "", 1, false);
    
        transition = quest_transition_find(child_node, "", "active");
        effect = quest_add_effect(transition, "displays", "trigger", "weak_effect");
    
    
        // 2.2 Strong Effect
        child_node = quest_create_subtask(node[? "quest_id"], "simple_nav", "strong_effect", "Strong Effect", "", 2, false);
    
        transition = quest_transition_find(child_node, "", "active");
        effect = quest_add_effect(transition, "displays", "trigger", "strong_effect");


    // 3 Green orb
    node = quest_create_subtask(quest_id, "item_pickup", "green_orb", "Green orb pickup", "", i++, true);
    node[? "target_item"] = color_orb_obj;
    node[? "target_color"] = g_green;
    
    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");
    effect = quest_add_effect(transition, "displays", "trigger", "green_orb_label");


    // 4 Green orbit
    node = quest_create_subtask(quest_id, "simple_condition_reached_start", "green_orbit", "Green orbit", "", i++, true);

    transition = quest_transition_find(node, "", "start");    
    effect = quest_add_effect(transition, "displays", "trigger", "orb_green");

    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "orb", "orbits");
    condition[? "orb_color"] = g_green;
    condition[? "orbit_anchor"] = guy_obj;


    // 5 Green body
    node = quest_create_subtask(quest_id, "simple_condition_reached_start", "green_body", "Green body", "", i++, true);
    
    transition = quest_transition_find(node, "", "start");
    effect = quest_add_effect(transition, "displays", "trigger", "orb_green_confirm");

    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "my_body_color", "change");
    condition[? "body_color"] = g_green;
    effect = quest_add_effect(transition, "displays", "trigger", "clear");


    // 6 Green body jump
    node = quest_create_subtask(quest_id, "simple_nav", "green_body_jump", "Green body jump", "", i++, true);
    
    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");
    effect = quest_add_effect(transition, "displays", "trigger", "green_charged_jump");


    // 7 Blue jump up
    node = quest_create_subtask(quest_id, "simple_nav", "blue_jump_up", "Blue jump up", "", i++, true);


    // 8 Blue orb
    node = quest_create_subtask(quest_id, "item_pickup", "blue_orb", "Blue orb pickup", "", i++, true);
    node[? "target_item"] = color_orb_obj;
    node[? "target_color"] = g_blue;
    
    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");


    // 9 Blue body
    node = quest_create_subtask(quest_id, "simple_condition_reached_start", "blue_body", "Blue body", "", i++, true);
    
    transition = quest_transition_find(node, "", "start");
    effect = quest_add_effect(transition, "displays", "trigger", "orb_blue");

    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "my_body_color", "change");
    condition[? "body_color"] = g_blue;
    effect = quest_add_effect(transition, "displays", "trigger", "clear");


    // 10 Blue wall climb
    node = quest_create_subtask(quest_id, "simple_condition_reached_start", "blue_wall_climb", "Blue wall climb", "", i++, true);

    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "zone", "enter", "blue_wall_climb/success");


    // 11 HP Bar
    node = quest_create_subtask(quest_id, "simple_nav_reached_start", "hp_bar", "HP Bar", "", i++, true);
    
    transition = quest_transition_find(node, "", "start");
    effect = quest_add_effect(transition, "displays", "trigger", "blast_turret");
    
    
    // 12 Push button
    node = quest_create_subtask(quest_id, "simple_condition", "push_button", "Push button", "", i++, false);
    node[? "target_player"] = -1;
    node[? "target_color"] = -1;
    
    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "zone", "enter", "push_button/start");
    effect = quest_add_effect(transition, "displays", "trigger", "pressure_plate");
    
    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "piezoplate", "press");


    // 13 Red jump in
    node = quest_create_subtask(quest_id, "simple_nav", "red_jump_in", "Red jump in", "", i++, true);


    // 14 Red orb
    node = quest_create_subtask(quest_id, "item_pickup", "red_orb", "Red orb pickup", "", i++, true);
    node[? "target_item"] = color_orb_obj;
    node[? "target_color"] = g_red;
    
    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");


    // 15 Red body
    node = quest_create_subtask(quest_id, "simple_condition_reached_start", "red_body", "Red body", "", i++, true);

    transition = quest_transition_find(node, "", "start");
    effect = quest_add_effect(transition, "displays", "trigger", "orb_red");
    
    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "my_body_color", "change");
    condition[? "body_color"] = g_red;    
    effect = quest_add_effect(transition, "displays", "trigger", "clear");
    

    // 16 Exit level
    node = quest_create_subtask(quest_id, "simple_nav", "exit_level", "Exit level", "", i++, true);
}
