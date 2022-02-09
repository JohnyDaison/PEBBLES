/// @description  UPDATE ACHIEVEMENTS IF MY_GUY EXISTS
var achiev_script, title;

if(instance_exists(my_guy))
{
    // UPDATE achievs
    for(var i = 1; i<= achiev_count; i++)
    { 
        var state = achiev_state[?i];
        
        if(state == 0)
        {
            achiev_script = ds_map_find_value(achievs,i);
            title = script_execute(achiev_script,"title");
            
            if(script_execute(achiev_script,"fail"))
            {
                state = -1;
            }
            else if(script_execute(achiev_script,"success"))
            {
                state = 1;
                battlefeed_post_string(gamemode_obj.environment, my_player.name + " " + script_execute(achiev_script,"verb"));
                
                var reward_score = script_execute(achiev_script, "reward_score");
                var score_str = "";
                if (is_number(reward_score) && reward_score != 0) {
                    score_str = stat_label("score", reward_score, "+");
                    increase_achievement_score(my_player, reward_score, false);
                }
                
                battlefeed_post_achievement(achiev_script, my_player, score_str);
                script_execute(achiev_script,"reward");
            }

            achiev_state[?i] = state;
        }
    }
}

alarm[2] = achiev_delay;