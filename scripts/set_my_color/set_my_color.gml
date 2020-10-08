/// @description set_my_color(game_color)
/// @function set_my_color
/// @param game_color
function set_my_color(argument0) {
	var color = argument0;

	my_last_color = my_color;
	my_color = color;
	//color_to_components(my_color);
	tint_updated = false;

	if(my_player.my_guy == id)
	{
	    broadcast_event("my_body_color_change", id);
	}



}
