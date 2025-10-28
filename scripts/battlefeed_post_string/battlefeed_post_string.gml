/// @param {Id.Instance} player
/// @param {String} str
function battlefeed_post_string(player, str) {
    var feedItem = battlefeed_post_new("string");

    feedItem.assignPlayer(player);
    feedItem.add("text", str, g_white);

    return feedItem;
}
