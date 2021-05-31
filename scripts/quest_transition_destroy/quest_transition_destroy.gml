function quest_transition_destroy(quest_id, index) {
    var quest_node, transitions, transition;

    quest_node = DB.quest_nodes[? quest_id];
    transitions = quest_node[? "state_transitions"];
    transition = transitions[| index];
    
    ds_list_destroy(transition[? "from_states"]);

    ds_list_of_map_destroy(transition[? "conditions"]);

    ds_list_of_map_destroy(transition[? "effects"]);

    ds_map_destroy(transition);

    ds_list_delete(transitions, index);
}
