/// @description battlefeed_post_string(player, string)
/// @function battlefeed_post_string
/// @param player
/// @param  string
function battlefeed_post_string(argument0, argument1) {
	var player = argument0;
	var str = argument1;

	var feed_item = battlefeed_post_new("string");
	battlefeed_post_assignplayer(feed_item, player);
	battlefeed_post_add(feed_item, "text", str, g_white);

	return feed_item;



}
