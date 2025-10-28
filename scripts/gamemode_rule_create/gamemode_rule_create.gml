/// @param str_id
/// @param name
/// @param type
/// @param public
/// @param [icon]
/// @param [description]
function gamemode_rule_create() {

    var str_id = argument[0];
    var name = argument[1];
    var type = argument[2];
    var public = argument[3];

    var icon = noone;
    var description = "";
    if(argument_count > 4)
    {
        icon = argument[4];
    }

    if(argument_count > 5)
    {
        description = argument[5];
    }

    if(ds_list_find_index(gamemode_rule_list, str_id) != -1)
    {
        return false;   
    }

    var gmRule = ds_map_create();

    gmRule[? "name"] = name;
    gmRule[? "description"] = description;
    gmRule[? "type"] = type;
    gmRule[? "public"] = public;
    gmRule[? "icon"] = icon;
    
    if (type == "number") {
        gmRule[? "default_value"] = 0;
        gmRule[? "min_value"] = 0;
        gmRule[? "max_value"] = 0;
        gmRule[? "value_step"] = 0;
    }

    if(ds_list_find_index(gamemode_rule_type_list, type) == -1)
    {
        ds_list_add(gamemode_rule_type_list, type);
    }


    ds_list_add(gamemode_rule_list, str_id);
    gamemode_rules[? str_id] = gmRule;

    return gmRule;
}
