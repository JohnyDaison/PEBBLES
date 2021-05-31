/// @description set_stat(player, stat, value, [display])
/// @function set_stat
/// @param player
/// @param stat
/// @param value
/// @param [display]
function set_stat() {
    var player, stat, value, display;

    player = argument[0];
    stat = argument[1];
    value = argument[2];
    display = false;

    if(argument_count >= 4)
    {
        display = argument[3];
    }

    if(instance_exists(player))
    {
        if(ds_map_exists(player.stats,stat))
        {
            ds_map_replace(player.stats,stat,value);
        
            if(display == true)
            {
                var DBindex = ds_list_find_index(DB.stats_display_keys, stat);
                var stat_name = DB.stats_display_labels[| DBindex];
            
                var stat_str = stat_name + " SET: " + string(value);
            
                battlefeed_post_string(player, stat_str);
            }
        }
    }
}
