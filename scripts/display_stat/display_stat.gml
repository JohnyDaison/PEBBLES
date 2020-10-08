/// @description display_stat(player, stat)
/// @function display_stat
/// @param player
/// @param  stat
function display_stat(argument0, argument1) {
	var player, stat, tmp;

	player = argument0;
	stat = argument1;

	if(instance_exists(player))
	{
	    if(ds_map_exists(player.stats,stat))
	    {
	        var DBindex = ds_list_find_index(DB.stats_display_keys, stat);
	        var stat_name = DB.stats_display_labels[| DBindex];
        
	        tmp = ds_map_find_value(player.stats,stat);
        
	        var stat_str = stat_name + ": " + string(tmp);
        
	        battlefeed_post_string(player, stat_str);
	    }
	}



}
