/// @description player_quest_state_find(player, quest_id, context, category)
/// @function player_quest_state_find
/// @param player
/// @param  quest_id
/// @param  context
/// @param  category
function player_quest_state_find() {
	var player = argument[0];
	var quest_id_str = argument[1];
	var context_str = argument[2];
	var category_str = argument[3];

	var i, count = ds_list_size(player.all_quest_list);
	for(i = 0; i< count; i++)
	{
	    var context = player.all_quest_list[| i];
	    var quest_state = player.quest_states[? context];
    
	    if((context_str == "" || context_str == context)
	    && (quest_id_str == "" || quest_id_str == quest_state[? "quest_id"])
	    && (category_str == "" || category_str == quest_state[? "category"]) )
	    {
	        return quest_state;
	    }
	}

	return false;



}
