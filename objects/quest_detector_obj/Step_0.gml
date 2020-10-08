if (!ready)
{
    exit;   
}

var pl_count = gamemode_obj.player_count, pl_index, player;
var main_quest_state;

for(pl_index = 1; pl_index <= pl_count; pl_index++)
{
    if(for_player != -1 && for_player != pl_index)
    {
        continue;   
    }
    
    player = gamemode_obj.players[? pl_index];
    
    main_quest_state = player_quest_state_find(player, quest_id, "", "");
    
    if(!main_quest_state)
    {
        continue;
    }
    
    var subtask_state = player_quest_state_find(player, quest_id + "_" + subtask_id, "", "");
    var subtask_current_state = subtask_state[? "current_state"];
    var subtask_last_state = subtask_state[? "last_state"];
    
    if(subtask_current_state == "success")
    {
        energy += reward_energy;
        my_color = reward_color;
        active = true;
        ready = false;
    }
}