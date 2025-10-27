/// @param {Id.Instance} player
/// @param {Asset.GMObject} what
/// @param {Real} score_gain
function battlefeed_post_pickup(player, what, score_gain) {
    var posted = false;
    var feed = gamemode_obj.battlefeed;

    if (instance_exists(player.battlefeed)) {
        feed = player.battlefeed;
    }

    var count = ds_list_size(feed.msg_list);
    var last_item = noone, feed_item = noone;

    if (count > 0) {
        last_item = feed.msg_list[| count - 1]
    }

    if (instance_exists(last_item) && last_item.item_type == "pickup" && last_item.got_item == what) {
        feed_item = last_item;

        var new_score = feed_item.score_value + score_gain;
        var new_score_str = string(new_score);

        if (new_score >= 0) {
            new_score_str = "+" + new_score_str;
        }

        feed_item.score_value = new_score;
        feed_item.content[? 0] = new_score_str;
        feed_item.fade_ratio = feed_item.init_fade_ratio;
    }
    else {
        feed_item = battlefeed_post_new("pickup");
        battlefeed_post_assignplayer(feed_item, player);

        var new_score_str = string(score_gain);

        if (score_gain >= 0) {
            new_score_str = "+" + new_score_str;
        }

        battlefeed_post_add(feed_item, "text", new_score_str, g_yellow);
        battlefeed_post_add(feed_item, "icon", what, "bf_orange");
        feed_item.got_item = what;
        feed_item.score_value = score_gain;
    }

    return feed_item;
}
