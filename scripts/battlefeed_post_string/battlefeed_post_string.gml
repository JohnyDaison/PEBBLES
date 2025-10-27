/// @param {Id.Instance} player
/// @param {String} str
function battlefeed_post_string(player, str) {
    var feed_item = battlefeed_post_new("string");

    battlefeed_post_assignplayer(feed_item, player);
    battlefeed_post_add(feed_item, "text", str, g_white);

    return feed_item;
}
