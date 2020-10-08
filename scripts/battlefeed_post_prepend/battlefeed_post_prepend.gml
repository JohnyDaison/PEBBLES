/// @description battlefeed_post_prepend(feed_item, type, content, color, [facing])
/// @function battlefeed_post_prepend
/// @param feed_item
/// @param  type
/// @param  content
/// @param  color
/// @param  [facing]
function battlefeed_post_prepend() {
	var item = argument[0];
	var type = argument[1];
	var content = argument[2];
	var color = argument[3];
	var content_facing = 1;

	if(argument_count > 4)
	{
	    content_facing = argument_count[4];
	}

	battlefeed_post_insert(item, 0, type, content, color, content_facing);



}
