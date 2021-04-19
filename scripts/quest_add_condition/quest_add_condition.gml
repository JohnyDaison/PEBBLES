/// @description quest_add_condition(transition, type, verb, [param])
/// @function quest_add_condition
/// @param transition
/// @param type
/// @param verb
/// @param [param]
function quest_add_condition() {
    var transition = argument[0];
    var type = argument[1];
    var verb = argument[2];

    var condition = ds_map_create();
    condition[? "type"] = type;
    condition[? "verb"] = verb;
    condition[? "event_based"] = true;

    if(type == "zone" && verb == "enter")
    {
        if(argument_count > 3)
        {
            condition[? "zone_id"] = argument[3];
        }
    }

    if(type == "gatezone")
    {
        if(argument_count > 3)
        {
            condition[? "zone_id"] = argument[3];
        }
    }

    if(type == "waypoint" && verb == "touch")
    {
        if(argument_count > 3)
        {
            condition[? "waypoint_id"] = argument[3];
        }
    }


    // subtasks_success
    if( ((type == "subtasks" || type == "subtask") && (verb == "success" || verb == "reached") )
        || (type == "channel" && verb == "duration")
        || (type == "has_tried_to" && verb == "move")
        || (type == "time_elapsed" && verb == "from_start")
        || (type == "trigger" && verb == "displays"))
    {
        condition[? "event_based"] = false;
    }

    ds_list_add(transition[? "conditions"], condition);

    return condition;
}
