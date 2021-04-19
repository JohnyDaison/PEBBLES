/// @description quest_add_effect(transition, type, verb, [param])
/// @function quest_add_effect
/// @param transition
/// @param type
/// @param verb
/// @param [param]
function quest_add_effect() {
    var transition = argument[0];
    var type = argument[1];
    var verb = argument[2];

    var effect = ds_map_create();
    effect[? "type"] = type;
    effect[? "verb"] = verb;

    if(type == "displays" && verb == "trigger")
    {
        if(argument_count > 3)
        {
            effect[? "display_group"] = argument[3];
        }
    }
    
    if(type == "spawners" && verb == "trigger")
    {
        if(argument_count > 3)
        {
            effect[? "spawner_group"] = argument[3];
        }
    }

    ds_list_add(transition[? "effects"], effect);

    return effect;
}
