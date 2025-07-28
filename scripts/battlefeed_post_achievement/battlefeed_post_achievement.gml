/// @param {Asset.GMScript} achievement
/// @param {Id.Instance} player
/// @param {String} [stat_str]
/// @return {Id.Instance}
function battlefeed_post_achievement(achievement, player, stat_str = "") {
    var feed_item = noone;
    var is_in_player_feed = false;

    if (script_exists(achievement)) {
        feed_item = battlefeed_post_new("achievement");

        battlefeed_post_addblank(feed_item, "score");
        battlefeed_post_addblank(feed_item, "title");

        battlefeed_post_assignplayer(feed_item, player);
        is_in_player_feed = feed_item.battlefeed == player.battlefeed;

        battlefeed_post_fillblank(feed_item, "title", "text", script_execute(achievement, "title"), g_white);

        if (stat_str != "") {
            var DBindex = ds_list_find_index(DB.stats_display_keys, "score");
            var score_label = DB.stats_display_labels[| DBindex];

            stat_str = string_replace(stat_str, score_label + " ", "");

            battlefeed_post_fillblank(feed_item, "score", "text", stat_str, g_yellow);
        }
    }
    else if (stat_str != "") {
        battlefeed_post_string(gamemode_obj.environment, stat_str);
    }

    return feed_item;
}
