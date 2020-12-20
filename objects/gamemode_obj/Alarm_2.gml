/// @description GUI AND LIMITS
if(!created_gui)
{
    width = singleton_obj.current_width;
    height = singleton_obj.current_height;
    
    time_window = add_frame(timer_window);
    time_window.x = width/2 - time_window.width/2;
    if(gamemode_obj.player_count == 1)
    {
        time_window.x = width*0.25 - time_window.width/2;
    }
    time_window.y = 56;
    time_window.visible = false;

    created_gui = true;  
}

if(!match_started)
{
    reached_limit_name = "";
            
    match_start_time = current_time;
    last_minute = current_minute;
    
    if(do_phenomena)
    {
        instance_create(0,0,phenomena_obj);
    }
    
    match_started = true;   
}


time_limit = 0;

var player;
var player_defeat_count = 0, team_defeat_count = 0;

// COMPUTE DEFEAT COUNTS
if(player_count > 0)
{
    var team_number = 0;
    var team_member_count, team_member_defeat_count, team_defeated;
        
    for(i=1; i<=player_count; i++)
    {
        player = players[? i];
        if(player.loser)
        {
            player_defeat_count++;
        }
    }
        
    if(player_count > 2)
    {
        repeat(team_count)
        {
            team_number++;
            team_member_defeat_count = 0;
            team_member_count = 0;
                
            with(player_obj)
            {
                if(self.team_number == team_number)
                {
                    team_member_count++;
                    if(self.loser)
                    {
                        team_member_defeat_count++;
                    }
                }
            }
                
            if(team_member_defeat_count == team_member_count)
            {
                team_defeat_count++;   
            }
        }
    }
}

