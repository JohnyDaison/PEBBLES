/// @param {Id.Instance} feedItem
/// @param {Real} index position within the Feed Item
/// @param {String} type one of: "text", "icon", "image"
/// @param {String|Asset.GMObject} content
/// @param {Real|String} color g_* or "bf_orange"
/// @param {Real} facing 1 or -1
function battlefeed_post_insert(feedItem, index, type, content, color, facing = 1) {
    if (!instance_exists(feedItem)) {
        return;
    }
    
    feedItem.type[? index] = type;
    if(type == "text")
    {
        feedItem.content[? index] = content;
    }
    else if(type == "icon")
    {
        var sprite = DB.battlefeed_icon_map[? content];
        //var icon_str = "";
    
        if(!is_undefined(sprite) && sprite_exists(sprite))
        {
            feedItem.content[? index] = sprite;
            //icon_str = sprite_get_name(sprite) + " sprite(" + string(sprite) + ") " + object_get_name(sprite);
        }
        else
        {
            feedItem.type[? index] = "text";
            if(is_string(content))
            {
                feedItem.content[? index] = content;
            }
            else if(object_exists(content))
            {
                feedItem.content[? index] = object_get_name(content);
            }
            //icon_str = "text " + item.content[? index];
        }
    
        //my_console_log("BATTLEFEED INSERT ICON " + icon_str);
    }
    else if(type == "image") 
    {
        if(sprite_exists(content))
        {
            feedItem.type[? index] = "icon";
            feedItem.content[? index] = content;
        }
        else
        {
            feedItem.type[? index] = "text";
            feedItem.content[? index] = string(content);
        }
    }

    feedItem.tint[? index] = DB.colormap[? color];
    feedItem.facing[? index] = facing;
}
