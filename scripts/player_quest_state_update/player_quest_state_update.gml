/// @description player_quest_state_update(player, context, type, [value])
/// @function player_quest_state_update
/// @param player
/// @param  context
/// @param  type
/// @param  [value]
function player_quest_state_update() {
	var player = argument[0];
	var context = argument[1];
	var type = argument[2];
	var value;

	if(argument_count > 3)
	{
	    value = argument[3];
	}

	var quest_state = player.quest_states[? context];
	var quest_id = quest_state[? "quest_id"];
	var quest_node = DB.quest_nodes[? quest_id];
	var root_context = quest_state[? "root_context"];
	var cur_reps = quest_state[? "state_reps"];

	if(type == "setstate")
	{
	    quest_state[? "last_state"] = quest_state[? "current_state"];
	    quest_state[? "current_state"] = value;
	    cur_reps[? value]++;
    
	    /*
	    if(value == "success") // && quest_state[? "context"] == quest_state[? "root_context"]
	    {
	        battlefeed_post_string(player, "Quest complete: " + quest_node[? "name"]);
	    }
	    */
    
	    // this should schedule a recheck of the root_context    
	}




}
