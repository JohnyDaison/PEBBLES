/// @description battlefeed_post_add(feed_item, type, content, color, [facing])
/// @function battlefeed_post_add
/// @param feed_item
/// @param  type
/// @param  content
/// @param  color
/// @param  [facing]
function battlefeed_post_add() {
	var item = argument[0];
	var type = argument[1];
	var content = argument[2];
	var color = argument[3];
	var content_facing = 1;

	if(argument_count > 4)
	{
	    content_facing = argument[4];
	}

	if(instance_exists(item))
	{
	    new_index = item.content_length;
    
	    battlefeed_post_insert(item, item.content_length, type, content, color, content_facing);
    
	    item.content_length += 1;
	}



}
