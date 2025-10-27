/// @param {Id.Instance} player
/// @param {Asset.GMSprite} image
function battlefeed_post_image(player, image) {
    var feedItem = battlefeed_post_new("image");

    battlefeed_post_assignplayer(feedItem, player);
    battlefeed_post_add(feedItem, "image", image, g_white);

    return feedItem;
}
