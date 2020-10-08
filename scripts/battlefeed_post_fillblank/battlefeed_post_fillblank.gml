/// @description battlefeed_post_fillblank(feed_item, blank_id, type, content, color, [facing])
/// @function battlefeed_post_fillblank
/// @param feed_item
/// @param  blank_id
/// @param  type
/// @param  content
/// @param  color
/// @param  [facing]
function battlefeed_post_fillblank() {
	var item = argument[0];
	var blank_id = argument[1];
	var type = argument[2];
	var content = argument[3];
	var color = argument[4];
	var content_facing = 1;

	if(argument_count > 5)
	{
	    content_facing = argument[5];
	}

	if(instance_exists(item))
	{
	    var blank_index = item.blanks[? blank_id];
    
	    if(!is_undefined(blank_index))
	    {
	        battlefeed_post_insert(item, blank_index, type, content, color, content_facing);
	    }
	}



}
