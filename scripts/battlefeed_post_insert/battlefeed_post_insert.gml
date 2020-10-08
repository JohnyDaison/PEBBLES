/// @description battlefeed_post_insert(feed_item, index, type, content, color, [facing])
/// @function battlefeed_post_insert
/// @param feed_item
/// @param  index
/// @param  type
/// @param  content
/// @param  color
/// @param  [facing]
function battlefeed_post_insert() {
	var item = argument[0];
	var index = argument[1];
	var type = argument[2];
	var content = argument[3];
	var color = argument[4];
	var content_facing = 1;

	if(argument_count > 5)
	{
	    content_facing = argument[5];
	}

	var sprite;

	if(instance_exists(item))
	{
	    item.type[? index] = type;
	    if(type == "text")
	    {
	        item.content[? index] = content;    
	    }
	    else if(type == "icon")
	    {
	        sprite = DB.bf_icon_map[? content];
	        //var icon_str = "";
        
	        if(!is_undefined(sprite) && sprite_exists(sprite))
	        {
	            item.content[? index] = sprite;
	            //icon_str = sprite_get_name(sprite) + " sprite(" + string(sprite) + ") " + object_get_name(sprite);
	        }
	        else if(is_undefined(sprite) && sprite_exists(content))
	        {
	            item.content[? index] = content;
	            //icon_str = sprite_get_name(content) + " content(" + string(content) + ") " + object_get_name(content);
	        }
	        else
	        {
	            item.type[? index] = "text";
	            if(is_string(content))
	            {
	                item.content[? index] = content;
	            }
	            else if(object_exists(content))
	            {
	                item.content[? index] = object_get_name(content);
	            }
	            //icon_str = "text " + item.content[? index];
	        }
        
	        //my_console_log("BATTLEFEED INSERT ICON " + icon_str);
	    }
    
	    item.tint[? index] = DB.colormap[? color];
	    item.facing[? index] = content_facing;
    
	    //item.content_length += 1;
	}



}
