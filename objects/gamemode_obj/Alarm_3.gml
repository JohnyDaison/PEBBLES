/// @description  WIN MESSAGE
if (!instance_exists(center_overlay)) {
    exit;
}

var centerOverlay = center_overlay.id;

if (!self.is_campaign) {
    centerOverlay.message = "It's a draw!";

    if (self.winner != noone) {
        centerOverlay.message = self.winner.name + " WINS!";
    }

    centerOverlay.adjusted = false;
    self.alarm[4] = 180;
} else {
    if (self.is_coop) {
        var pl = self.players[? 1];

        // time attack medals
        var times = self.world.current_place.times;
        var best_award_value = -1, best_time_award_str = "";
        var time_key = ds_map_find_first(times);

        while (!is_undefined(time_key)) {
            var time_value = times[? time_key];

            if ((best_award_value == -1 || best_award_value > time_value) && timer_window.time.total <= time_value) {
                best_award_value = time_value;
                best_time_award_str = " " + string_upper(time_key);
            }

            time_key = ds_map_find_next(times, time_key);
        }

        // the message
        centerOverlay.message =
            //"Score: " + string(pl.stats[? "score"]) + "\n" + 
            "Time: " + self.stats[? "match_length"] + best_time_award_str + "\n" +
            "Data Cubes: " + string(pl.stats[? "secrets_found"]) + "/" + string(gamemode_obj.stats[? "secrets_total"]); /* + "\n" + */
        //"Mobs killed: "+ string(pl.stats[? "mobs_killed_total"]) + "/" + string(gamemode_obj.stats[? "mobs_spawned"]);
    }
    else {
        centerOverlay.message = "It's a draw!";

        if (self.winner != noone) {
            centerOverlay.message = self.winner.name + " WINS!"

            if (self.team_based && self.player_count > 2) {
                centerOverlay.message = "Team " + string(self.winner.team_number) + " WINS!"
            }
        }
    }

    centerOverlay.adjusted = false;

    self.alarm[4] = 300;

    if (self.mode == "sparring") {
        var player = self.players[? 1];
        var guy = player.my_guy;

        if (player.loser) {
            if (guy.last_attacker_map[? "source_id"] != guy) {
                centerOverlay.message = "You were killed by " + guy.last_attacker_map[? "source_name"];
            }
            else {
                centerOverlay.message = "You killed yourself...";
            }
        }
        else if (player.winner) {
            centerOverlay.message = "You are ready for Battle!";
        }

        self.alarm[4] = 240;
    }
}

if (self.reached_limit_name == "user_terminated") {
    self.alarm[4] = 30;
}
