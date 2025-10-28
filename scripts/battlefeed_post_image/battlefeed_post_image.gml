/// @param {Id.Instance} player
/// @param {Asset.GMSprite} image
function battlefeed_post_image(player, image) {
    var feedItem = battlefeed_post_new("image");

    feedItem.assignPlayer(player);
    feedItem.add("image", image, g_white);

    return feedItem;
}
