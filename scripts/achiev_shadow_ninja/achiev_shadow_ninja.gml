function achiev_shadow_ninja(query) {
    switch (query) {
        case "title": {
            return "Shadow Ninja";
        }

        case "verb": {
            return "has killed without leaving the shadows";
        }

        case "success": {
            var dead_guy = noone;
            var what = noone;

            with (guy_obj) {
                if (dead && my_player != other.id && last_attacker_map[? "player"] == other.id) {
                    dead_guy = id;
                    what = last_attacker_map[? "source"];
                }
            }

            return my_player.stats[? "kills"] > 0 && what == guy_obj;
        }

        case "fail": {
            return my_player.my_guy.my_color > g_dark && !my_player.my_guy.channeling;
        }

        case "reward_score": {
            return gamemode_obj.score_values[? "achiev_shadow_ninja"];
        }

        case "reward": {
            return true;
        }
    }
}
