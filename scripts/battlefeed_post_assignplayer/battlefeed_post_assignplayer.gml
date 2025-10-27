/// @param {Id.Instance} feedItem
/// @param {Id.Instance} player
function battlefeed_post_assignplayer(feedItem, player) {
    if (instance_exists(player.battlefeed)) {
        battlefeed_post_assignfeed(feedItem, player.battlefeed);
    }
    else {
        battlefeed_post_assignfeed(feedItem, gamemode_obj.battlefeed);
    }
}
