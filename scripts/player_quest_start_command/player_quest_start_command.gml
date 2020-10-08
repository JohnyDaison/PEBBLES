/// @description player_quest_start_command(player_number, quest_id, context_id, category)
/// @function player_quest_start_command
/// @param player_number
/// @param  quest_id
/// @param  context_id
/// @param  category
function player_quest_start_command() {
	var number = argument[0];

	var player = gamemode_obj.players[? number];

	if(is_undefined(player))
	{
	    return 0;
	}

	return player_receive_quest(player, argument[1], argument[2], argument[3]);



}
