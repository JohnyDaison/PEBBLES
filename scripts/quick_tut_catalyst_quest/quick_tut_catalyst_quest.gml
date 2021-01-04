function quick_tut_catalyst_quest() {
    var transition, condition;

    // LVL3 Quick Catalyst quest
    var quest_id = "quick_tutorial_catalyst";

    quest_node_create(quest_id, "Catalyst", "Pew! Pew! Pew!");
                                        
    transition = quest_transition_create(quest_id, "active", "success");
    condition = quest_add_condition(transition, "subtasks", "success");

    var i=1, node;


    // Catalyst pickup
    node = quest_create_subtask(quest_id, "item_pickup", "catalyst_pickup", "Catalyst pickup", "", i++, true);
    node[? "target_item"] = chargeball_item_obj;


    // Color body
    node = quest_create_subtask(quest_id, "simple_condition", "color_body", "Color body", "", i++, true);
    node[? "display_group"] = "choose_body_color";

    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "trigger", "displays");
    condition = quest_add_condition(transition, "my_body_color", "change");
    condition[? "body_color"] = "non_black";


    // Quick Shot
    node = quest_create_subtask(quest_id, "simple_destroy_target", "quick_shot", "Quick shot", "", i++, false);
    node[? "destroy_target"] = wall_obj;
    node[? "display_group"] = "quick_shot";

    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "trigger", "displays");

    /*
    node = quest_create_subtask(quest_id, "simple_condition", "quick_shot", "Quick shot", "", i++, false);

    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "object", "destroy");
    condition[? "destroy_target"] = wall_obj;
    */


    // Data cube pickup
    node = quest_create_subtask(quest_id, "item_pickup", "data_cube_pickup", "Data cube pickup", "", i++, false);
    node[? "target_item"] = SECRET_obj;


    // Ignore Data cube
    node = quest_create_subtask(quest_id, "simple_condition", "ignore_data_cube", "Ignore Data Cube", "", i++, true);

    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "zone", "enter", "ignore_data_cube");
    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "zone", "enter", "ignore_data_cube");


    // Jump down to Slimes
    node = quest_create_subtask(quest_id, "simple_nav", "jump_to_slimes", "Jump to Slimes", "", i++, false);


    // Open the Gate (Red)
    node = quest_create_subtask(quest_id, "simple_condition", "open_gate_red", "Open the Gate (Red)", "", i++, false);

    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "zone", "enter", "jump_to_slimes/success");
    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "gatezone", "open", "open_gate_red");


    // Get back up
    node = quest_create_subtask(quest_id, "simple_condition", "get_back_up", "Get back up", "", i++, false);

    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");
    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "zone", "enter", "shoot_through_wall/start");


    // Shoot through Wall
    node = quest_create_subtask(quest_id, "simple_nav", "shoot_through_wall", "Shoot through Wall", "", i++, true);


    // Open the Gate (Manual)
    node = quest_create_subtask(quest_id, "simple_condition", "open_gate_manual", "Open the Gate (Manual)", "", i++, false);

    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "zone", "enter", "open_gate_manual/start");
    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "gatezone", "open", "open_gate_manual");


    // Jump down to Cyan
    node = quest_create_subtask(quest_id, "simple_nav", "jump_to_cyan", "Jump to Cyan", "", i++, true);


    // Be out of range
    node = quest_create_subtask(quest_id, "simple_nav", "be_out_of_range", "Be out of range", "", i++, false);


    // Kill Turrets
    node = quest_create_subtask(quest_id, "simple_destroy_target", "kill_turrets", "Kill Turrets", "", i++, false);
    node[? "destroy_target"] = turret_mount_obj;

    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");


    // Reach Terminal
    node = quest_create_subtask(quest_id, "simple_nav", "reach_terminal", "Reach Terminal", "", i++, true);


    // Use Terminal
    node = quest_create_subtask(quest_id, "simple_nav", "use_terminal", "Use Terminal", "", i++, true);


    // Get practice
    node = quest_create_subtask(quest_id, "simple_condition", "get_practice", "Get practice", "", i++, false);
    node[? "target_player"] = -1;
    node[? "target_color"] = -1;

    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "zone", "enter", "get_practice/start");
    transition = quest_transition_find(node, "", "success");
    condition = quest_add_condition(transition, "piezoplate", "press");


    // Shoot battery spawner
    node = quest_create_subtask(quest_id, "simple_nav", "battery_spawner", "Shoot battery spawner", "", i++, false);

    transition = quest_transition_find(node, "", "start");
    condition = quest_add_condition(transition, "subtask", "reached");


    // Exit level
    node = quest_create_subtask(quest_id, "simple_nav", "exit_level", "Exit level", "", i++, true);




}
