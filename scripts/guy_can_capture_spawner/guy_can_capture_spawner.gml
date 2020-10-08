/// @param guy
/// @param spawner
function guy_can_capture_spawner() {

	var guy = argument[0];
	var spawner = argument[1];

	var player = guy.my_player;
	var player_num = player.number;

	return (spawner.enabled && !(guy.lost_control || guy.dead) 
	    && (player != gamemode_obj.environment || spawner.for_player == 0)
	    && (spawner.for_player == -1 || spawner.for_player == player_num)
	    && (spawner.object_index != guy_spawner_obj || is_undefined(spawner.my_players[| 0]) 
	        || spawner.my_players[| 0].team_number == -1 || spawner.my_players[| 0].team_number == player.team_number));
	    //&& (spawner.object_index != guy_spawner_obj || !instance_exists(spawner.my_player) || spawner.my_player.team_number == -1 || spawner.my_player.team_number == player.team_number));




}
