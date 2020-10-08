/// @description config_level_gamemode(key, min, max, minstart, [maxstart])
/// @function config_level_gamemode
/// @param key
/// @param min
/// @param max
/// @param minstart
/// @param [maxstart]
function config_level_gamemode() {

	var key = argument[0];
	var new_min = argument[1];
	var new_max = argument[2];
	var min_start = argument[3];
	var max_start = "";

	if(argument_count > 4)
	{
	    max_start = argument[4];
	}

	var ret = false;

	if(ds_list_find_index(DB.level_list, key) != -1)
	{
	    if(new_min != "")
	    {
	        level_min[? key] = new_min;
	    }
	    if(new_max != "")
	    {
	        level_max[? key] = new_max;
	    }
	    if(min_start != "")
	    {
	        level_minstart[? key] = min_start;
	    }
	    if(max_start != "")
	    {
	        level_maxstart[? key] = max_start;
	    }
    
	    level_min[? key] = clamp(level_min[? key], DB.level_globalmin[? key], DB.level_globalmax[? key]);
	    level_max[? key] = clamp(level_max[? key], DB.level_globalmin[? key], DB.level_globalmax[? key]);
    
	    if(level_min[? key] > level_max[? key])
	    {
	        level_min[? key] = level_max[? key];
	    }
    
	    level_minstart[? key] = clamp(level_minstart[? key], level_min[? key], level_max[? key]);
	    level_maxstart[? key] = clamp(level_maxstart[? key], level_min[? key], level_max[? key]);
    
	    if(level_minstart[? key] > level_maxstart[? key])
	    {
	        level_minstart[? key] = level_maxstart[? key];
	    }
    
	    ret = true;
	}

	return ret;



}
