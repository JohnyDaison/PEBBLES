function quest_transition_find(quest_node, from_states, to_state) {
    var i, transition;
    var transitions = quest_node[? "state_transitions"];
    var count = ds_list_size(transitions);

    for(i = 0; i < count; i++)
    {
        transition = transitions[| i];
        
        if(from_states == "" && transition[? "to_state"] == to_state)
        {
            return transition;
        }
    }

    return undefined;
}
