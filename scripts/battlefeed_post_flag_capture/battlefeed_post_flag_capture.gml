/// @param {Id.Instance} flag
/// @param {Id.Instance} capturer
/// @param {String} stat_str
function battlefeed_post_flag_capture(flag, capturer, stat_str = "") {
    var feed_item = noone;
    var actor_name = "", victim_name = "";
    var is_in_player_feed = false;

    if (!instance_exists(flag)) {
        if (stat_str != "") {
            feed_item = battlefeed_post_string(gamemode_obj.environment, stat_str);
        }

        return feed_item;
    }

    feed_item = battlefeed_post_new("flag_capture");

    feed_item.addBlank("actorflag");
    feed_item.addBlank("name");
    feed_item.addBlank("score");
    feed_item.addBlank("victimname");
    feed_item.addBlank("victimflag");

    var victimPlayer = flag.my_flag_spawner.my_player;
    victim_name = victimPlayer.name;

    var la_player = capturer.my_player;
    actor_name = la_player.name;

    feed_item.assignPlayer(la_player);
    is_in_player_feed = feed_item.battlefeed == la_player.battlefeed;

    /*
    if(!is_in_player_feed) {
        feed_item.fillBlank("actorflag", "icon", la_player.flag, g_white);
    }
    */

    if (victimPlayer != gamemode_obj.environment) {
        feed_item.fillBlank("victimflag", "icon", victimPlayer.flag, "bf_orange");
    }

    if (actor_name != "" && actor_name != gamemode_obj.environment.name && !is_in_player_feed) {
        feed_item.fillBlank("name", "text", actor_name, g_white);
    }

    if (stat_str != "") {
        var DBindex = ds_list_find_index(DB.stats_display_keys, "score");
        var score_label = DB.stats_display_labels[| DBindex];

        stat_str = string_replace(stat_str, score_label + " ", "");

        feed_item.fillBlank("score", "text", stat_str, g_yellow);
    }

    /*
    if(flag.my_flag_spawner.my_player != gamemode_obj.environment) { // victim_name != my_player.name && 
        feed_item.fillBlank("victimname", "text", victim_name, g_white); // "bf_orange"
    }
    */

    // debug
    /*
    var debug_str = "";
    for(var ii = 0; ii < feed_item.content_length; ii++) {
        debug_str += feed_item.type[? ii] + ":" + string(feed_item.content[? ii]) + " | ";
    }
    my_console_log(debug_str);
    */

    return feed_item;
}
