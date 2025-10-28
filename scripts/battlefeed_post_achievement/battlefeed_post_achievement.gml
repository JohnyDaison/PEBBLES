/// @param {Struct.MyAchievement} achievement
/// @param {Id.Instance} player
/// @param {String} [stat_str]
/// @return {Id.Instance}
function battlefeed_post_achievement(achievement, player, stat_str = "") {
    var feed_item = noone;
    var is_in_player_feed = false;

    if (!is_instanceof(achievement, MyAchievement)) {
        if (stat_str != "") {
            feed_item = battlefeed_post_string(gamemode_obj.environment, stat_str);
        }
    
        return feed_item;
    }
    
    feed_item = battlefeed_post_new("achievement");

    feed_item.addBlank("score");
    feed_item.addBlank("title");

    feed_item.assignPlayer(player);
    is_in_player_feed = feed_item.battlefeed == player.battlefeed;

    feed_item.fillBlank("title", "text", achievement.title, g_white);

    if (stat_str != "") {
        var DBindex = ds_list_find_index(DB.stats_display_keys, "score");
        var score_label = DB.stats_display_labels[| DBindex];

        stat_str = string_replace(stat_str, score_label + " ", "");

        feed_item.fillBlank("score", "text", stat_str, g_yellow);
    }

    return feed_item;
}
