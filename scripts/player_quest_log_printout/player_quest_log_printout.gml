/// @description player_quest_log_printout(player_number, [level_of_detail])
/// @function player_quest_log_printout
/// @param player_number
/// @param [level_of_detail]
function player_quest_log_printout() {
	var number = argument[0];
	var level_of_detail = 2;

	if(argument_count > 1)
	{
	    level_of_detail = argument[1];
	}

	var player = gamemode_obj.players[? number];

	if(is_undefined(player))
	{
	    return 0;
	}

	my_console_write("==================QUEST LOG==================");

	count = ds_list_size(player.root_quest_list);

	for(i = 0; i < count; i++)
	{
	    context = player.root_quest_list[| i];
    
	    player_quest_state_printout(player, context, 1, level_of_detail);
	}

	my_console_write("=============================================");
}
