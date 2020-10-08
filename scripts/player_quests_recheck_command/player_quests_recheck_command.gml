/// @description player_quests_recheck_command(player_number)
/// @function player_quests_recheck_command
/// @param player_number
function player_quests_recheck_command() {
	var number = argument[0];

	var player = gamemode_obj.players[? number];

	if(is_undefined(player))
	{
	    return 0;
	}

	return player_quests_recheck(player);



}
