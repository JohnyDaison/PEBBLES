/// @description  BATTLEFEED AND STATS
if(!cancelled)
{
    var la_player = my_block.last_attacker_map[? "player"];
    var la_time = my_block.last_attacker_map[? "step"];
    var what = my_block.last_attacker_map[? "source"];
    
    var debug_str = "TROPHY DESTROYED ";
    
    var player_exists = instance_exists(la_player);
    var destroyed_by_guy = (what == guy_obj || what == emp_grenade_obj);
    
    debug_str += "by ";
    
    debug_str += string(what) + "=" + object_get_name(what) + " ";
    
    if(player_exists)
    {
        debug_str += ", player: " + la_player.name;
    }
    
    my_console_log(debug_str);
        
    if( (singleton_obj.step_count - la_time) < my_block.att_forget_delay
        && player_exists)
    {
        var score_str = "";
        if(la_player != gamemode_obj.environment && destroyed_by_guy)
        {
            var score_value = gamemode_obj.score_values[? "snake_trophy"];
    
            increase_stat(la_player, "score", score_value, false);
            score_str = stat_label("score", score_value, "+");
        }
    
        battlefeed_post_destruction(id, my_block.last_attacker_map, score_str);
    }
}

event_inherited();
