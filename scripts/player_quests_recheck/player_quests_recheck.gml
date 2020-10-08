/// @description player_quests_recheck(player)
/// @function player_quests_recheck
/// @param player
function player_quests_recheck() {
	var player = argument[0];

	var i, count = ds_list_size(player.root_quest_list);

	var checks_done = 0;

	with(player)
	{
	    for(i = 0; i < count; i++)
	    {
	        other.context_id = root_quest_list[| i];
	        checks_done += player_quest_recheck(player, other.context_id);
	    }

	    last_quests_recheck = singleton_obj.step_count;
	}

	return checks_done;



}
