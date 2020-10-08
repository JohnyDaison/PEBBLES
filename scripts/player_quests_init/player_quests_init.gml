/// @description player_quests_init(player)
/// @function player_quests_init
/// @param player
function player_quests_init(argument0) {
	var player = argument0;

	with(player)
	{
	    quest_category_list = ds_list_create();
	    root_quest_list = ds_list_create();
	    all_quest_list = ds_list_create();
	    quest_states = ds_map_create();
	    quest_recheck_delay = 15; // 60;
	    last_quests_recheck = 0;
	}



}
