/// @param {Id.Instance} feedItem
/// @param {String} blankId
function battlefeed_post_addblank(feedItem, blankId) {
    if (!instance_exists(feedItem)) {
        return;
    }

    feedItem.blanks[? blankId] = feedItem.content_length;
    battlefeed_post_add(feedItem, "blank", blankId, g_dark);
}
