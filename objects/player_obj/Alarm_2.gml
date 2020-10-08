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
                battlefeed_post_string(my_player, my_player.name + " " + script_execute(achiev_script,"verb"));
                script_execute(achiev_script,"reward");
            }

            achiev_state[?i] = state;
        }
    }
}

alarm[2] = achiev_delay;