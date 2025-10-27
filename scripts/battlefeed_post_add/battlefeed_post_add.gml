/// @param {Id.Instance} feedItem
/// @param {String} type one of: "text", "icon", "image"
/// @param {String|Asset.GMObject} content
/// @param {Real|String} color g_* or "bf_orange"
/// @param {Real} facing 1 or -1
function battlefeed_post_add(feedItem, type, content, color, facing = 1) {
    if (!instance_exists(feedItem)) {
        return;
    }

    battlefeed_post_insert(feedItem, feedItem.content_length, type, content, color, facing);

    feedItem.content_length += 1;
}
