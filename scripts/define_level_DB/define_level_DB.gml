/// @description define_level_DB(key, type, label, minvalue, maxvalue)
/// @function define_level_DB
/// @param key
/// @param  type
/// @param  label
/// @param  minvalue
/// @param  maxvalue
function define_level_DB() {
	var key = argument[0];
	var type = argument[1];
	var label = argument[2];
	var level_min = argument[3];
	var level_max = argument[4];

	var ret = false;

	if(ds_list_find_index(level_list, key) == -1)
	{
	    ds_list_add(level_list, key);
    
	    level_type[? key] = type;
	    level_label[? key] = label;
	    level_globalmin[? key] = level_min;
	    level_globalmax[? key] = level_max;
    
	    ret = true;
	}

	return ret;



}