// LIMITS
if(!limit_reached)
{
    // STAT BASED LIMITS
    for(i=0; i<DB.limit_count && !limit_reached; i++)
    {
        var limit_name = DB.limit_ids[| i];
        if(limit_active[? limit_name])
        {
            limit_value = limits[? limit_name];
            
            //show_debug_message("limit: "+string(limit_name));
            //show_debug_message("player_count: "+string(player_count));
            
            switch(limit_name)
            {
                case("score"):
                case("kills"):
                case("deaths"):
                
                    for(ii=1;ii<=player_count;ii+=1)
                    {
                        player = players[? ii];
                        if(player.stats[? limit_name] >= limit_value)
                        {
                            limit_reached = true;
                        }
                    }
                
                break;
                
                case("time"):
                
                    time_limit = limit_value*60;
                    if((current_time-match_start_time) > time_limit*1000)
                    {
                        limit_reached = true;
                    }
                
                break;
                
                case("walls"):
                
                    if(ds_map_find_value(stats,"terrain_destroyed") >= limit_value)
                    {
                        limit_reached = true;
                    }
                
                break;
                
                case("sudden_death"):
                    
                    if((current_time-match_start_time) > limit_value*60000)
                    {
                        if(!sudden_death)
                        {
                            sudden_death = true;
                            var overlay = add_frame(center_overlay);
                            overlay.message = "Sudden Death";
                            overlay.alarm[2] = 240;
                        }
                    }
                
                break;
            }
            
            if(limit_reached && reached_limit_name == "")
            {
                reached_limit_name = limit_name;
            }
        }
    }
    
    // PERMADEATH LIMIT
    if(player_count > 0)
    {
        if(is_coop || player_count == 1)
        {
            if(player_defeat_count >= player_count) // all players
            {
                limit_reached = true;
            }
        }
        else
        {
            if(player_defeat_count >= player_count-1 || team_defeat_count >= team_count-1) // all but one
            {
                limit_reached = true;
            }
        }
    }
    
    alarm[2] = 60;
}
else
{
    if(!match_finished)
    {
        chunk_deoptimizer();
        
        show_debug_message("limit reached: "+string(reached_limit_name));
                                   
        if(instance_exists(main_camera_obj))
        {
            main_camera_obj.on = true;
        }
        
        with(score_overlay)
        {
            stage = 0;
        }
        with(overhead_overlay)
        {
            instance_destroy();
        }
        with(inventory_overlay)
        {
            instance_destroy();
        }
        with(healthbar_overlay)
        {
            instance_destroy();
        }
        with(tutorial_overlay)
        {
            instance_destroy();
        }
        with(radial_overlay)
        {
            instance_destroy();
        }
        
        // final stats
        with(player_obj)
        {
            var new_dmg, new_ratio;
            new_dmg = round((spell_dmg_total + wall_dmg_total + burn_dmg_total) * 100);
            set_stat(id, "damage_received", new_dmg, false);
            
            new_dmg = round(dealt_dmg_total*100);
            set_stat(id, "damage_dealt", new_dmg, false);
            
            new_dmg = round(healed_dmg_total*100);
            set_stat(id, "damage_healed", new_dmg, false);
            
            new_dmg = round(rewound_dmg_total*100);
            set_stat(id, "damage_rewound", new_dmg, false);
            
            if(stats[? "total_actions"] > 0)
            {
                new_ratio = round((dealt_dmg_total * 10000) / stats[? "total_actions"])/100;
                set_stat(id, "damage_to_actions_ratio", new_ratio, false);
            }
            
            if(stats[? "spells"] > 0)
            {
                new_ratio = round((dealt_dmg_total * 10000) / stats[? "spells"])/100;
                set_stat(id, "damage_to_spells_ratio", new_ratio, false);
            }
            
            if(stats[? "hit_count"] > 0)
            {
                new_ratio = round((stats[? "attack_color_ratio_total"] * 100) / stats[? "hit_count"]);
                set_stat(id, "attack_color_efficiency", new_ratio, false);
            }
            
            if(stats[? "received_hits"] > 0)
            {
                new_ratio = round((stats[? "attack_color_ratio_total"] * 100) / stats[? "received_hits"]);
                set_stat(id, "defense_color_efficiency", new_ratio, false);
            }
            
            set_stat(id, "channeling_time", floor(stats[? "channeling_time"]/singleton_obj.game_speed), false);
        }

        add_frame(center_overlay);
        
        // winner
        var i, marked_winner = noone;
        winner = noone;
        
        for(i=1; i <= player_count; i++)
        {
            player = players[? i];
            
            if(!is_coop)
            {
                set_stat(player, "percent_on_opponents_half", player.stats[? "time_on_opponents_half"] *100/singleton_obj.step_count, false);
            }
            
            if(!player.loser)
            {
                if(marked_winner == noone && player.winner)
                {
                    marked_winner = player;
                }
                
                if(isPlayerStat(player, "score", "highest", true))
                {
                    winner = player;
                    player.winner = true;        
                }
                
                if(mode == "volleyball")
                {
                    if(team_defeat_count == team_count - 1)
                    {
                        winner = player;
                        player.winner = true;      
                    }
                    else
                    {
                        with(player_obj)
                        {
                            if(self.team_number > 0 && self.team_number != player.team_number 
                            && player.stats[? "score"] > self.stats[? "score"])
                            {
                                other.winner = player;
                                player.winner = true;        
                            }
                        }
                    }
                }
            }
        }
        
        if(winner == noone)
        {
            winner = marked_winner;   
        }
        
        // match end reason
        if(winner != noone)
        {
            if(!is_coop)
            {
                instance_create(winner.my_guy.x, winner.my_guy.y, winner_effect_obj);
                instance_create(winner.my_base.x, winner.my_base.y, winner_effect_obj);
            
                if(player_defeat_count == player_count - 1)
                {
                    center_overlay.message = "Only " + winner.name + " survived!";
                }
                else if(team_defeat_count == team_count - 1)
                {
                    center_overlay.message = "Only Team " + string(winner.team_number) + " survived!";
                }
                else
                {   
                    center_overlay.message = winner.name;
                    
                    if(mode == "volleyball" && player_count > 2)
                    {
                        center_overlay.message = "Team " + string(winner.team_number);
                    }
                    
                    if(reached_limit_name == "score")
                    {
                         var win_score = string(winner.stats[? "score"]);
                         center_overlay.message += " scored " + string(win_score) +" of " + string(limits[? "score"]);
                    }
                    else
                    {
                         center_overlay.message += " WINS!";   
                    }
                }
            }
            else
            {
                if(player_count == 1)
                {
                    center_overlay.message = "Level complete!";
                }
                else
                {
                    center_overlay.message = "Level finished by " + winner.name + "!";
                }
            }
        }
        else
        {
            if(player_defeat_count == player_count)
            {
                center_overlay.message = "No one survived...";
            }
            else
            {
                center_overlay.message = "No one reached the goal in time.";
            }
        }
        
        // match length
        if(instance_exists(time_window) && instance_exists(time_window.time))
        {
            var minutes = string(time_window.time.total div 60);    
            var seconds = string(time_window.time.total mod 60);
            
            while(string_length(minutes) < 2)
            {
                minutes = "0" + minutes;
            }
            while(string_length(seconds) < 2)
            {
                seconds = "0" + seconds;
            }

            stats[? "match_length"] = minutes + ":" + seconds;
        }
        
        // win message
        if(center_overlay.message == "")
        {
            alarm[3] = 3;
        }
        else if(reached_limit_name == "user_terminated")
        {
            alarm[3] = 30;
        }
        else
        {
            alarm[3] = 180;   
        }
        
        match_finished = true;
    }    
}
