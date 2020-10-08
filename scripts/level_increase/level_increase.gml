/// @description level_increase(who, key, value, [upto])
/// @function level_increase
/// @param who
/// @param key
/// @param value
/// @param [upto]
function level_increase() {
	var who = argument[0];
	var key = argument[1];
	var value = argument[2];
	var upto = false;

	if(argument_count > 3)
	{
	    upto = argument[3];
	}

	var ret = false;

	if(instance_exists(who) && instance_exists(who.my_player))
	{
	    var level = (who.my_player).levels[? key];

	    if(!is_undefined(level))
	    {
	        if(upto)
	        {
	            if(value > level)
	            {
	                level = value;   
	            }
	        }
	        else
	        {
	            level = level + value;   
	        }
        
	        return level_set(who, key, level);
	    }
	}

	return ret;




}
