/// @description battlefeed_post_assignfeed(feed_item, battlefeed_obj)
/// @function battlefeed_post_assignfeed
/// @param feed_item
/// @param  battlefeed_obj
function battlefeed_post_assignfeed(argument0, argument1) {
	var item = argument0;
	var feed = argument1;

	var message_list = feed.msg_list;

	ds_list_add(message_list, item);
	item.battlefeed = feed;



}
