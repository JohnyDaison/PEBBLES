function achiev_crunchy(query) {
    switch (query) {
        case "title": {
            return "Crunchy";
        }

        case "verb": {
            return "is Crunchy!";
        }

        case "success": {
            if (gamemode_obj.is_campaign) {
                return false;
            }

            return my_player.stats[? "score"] >= gamemode_obj.score_values[? "crunchy_limit"];
        }

        case "fail": {
            var ret = false;
            return ret;
        }

        case "reward": {
            return true;
        }
    }
}
