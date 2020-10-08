/// @description go_to_quest_command(quest_number)
/// @function go_to_quest_command
/// @param quest_number
function go_to_quest_command() {
	var quest_number = argument[0];

	return player_quest_skip_to_command(1, quest_number);



}
