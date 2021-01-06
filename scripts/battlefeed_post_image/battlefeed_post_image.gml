/// @description battlefeed_post_image(player, image)
/// @function battlefeed_post_image
/// @param player
/// @param image
function battlefeed_post_image(argument0, argument1) {
    var player = argument0;
    var image = argument1;

    var feed_item = battlefeed_post_new("image");
    battlefeed_post_assignplayer(feed_item, player);
    battlefeed_post_add(feed_item, "image", image, g_white);

    return feed_item;
}
