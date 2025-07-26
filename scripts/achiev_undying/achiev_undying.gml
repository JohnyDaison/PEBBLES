function achiev_undying(query) {
    switch (query) {
        case "title": {
            return "Undying";
        }

        case "verb": {
            return "has destroyed enemy Crystal without dying";
        }

        case "success": {
            if (gamemode_obj.player_count == 2) {
                var opponent = gamemode_obj.players[? my_player.number mod 2 + 1];

                return (instance_exists(opponent.my_base) && opponent.my_base.object_index == guy_spawner_obj && opponent.my_base.last_attacker_map[? "player"] == my_player && opponent.my_base.destroyed && my_player.stats[? "deaths"] == 0);
            }
            // TODO: proper general implementation with teams in mind

            return false;
        }

        case "fail": {
            return !mod_get_state("base_crystals") || my_player.stats[? "deaths"] > 0;
        }

        case "reward_score": {
            return gamemode_obj.score_values[? "achiev_undying"];
        }

        case "reward": {
            return true;
        }
    }
}
