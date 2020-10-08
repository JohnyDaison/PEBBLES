/// @description has_level(who, key, min, [max])
/// @function has_level
/// @param who
/// @param  key
/// @param  min
/// @param  [max]
function has_level() {
	var who = argument[0];
	var key = argument[1];
	var min_level = argument[2];
	var max_level = "";
	if(argument_count > 3)
	{
	    max_level = argument[3];   
	}

	var ret = false;

	if(instance_exists(who) && instance_exists(who.my_player))
	{
	    var level = (who.my_player).levels[? key];
	    if(!is_undefined(level))
	    {
	        ret = (!is_real(min_level) || level >= min_level)
	           && (!is_real(max_level) || level <= max_level);
	    }
	}

	return ret;



}
