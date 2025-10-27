/// @param {Id.Instance} feedItem
/// @param {String} blankId
/// @param {String} type one of: "text", "icon", "image"
/// @param {String|Asset.GMObject} content
/// @param {Real|String} color g_* or "bf_orange"
/// @param {Real} facing 1 or -1
function battlefeed_post_fillblank(feedItem, blankId, type, content, color, facing = 1) {
    if (!instance_exists(feedItem)) {
        return;
    }

    var blankIndex = feedItem.blanks[? blankId];

    if (is_undefined(blankIndex)) {
        return;
    }

    battlefeed_post_insert(feedItem, blankIndex, type, content, color, facing);
}
