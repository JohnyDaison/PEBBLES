/// @description add_player_overlay(overlay, player);
/// @function add_player_overlay
/// @param overlay
/// @param player
function add_player_overlay() {
	var overlay = argument[0];
	var player = argument[1];

	i = add_frame(overlay);
	i.my_player = player;
	i.my_guy = player.my_guy;

	return i;



}
