/// @param {Id.Instance} victim
/// @param {Id.DsMap} last_attacker_data
/// @param {String} stat_str
function battlefeed_post_destruction(victim, last_attacker_data, stat_str = "") {
    var feed_item = noone;
    var actor_name = "", victim_name = "", victim_index = noone;
    var skip_victim = false;
    var hide_item = false, is_in_player_feed = false;

    if (!instance_exists(victim)) {
        if (stat_str != "") {
            feed_item = battlefeed_post_string(gamemode_obj.environment, stat_str);
        }
    
        return feed_item;
    }
    
    feed_item = battlefeed_post_new("destruction");

    feed_item.addBlank("actorflag");
    feed_item.addBlank("name");
    feed_item.addBlank("score");
    feed_item.addBlank("actor");
    feed_item.addBlank("carrier");
    feed_item.addBlank("victim");
    feed_item.addBlank("victimname");
    feed_item.addBlank("victimflag");

    with (victim) {
        if (object_is_ancestor(self.object_index, guy_obj)) {
            victim_name = self.name;
            victim_index = guy_obj;
        }
        else {
            victim_name = self.my_player.name;
            victim_index = self.object_index;
        }

        var la_player = last_attacker_data[? "player"];

        if (la_player != noone) {
            var carrier_dir = 1;
            var skip_carrier = false;
            actor_name = la_player.name;

            feed_item.assignPlayer(la_player);
            is_in_player_feed = feed_item.battlefeed == la_player.battlefeed;

            /*
            if(!is_in_player_feed) {
                feed_item.fillBlank("actorflag", "icon", la_player.flag, g_white);
            }
            */

            if (last_attacker_data[? "source"] != noone) {
                var actor = last_attacker_data[? "source"];
                var actor_color = last_attacker_data[? "source_color"];

                if (last_attacker_data[? "source"] == guy_obj) {
                    actor_name = last_attacker_data[? "source_name"];
                }

                if (last_attacker_data[? "source_id"] == self.id) {
                    carrier_dir = -1;
                    skip_carrier = false;
                    skip_victim = true;
                }

                if (actor != guy_obj) {
                    feed_item.fillBlank("actor", "icon", actor, "bf_orange");
                }
            }

            if (!skip_carrier && last_attacker_data[? "carrier"] != noone) {
                feed_item.fillBlank("carrier", "icon", last_attacker_data[? "carrier"], g_red, carrier_dir);
            }
        }
        else {
            var actor = noone;
            skip_victim = true;

            feed_item.assignFeed(gamemode_obj.battlefeed);
            is_in_player_feed = false;

            if (object_is_ancestor(self.object_index, guy_obj)) {
                actor_name = name;
                actor = guy_obj;
            }
            else {
                actor_name = self.my_player.name;
                actor = self.object_index;
            }

            if (actor != guy_obj) {
                feed_item.fillBlank("actor", "icon", actor, "bf_orange");
            }

            feed_item.fillBlank("carrier", "icon", noone, g_red);
        }

        if (!skip_victim) {
            feed_item.fillBlank("victim", "icon", victim_index, g_white); //"bf_orange"
            /*
            if(my_player != gamemode_obj.environment) {
                feed_item.fillBlank("victimflag", "icon", my_player.flag, g_white);
            }
            */
        }

        if (la_player == gamemode_obj.environment && victim.my_player == gamemode_obj.environment) {
            hide_item = true;
        }

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

    if (!skip_victim && (victim.my_player != gamemode_obj.environment || victim_index == guy_obj)) // victim_name != my_player.name && 
    {
        feed_item.fillBlank("victimname", "text", victim_name, g_white); // "bf_orange"
    }

    if (hide_item) {
        feed_item.fade_ratio = 0;

        var msg_index = ds_list_find_index(feed_item.battlefeed.msg_list, feed_item);

        if (msg_index != -1) {
            ds_list_delete(feed_item.battlefeed.msg_list, msg_index);
        }
    }

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
