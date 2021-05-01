function quest_simple_nav_create(quest_id, name, description, context_id) {
    var transition, condition;

    var node = quest_node_create(quest_id, name, description);
    node[? "subtask_type"] = "simple_nav";

    transition = quest_transition_create(quest_id, "init", "start");
    condition = quest_add_condition(transition, "zone", "enter", context_id + "/start");
    
    transition = quest_transition_create(quest_id, "failure", "start");
    condition = quest_add_condition(transition, "zone", "enter", context_id + "/start");

    transition = quest_transition_create(quest_id, "nonsuccess", "success");
    condition = quest_add_condition(transition, "zone", "enter", context_id + "/success");

    transition = quest_transition_create(quest_id, "active", "failure");
    condition = quest_add_condition(transition, "zone", "enter", context_id + "/failure");

    return node;
}
