/// @description init_levels_gamemode()
/// @function init_levels_gamemode
function init_levels_gamemode() {

	var i,key,count = ds_list_size(DB.level_list);

	for(i=0; i<count; i++)
	{
	    key = DB.level_list[| i];
    
	    level_min[? key] = DB.level_globalmin[? key];
	    level_max[? key] = DB.level_globalmax[? key];
	    level_minstart[? key] = level_min[? key];
	    level_maxstart[? key] = level_max[? key];
	}



}
