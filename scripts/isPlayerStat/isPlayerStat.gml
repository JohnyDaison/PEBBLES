/// @description isPlayerStat(player, stat, assertion, unique)
/// @function isPlayerStat
/// @param player
/// @param  stat
/// @param  assertion
/// @param  unique
function isPlayerStat(argument0, argument1, argument2, argument3) {
	// only compares with players who haven't lost

	var player = argument0;
	var stat = argument1;
	var assertion = argument2;
	var unique = argument3;

	var ret = false, stat_value, count, i, pl;

	if(instance_exists(player) && instance_exists(gamemode_obj))
	{
	    stat_value = player.stats[? stat];
	    if(!is_undefined(stat_value))
	    {
	        if(is_string(assertion))
	        {
	            if(assertion == "highest" || assertion == "lowest")
	            {
	                ret = true;
	                count = gamemode_obj.player_count;
	                for(i=1; i <= count; i++)
	                {
	                    pl = gamemode_obj.players[? i];
                    
	                    if(pl.id == player.id || pl.loser)
	                        continue;
                        
	                    if(assertion == "highest")
	                    {
	                        if(unique)
	                        {
	                            if(pl.stats[? stat] >= stat_value)
	                            {
	                                ret = false;
	                            }
	                        }
	                        else
	                        {
	                            if(pl.stats[? stat] > stat_value)
	                            {
	                                ret = false;
	                            }
	                        }
	                    }
	                    else if(assertion == "lowest")
	                    {
	                        if(unique)
	                        {
	                            if(pl.stats[? stat] <= stat_value)
	                            {
	                                ret = false;
	                            }
	                        }
	                        else
	                        {
	                            if(pl.stats[? stat] < stat_value)
	                            {
	                                ret = false;
	                            }
	                        }
	                    }
	                }
	            }
	        }
    
	    }
	}

	return ret;



}
