/// @description getStatValue(stat, query)
/// @function getStatValue
/// @param stat
/// @param  query
function getStatValue(argument0, argument1) {
	var stat = argument0;
	var query = argument1;

	var stat_value = gamemode_obj.environment.stats[? stat], other_stat_value;

	if(!is_undefined(stat_value) && is_string(query))
	{
	    if(query == "highest" || query == "lowest")
	    {
	        if(query == "highest")
	        {
	            stat_value = -10000000;
	        }
	        else if(query == "lowest")
	        {
	            stat_value = 10000000;
	        }
        
	        count = gamemode_obj.player_count;
	        for(i=1; i <= count; i++)
	        {
	            pl = gamemode_obj.players[? i];
	            other_stat_value = pl.stats[? stat];
                
	            if(query == "highest")
	            {
	                if(other_stat_value > stat_value)
	                {
	                    stat_value = other_stat_value;
	                }
	            }
	            else if(query == "lowest")
	            {
	                if(other_stat_value < stat_value)
	                {
	                    stat_value = other_stat_value;
	                }
	            }
	        }
	    }
	}
	else
	{
	    show_debug_message("getStatValue: FAIL - stat: "+ string(stat) + " |query: " + string(query));
	}

	return stat_value;



}
