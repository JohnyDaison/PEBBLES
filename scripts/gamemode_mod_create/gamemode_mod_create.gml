/// @param str_id
/// @param name
/// @param type
/// @param public
/// @param [icon]
/// @param [description]
function gamemode_mod_create() {

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

    if(ds_list_find_index(gamemode_mod_list, str_id) != -1)
    {
        return false;   
    }

    var gmmod = ds_map_create();

    gmmod[? "name"] = name;
    gmmod[? "description"] = description;
    gmmod[? "type"] = type;
    gmmod[? "public"] = public;
    gmmod[? "icon"] = icon;
    
    if (type == "number") {
        gmmod[? "default_value"] = 0;
        gmmod[? "min_value"] = 0;
        gmmod[? "max_value"] = 0;
        gmmod[? "value_step"] = 0;
    }

    if(ds_list_find_index(gamemode_mod_type_list, type) == -1)
    {
        ds_list_add(gamemode_mod_type_list, type);
    }


    ds_list_add(gamemode_mod_list, str_id);
    gamemode_rules[? str_id] = gmmod;

    return gmmod;
}
