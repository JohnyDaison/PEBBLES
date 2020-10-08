/// @description level_set(who, key, value)
/// @function level_set
/// @param who
/// @param key
/// @param value
function level_set() {
	var who = argument[0];
	var key = argument[1];
	var value = argument[2];

	var ret = false;

	if(instance_exists(who) && instance_exists(who.my_player))
	{
	    var level = (who.my_player).levels[? key];
	    var old_level = level;
	    if(!is_undefined(level))
	    {
	        level = clamp(value, gamemode_obj.level_min[? key], gamemode_obj.level_max[? key]);
	        ret = (level != old_level);
	        if(ret)
	        {
	            (who.my_player).levels[? key] = level;
	        }
	    }
	}

	return ret;



}
