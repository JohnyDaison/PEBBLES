self.battlefeed = noone;
self.width = 0;
self.height = 0;
self.content_length = 0;
self.item_type = "";
self.got_item = undefined;
self.score_value = 0;

self.type = ds_map_create();
self.content = ds_map_create();
self.tint = ds_map_create();
self.facing = ds_map_create();
self.blanks = ds_map_create();

self.init_fade_ratio = 4;
self.blinkin_duration = 0.75;
self.fade_ratio = self.init_fade_ratio;


/// @param {String} type one of: "text", "icon", "image"
/// @param {String|Asset.GMObject} content
/// @param {Real|String} color g_* or "bf_orange"
/// @param {Real} facing 1 or -1
function add(type, content, color, facing = 1) {
    self.setValuesAtIndex(self.content_length, type, content, color, facing);

    self.content_length += 1;
}

/// @param {String} blankId
function addBlank(blankId) {
    self.blanks[? blankId] = self.content_length;

    self.add("blank", blankId, g_dark);
}

/// @param {Id.Instance} feed battlefeed_obj
function assignFeed(feed) {
    var message_list = feed.msg_list;

    ds_list_add(message_list, self.id);
    self.battlefeed = feed;
}

/// @param {Id.Instance} player
function assignPlayer(player) {
    if (instance_exists(player.battlefeed)) {
        self.assignFeed(player.battlefeed);
    }
    else {
        self.assignFeed(gamemode_obj.battlefeed);
    }
}

/// @param {String} blankId
/// @param {String} type one of: "text", "icon", "image"
/// @param {String|Asset.GMObject} content
/// @param {Real|String} color g_* or "bf_orange"
/// @param {Real} facing 1 or -1
function fillBlank(blankId, type, content, color, facing = 1) {
    var blankIndex = self.blanks[? blankId];

    if (is_undefined(blankIndex)) {
        return;
    }

    self.setValuesAtIndex(blankIndex, type, content, color, facing);
}

/// @param {Real} index position within the Feed Item
/// @param {String} type one of: "text", "icon", "image"
/// @param {String|Asset.GMObject} content
/// @param {Real|String} color g_* or "bf_orange"
/// @param {Real} facing 1 or -1
function setValuesAtIndex(index, type, content, color, facing = 1) {
    self.type[? index] = type;

    if (type == "text") {
        self.content[? index] = content;
    }
    else if (type == "icon") {
        var sprite = DB.battlefeed_icon_map[? content];
        //var icon_str = "";

        if (!is_undefined(sprite) && sprite_exists(sprite)) {
            self.content[? index] = sprite;
            //icon_str = sprite_get_name(sprite) + " sprite(" + string(sprite) + ") " + object_get_name(sprite);
        }
        else {
            self.type[? index] = "text";

            if (is_string(content)) {
                self.content[? index] = content;
            }
            else if (object_exists(content)) {
                self.content[? index] = object_get_name(content);
            }
            //icon_str = "text " + item.content[? index];
        }

        //my_console_log("BATTLEFEED SET ICON " + icon_str);
    }
    else if (type == "image") {
        if (sprite_exists(content)) {
            self.type[? index] = "icon";
            self.content[? index] = content;
        }
        else {
            self.type[? index] = "text";
            self.content[? index] = string(content);
        }
    }

    self.tint[? index] = DB.colormap[? color];
    self.facing[? index] = facing;
}
