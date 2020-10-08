/// @description  WIN MESSAGE

if(instance_exists(center_overlay))
{
    if(is_coop)
    {
        var pl = players[? 1];
        
        var times = world.current_place.times;
        var best_award_value = -1, best_time_award = "", best_time_award_str = "";
        var time_key = ds_map_find_first(times), time_value;
        
        while(!is_undefined(time_key))
        {
            time_value = times[? time_key];
            if((best_award_value == -1 || best_award_value > time_value) && timer_window.time.total <= time_value)
            {
                best_award_value = time_value;
                best_time_award_str = " " + string_upper(time_key);
            }
            
            time_key = ds_map_find_next(times, time_key);
        }
        
        center_overlay.message =
               //"Score: " + string(pl.stats[? "score"]) + "\n" + 
           "Time: " + stats[? "match_length"] + best_time_award_str + "\n" + 
           "Data Cubes: " + string(pl.stats[? "secrets_found"]) + "/" + string(gamemode_obj.stats[? "secrets_total"]); /* + "\n" + */
           //"Mobs killed: "+ string(pl.stats[? "mobs_killed_total"]) + "/" + string(gamemode_obj.stats[? "mobs_spawned"]);
    }
    else
    {
        center_overlay.message = "It's a draw!";
    
        if(winner != noone)
        {
            center_overlay.message = winner.name + " WINS!"
            
            if(mode == "volleyball" && player_count > 2)
            {
                center_overlay.message = "Team " + string(winner.team_number) + " WINS!"
            }
        }  
        
        
    }
    
    center_overlay.adjusted = false;
}
alarm[4] = 300;

if(mode == "sparring")
{
    var player = players[? 1];
    var guy = player.my_guy; 
    
    if(player.loser)
    {
        if(guy.last_attacker_map[? "source_id"] != guy)
        {
            center_overlay.message = "You were killed by " + guy.last_attacker_map[? "source_name"];
        }
        else
        {
            center_overlay.message = "You killed yourself...";
        }
    }
    else if(player.winner)
    {
        center_overlay.message = "You are ready for Battle!";
    }
    
    alarm[4] = 240;
}

if(reached_limit_name == "user_terminated")
{
    alarm[4] = 30;
}
    
    


