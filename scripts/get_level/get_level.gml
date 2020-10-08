/// @description get_level(who, key)
/// @function get_level
/// @param who
/// @param key
function get_level() {
	var who = argument[0];
	var key = argument[1];

	var ret = undefined;

	if(instance_exists(who) && instance_exists(who.my_player))
	{
	    ret = (who.my_player).levels[? key];
	}

	return ret;



}
