/// @param str_id
/// @param name
/// @param type
/// @param world
function gamemode_create() {
	var str_id = argument[0];
	var name = argument[1];
	var type = argument[2];
	var world = argument[3];

	if(ds_list_find_index(gamemode_list, str_id) != -1)
	{
	    return false;   
	}

	var gm = ds_map_create();

	gm[? "id"] = str_id;
	gm[? "limits"] = ds_map_create();
	gm[? "default_modifiers"] = ds_map_create();
	gm[? "forced_modifiers"] = ds_map_create();

	gm[? "name"] = name;
	gm[? "description"] = "";
	gm[? "type"] = type;
	gm[? "world"] = world;
	gm[? "start_place_room"] = noone;
	gm[? "base_level_config"] = "";

	if(type == match_obj)
	{
	    gm[? "base_level_config"] = "match";
	}
	else if(type == campaign_obj)
	{
	    gm[? "base_level_config"] = "tutorial";
	}

	gm[? "is_coop"] = false;
	gm[? "min_players"] = 1;
	gm[? "min_real_players"] = 0;
	gm[? "max_players"] = 1;

	gm[? "start_script"] = empty_script;


	ds_list_add(gamemode_list, str_id);
	gamemodes[? str_id] = gm;

	return gm;


}
