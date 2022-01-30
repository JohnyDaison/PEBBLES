/// @param flag
/// @param capturer
/// @param [stat_str]
function battlefeed_post_flag_capture(flag, capturer) {
    var stat_str = "";

    if(argument_count > 2)
    {
        stat_str = string(argument[2]);
    }

    var feed_item = noone;
    var actor_name = "", victim_name = "";
    var is_in_player_feed = false;

    if(instance_exists(flag))
    {
        feed_item = battlefeed_post_new("flag_capture");
    
        battlefeed_post_addblank(feed_item, "actorflag");
        battlefeed_post_addblank(feed_item, "name");
        battlefeed_post_addblank(feed_item, "score");
        battlefeed_post_addblank(feed_item, "victimname");
        battlefeed_post_addblank(feed_item, "victimflag");
    
        with(flag)
        {
            victim_name = my_flag_spawner.my_player.name;
        
            var la_player = capturer.my_player;
        
            actor_name = la_player.name;
            
            battlefeed_post_assignplayer(feed_item, la_player);
            is_in_player_feed = feed_item.battlefeed == la_player.battlefeed;
            
            /*
            if(!is_in_player_feed)
            {
                battlefeed_post_fillblank(feed_item, "actorflag", "icon", la_player.flag, g_white);
            }
            */
                  
            if(my_flag_spawner.my_player != gamemode_obj.environment)
            {
                battlefeed_post_fillblank(feed_item, "victimflag", "icon", my_flag_spawner.my_player.flag, "bf_orange");
            }
        }
    
        if(actor_name != "" && actor_name != gamemode_obj.environment.name && !is_in_player_feed)
        {
            battlefeed_post_fillblank(feed_item, "name", "text", actor_name, g_white);
        }
    
        if(stat_str != "")
        {
            var DBindex = ds_list_find_index(DB.stats_display_keys, "score");
            var score_label = DB.stats_display_labels[| DBindex];

            stat_str = string_replace(stat_str, score_label+" ", "");
        
            battlefeed_post_fillblank(feed_item, "score", "text", stat_str, g_yellow);
        }
        /*
        if(flag.my_flag_spawner.my_player != gamemode_obj.environment) // victim_name != my_player.name && 
        {   
            battlefeed_post_fillblank(feed_item, "victimname", "text", victim_name, g_white); // "bf_orange"
        }
        */
    
        // debug
        /*
        var debug_str = "";
        for(var ii = 0; ii < feed_item.content_length; ii++)
        {
            debug_str += feed_item.type[? ii] + ":" + string(feed_item.content[? ii]) + " | ";
        }
        my_console_log(debug_str);
        */
    
    }
    else if(stat_str != "")
    {
        battlefeed_post_string(gamemode_obj.environment, stat_str);
    }

    return feed_item;
}
