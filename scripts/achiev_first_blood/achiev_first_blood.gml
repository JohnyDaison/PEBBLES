function achiev_first_blood(query) {
    switch (query) {
        case "title": {
            return "First Kill";
        }

        case "verb": {
            return "got First kill";
        }

        case "success": {
            var dead_guy = noone;
            var what = noone;

            if (gamemode_obj.player_count == 1) {
                return false;
            }

            with (guy_obj) {
                if (dead && my_player != other.id && last_attacker_map[? "player"] == other.id) {
                    dead_guy = id;
                    what = last_attacker_map[? "source"];
                }
            }

            return my_player.stats[? "kills"] > 0 && what == guy_obj;
        }

        case "fail": {
            var ret = false;
            if (!isPlayerStat(my_player, "kills", "highest", false)) {
                ret = true;
            }

            if (my_player.stats[? "kills"] > 0) {
                if (!achiev_first_blood("success"))
                    ret = true;
            }
            return ret;
        }

        case "reward_score": {
            return gamemode_obj.score_values[? "achiev_first_blood"];
        }

        case "reward": {
            return true;
        }
    }
}
