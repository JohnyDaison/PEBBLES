/// @param {Id.Instance} victim
/// @param {Id.DsMap} last_attacker_data
/// @param {String} stat_str
function battlefeed_post_destruction(victim, last_attacker_data, stat_str = "") {
    var feed_item = noone;
    var actor_name = "", actor = noone, actor_color, victim_name = "", victim_index = noone;
    var carrier_dir = 1, skip_carrier = false, skip_victim = false;
    var hide_item = false, is_in_player_feed = false;

    if(instance_exists(victim))
    {
        feed_item = battlefeed_post_new("destruction");
    
        battlefeed_post_addblank(feed_item, "actorflag");
        battlefeed_post_addblank(feed_item, "name");
        battlefeed_post_addblank(feed_item, "score");
        battlefeed_post_addblank(feed_item, "actor");
        battlefeed_post_addblank(feed_item, "carrier");
        battlefeed_post_addblank(feed_item, "victim");
        battlefeed_post_addblank(feed_item, "victimname");
        battlefeed_post_addblank(feed_item, "victimflag");
    
        with(victim)
        {
            if(object_is_ancestor(object_index, guy_obj))
            {
                victim_name = name;
                victim_index = guy_obj;
            }
            else
            {
                victim_name = my_player.name;
                victim_index = object_index;
            }
        
            var la_player = last_attacker_data[? "player"];
        
            if(la_player != noone)
            {
                actor_name = la_player.name;
            
                battlefeed_post_assignplayer(feed_item, la_player);
                is_in_player_feed = feed_item.battlefeed == la_player.battlefeed;
            
                /*
                if(!is_in_player_feed)
                {
                    battlefeed_post_fillblank(feed_item, "actorflag", "icon", la_player.flag, g_white);
                }
                */
            
                if(last_attacker_data[? "source"] != noone)
                {
                    actor = last_attacker_data[? "source"];
                    actor_color = last_attacker_data[? "source_color"];
                
                    if(last_attacker_data[? "source"] == guy_obj)
                    {
                        actor_name = last_attacker_data[? "source_name"];
                    }
                
                    if(last_attacker_data[? "source_id"] == id)
                    {
                        carrier_dir = -1;
                        skip_carrier = false;
                        skip_victim = true;
                    }
                
                    if(actor != guy_obj)
                    {
                        battlefeed_post_fillblank(feed_item, "actor", "icon", actor, "bf_orange");    
                    }
                }
        
                if(!skip_carrier && last_attacker_data[? "carrier"] != noone)
                {
                    battlefeed_post_fillblank(feed_item, "carrier", "icon", last_attacker_data[? "carrier"], g_red, carrier_dir);
                }
            }
            else
            {
                skip_victim = true;
            
                battlefeed_post_assignfeed(feed_item, gamemode_obj.battlefeed);
                is_in_player_feed = false;
            
                if(object_is_ancestor(object_index, guy_obj))
                {
                    actor_name = name;
                    actor = guy_obj;
                }
                else
                {
                    actor_name = my_player.name;
                    actor = object_index;
                }
            
                if(actor != guy_obj)
                {
                    battlefeed_post_fillblank(feed_item, "actor", "icon", actor, "bf_orange"); 
                }
                battlefeed_post_fillblank(feed_item, "carrier", "icon", noone, g_red);
            }
    
            if(!skip_victim)
            {
                battlefeed_post_fillblank(feed_item, "victim", "icon", victim_index, g_white); //"bf_orange"
                /*
                if(my_player != gamemode_obj.environment)
                {
                    battlefeed_post_fillblank(feed_item, "victimflag", "icon", my_player.flag, g_white);
                }
                */
            }
        
            if(la_player == gamemode_obj.environment && victim.my_player == gamemode_obj.environment)
            {
                hide_item = true;
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
    
        if(!skip_victim && (victim.my_player != gamemode_obj.environment || victim_index == guy_obj)) // victim_name != my_player.name && 
        {   
            battlefeed_post_fillblank(feed_item, "victimname", "text", victim_name, g_white); // "bf_orange"
        }
    
        if(hide_item)
        {
            feed_item.fade_ratio = 0;
        
            var msg_index = ds_list_find_index(feed_item.battlefeed.msg_list, feed_item);
    
            if(msg_index != -1)
            {
                ds_list_delete(feed_item.battlefeed.msg_list, msg_index);
            }
        }
    
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
