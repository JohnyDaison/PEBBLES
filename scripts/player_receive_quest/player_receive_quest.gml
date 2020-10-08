/// @description player_receive_quest(player, quest_id, context_id, category)
/// @function player_receive_quest
/// @param player
/// @param  quest_id
/// @param  context_id
/// @param  category
function player_receive_quest() {
	var player = argument[0];
	var quest_id = argument[1];
	var context_id = argument[2];
	var category = argument[3];

	var quest_state = player_quest_state_create(player, quest_id, noone, context_id, category);
	if(!is_undefined(quest_state))
	{
	    player_quest_state_update(player, context_id, "setstate", "start");
	}

	return quest_state;



}
