/// @description increase_stat(player, stat, increase, show)
/// @function increase_stat
/// @param player
/// @param stat
/// @param increase
/// @param show
function increase_stat() {
	var player, stat, incr, show, plus_str;

	player = argument[0];
	stat = argument[1];
	incr = argument[2];
	show = argument[3];

	if(instance_exists(player))
	{
	    if(ds_map_exists(player.stats,stat))
	    {
	        player.stats[? stat] += incr;
        
	        if(ds_list_find_index(DB.player_stats_actions, stat) != -1)
	        {
	            player.stats[? "actions"] += incr;
	            player.stats[? "total_actions"] += incr;
	        }
        
	        if(show)
	        {
	            plus_str = "";
	            if(incr >= 0)
	            {
	                plus_str = "+";
	            }
            
	            var DBindex = ds_list_find_index(DB.stats_display_keys, stat);
	            var stat_name = DB.stats_display_labels[| DBindex];
            
	            var stat_str = stat_name + " " + plus_str + string(incr);
            
	            battlefeed_post_string(player, stat_str);
	        }
	    }
	}



}
