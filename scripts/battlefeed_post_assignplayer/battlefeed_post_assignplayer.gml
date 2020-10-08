/// @description battlefeed_post_assignplayer(feed_item, player_obj)
/// @function battlefeed_post_assignplayer
/// @param feed_item
/// @param  player_obj
function battlefeed_post_assignplayer(argument0, argument1) {
	var item = argument0;
	var player = argument1;

	if(instance_exists(player.battlefeed))
	{
	    battlefeed_post_assignfeed(item, player.battlefeed);
	}
	else
	{
	    battlefeed_post_assignfeed(item, gamemode_obj.battlefeed);
	}



}
