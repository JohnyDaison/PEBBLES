/// @description  getset_gamespeed([ticks])
/// @function  getset_gamespeed
/// @param [ticks]
function getset_gamespeed() {
	if(argument_count > 0)
	{
	    game_set_speed(max(5, round(argument[0])), gamespeed_fps);
	}

	return game_get_speed(gamespeed_fps);



}
