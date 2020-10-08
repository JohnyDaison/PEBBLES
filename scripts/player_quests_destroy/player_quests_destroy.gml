/// @description player_quests_destroy(player)
/// @function player_quests_destroy
/// @param player
function player_quests_destroy(argument0) {
	var player = argument0;

	with(player)
	{
	    var i, context, count = ds_list_size(root_quest_list);
    
	    for(i = count-1; i >= 0; i--)
	    {
	        context = root_quest_list[| i];
	        player_quest_state_destroy(id, context);
	    }
    
	    ds_list_destroy(quest_category_list);
	    ds_list_destroy(root_quest_list);
	    ds_list_destroy(all_quest_list);
	    ds_map_destroy(quest_states);
	}

	return count;



}
