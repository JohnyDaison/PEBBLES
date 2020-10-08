/// @description player_quests_clear(player)
/// @function player_quests_clear
/// @param player
function player_quests_clear() {
	var player = argument[0];

	var i, context, count = ds_list_size(player.root_quest_list);

	for(i = count-1; i >= 0; i--)
	{
	    context = player.root_quest_list[| i];
	    player_quest_state_destroy(player, context);
	}

	return count;



}
