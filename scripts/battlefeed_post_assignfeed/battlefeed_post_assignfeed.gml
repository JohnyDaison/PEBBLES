/// @param {Id.Instance} feedItem
/// @param {Id.Instance} feed battlefeed_obj
function battlefeed_post_assignfeed(feedItem, feed) {
    var message_list = feed.msg_list;

    ds_list_add(message_list, feedItem);
    feedItem.battlefeed = feed;
}
