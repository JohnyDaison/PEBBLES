/// @description battlefeed_post_addblank(feed_item, id)
/// @function battlefeed_post_addblank
/// @param feed_item
/// @param  id
function battlefeed_post_addblank() {
	var item = argument[0];
	var blank_id = argument[1];

	if(instance_exists(item))
	{
	    item.blanks[? blank_id] = item.content_length;
	    battlefeed_post_add(item, "blank", blank_id, g_black);
	}



}
