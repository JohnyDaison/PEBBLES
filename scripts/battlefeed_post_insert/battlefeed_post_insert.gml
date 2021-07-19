/// @param feed_item
/// @param index
/// @param type
/// @param content
/// @param color
/// @param [facing]
function battlefeed_post_insert(item, index, type, content, color) {
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
            sprite = DB.battlefeed_icon_map[? content];
            //var icon_str = "";
        
            if(!is_undefined(sprite) && sprite_exists(sprite))
            {
                item.content[? index] = sprite;
                //icon_str = sprite_get_name(sprite) + " sprite(" + string(sprite) + ") " + object_get_name(sprite);
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
        else if(type == "image") 
        {
            if(sprite_exists(content))
            {
                item.type[? index] = "icon";
                item.content[? index] = content;
            }
            else
            {
                item.type[? index] = "text";
                item.content[? index] = string(content);
            }
        }
    
        item.tint[? index] = DB.colormap[? color];
        item.facing[? index] = content_facing;
    }
}
