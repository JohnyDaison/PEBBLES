function quick_tut_base_colors_quest() {
    var transition, condition;

    // LVL2 Quick Base colors quest
    var quest_id = "quick_tutorial_base_colors";

    quest_node_create(quest_id, "Base Colors", "Get the basics");
                                        
    transition = quest_transition_create(quest_id, "active", "success");
    condition = quest_add_condition(transition, "subtasks", "success");

    var i=1, node;


    // 1 Belts pickup
    node = quest_create_subtask(quest_id, "item_pickup", "color_belts_pickup", "Color Belts pickup", "", i++, true);
    node[? "target_item"] = three_color_belts_item_obj;


    // 2 Green floor
    quest_create_subtask(quest_id, "simple_nav_reached_start", "green_floor", "Green floor", "", i++, true);


    // 3 Green orb
    node = quest_create_subtask(quest_id, "item_pickup", "green_orb", "Green orb pickup", "", i++, true);
    node[? "target_item"] = color_orb_obj;
    node[? "target_color"] = g_green;


    // 4 Green orbit
    node = quest_create_subtask(quest_id, "simple_condition", "green_orbit", "Green orbit", "", i++, true);
    node[? "display_group"] = "orb_green";

    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "orb", "orbits");
    condition[? "orb_color"] = g_green;
    condition[? "orbit_anchor"] = guy_obj;
    condition = quest_add_condition(transition, "trigger", "displays");


    // 5 Green body
    node = quest_create_subtask(quest_id, "simple_condition", "green_body", "Green body", "", i++, true);
    node[? "display_group"] = "orb_green_confirm";

    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "my_body_color", "change");
    condition[? "body_color"] = g_green;
    condition = quest_add_condition(transition, "trigger", "displays");


    // 6 Green body jump
    quest_create_subtask(quest_id, "simple_nav", "green_body_jump", "Green body jump", "", i++, true);


    // 7 Blue jump up
    quest_create_subtask(quest_id, "simple_nav", "blue_jump_up", "Blue jump up", "", i++, true);


    // 8 Blue orb
    node = quest_create_subtask(quest_id, "item_pickup", "blue_orb", "Blue orb pickup", "", i++, true);
    node[? "target_item"] = color_orb_obj;
    node[? "target_color"] = g_blue;
    
    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");


    // 9 Blue body
    node = quest_create_subtask(quest_id, "simple_condition", "blue_body", "Blue body", "", i++, true);
    node[? "display_group"] = "orb_blue";

    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "my_body_color", "change");
    condition[? "body_color"] = g_blue;
    condition = quest_add_condition(transition, "trigger", "displays");


    // 10 Blue wall climb
    node = quest_create_subtask(quest_id, "simple_condition", "blue_wall_climb", "Blue wall climb", "", i++, true);
    node[? "display_group"] = "clear";
    
    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");
    condition = quest_add_condition(transition, "trigger", "displays");

    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "zone", "enter", "blue_wall_climb/success");


    // 11 HP Bar
    node = quest_create_subtask(quest_id, "simple_nav_reached_start", "hp_bar", "HP Bar", "", i++, true);
    node[? "display_group"] = "blast_turret";
    
    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "trigger", "displays");
    
    // 12 Push button
    node = quest_create_subtask(quest_id, "simple_condition", "push_button", "Push button", "", i++, false);
    node[? "target_player"] = -1;
    node[? "target_color"] = -1;
    node[? "display_group"] = "pressure_plate";
    
    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "zone", "enter", "push_button/start");
    
    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "piezoplate", "press");
    condition = quest_add_condition(transition, "trigger", "displays");


    // 13 Red jump in
    node = quest_create_subtask(quest_id, "simple_nav", "red_jump_in", "Red jump in", "", i++, true);


    // 14 Red orb
    node = quest_create_subtask(quest_id, "item_pickup", "red_orb", "Red orb pickup", "", i++, true);
    node[? "target_item"] = color_orb_obj;
    node[? "target_color"] = g_red;
    
    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");


    // 15 Red body
    node = quest_create_subtask(quest_id, "simple_condition", "red_body", "Red body", "", i++, true);
    node[? "display_group"] = "orb_red";

    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");
    
    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "my_body_color", "change");
    condition[? "body_color"] = g_red;
    condition = quest_add_condition(transition, "trigger", "displays");


    // 16 Exit level
    node = quest_create_subtask(quest_id, "simple_nav", "exit_level", "Exit level", "", i++, true);
    node[? "display_group"] = "clear";
    
    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "trigger", "displays");
}
