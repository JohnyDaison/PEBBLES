function quest_item_pickup_create(quest_id, name, description) {
    var transition, condition;

    var node = quest_node_create(quest_id, name, description);
    node[? "subtask_type"] = "item_pickup";
    node[? "target_item"] = all;
    node[? "target_color"] = -1;

    transition = quest_transition_create(quest_id, "init", "start");

    transition = quest_transition_create(quest_id, "nonsuccess", "success");
    condition = quest_add_condition(transition, "item", "pickup");

    return node;
}
