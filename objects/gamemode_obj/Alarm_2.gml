/// @description GUI AND LIMITS
if (!self.created_gui) {
    self.width = singleton_obj.current_width;
    self.height = singleton_obj.current_height;

    self.time_window = add_frame(timer_window);
    self.time_window.x = self.width / 2 - self.time_window.width / 2;
    if (self.player_count == 1) {
        self.time_window.x = self.width * 0.25 - self.time_window.width / 2;
    }
    self.time_window.y = 56;
    self.time_window.visible = false;

    self.created_gui = true;
}

if (!self.match_started) {
    self.reached_limit_name = "";

    self.match_start_time = current_time;
    self.last_minute = -1;

    instance_create(0, 0, phenomena_obj);

    self.match_started = true;
}

self.time_limit = 0;

var RuleID = global.RuleID;
var player;
var player_defeat_count = 0, team_defeat_count = 0;

// COMPUTE DEFEAT COUNTS
if (self.player_count > 0) {
    var team_number = 0;
    var team_member_count, team_member_defeat_count;

    for (var playerNumber = 1; playerNumber <= self.player_count; playerNumber++) {
        player = self.players[? playerNumber];

        if (player.loser) {
            player_defeat_count++;
        }
    }

    if (self.player_count > 2) {
        repeat(self.team_count) {
            team_number++;
            team_member_defeat_count = 0;
            team_member_count = 0;

            with (player_obj) {
                if (self.team_number == team_number) {
                    team_member_count++;

                    if (self.loser) {
                        team_member_defeat_count++;
                    }
                }
            }

            if (team_member_defeat_count == team_member_count) {
                team_defeat_count++;
            }
        }
    }
}

// LIMITS
if (!self.limit_reached) {
    var time_started = instance_exists(self.time_window) && instance_exists(self.time_window.time);

    if (time_started) {
        var limit_value;

        // ScoreLimit
        limit_value = rule_get_state(RuleID.ScoreLimit);

        if (is_number(limit_value)) {
            for (var player_number = 1; player_number <= self.player_count; player_number++) {
                player = self.players[? player_number];
                if (player.stats[? "score"] >= limit_value) {
                    self.limit_reached = true;
                    self.reached_limit_name = "score";
                }
            }
        }

        // TimeLimit
        limit_value = rule_get_state(RuleID.TimeLimit);

        if (is_number(limit_value)) {
            self.time_limit = limit_value * 60;

            if (self.time_window.time.total >= self.time_limit) {
                self.limit_reached = true;
                self.reached_limit_name = "time";
            }
        }

        // SuddenDeathStart
        limit_value = rule_get_state(RuleID.SuddenDeathStart);

        if (is_number(limit_value)) {
            var sudden_death_start = limit_value * 60;
            if (!self.sudden_death && self.time_window.time.total >= sudden_death_start) {
                self.sudden_death = true;

                var overlay = add_frame(center_overlay);
                overlay.message = "Sudden Death";
                overlay.alarm[2] = 240;
            }
        }
    }

    // PERMADEATH LIMIT
    if (self.player_count > 0) {
        if (self.is_coop || self.player_count == 1) {
            // all players
            if (player_defeat_count >= self.player_count) {
                self.limit_reached = true;
            }
        }
        else {
            // all but one
            if (player_defeat_count >= self.player_count - 1 || team_defeat_count >= self.team_count - 1) {
                self.limit_reached = true;
            }
        }
    }

    self.alarm[2] = 30;

    exit;
}

if (self.match_finished) {
    exit;
}

chunk_deoptimizer();

show_debug_message("limit reached: " + string(self.reached_limit_name));

if (instance_exists(main_camera_obj)) {
    main_camera_obj.on = true;
}

with (overhead_overlay) {
    close_frame(self.id);
}
with (inventory_overlay) {
    close_frame(self.id);
}
with (healthbar_overlay) {
    close_frame(self.id);
}
with (tutorial_overlay) {
    close_frame(self.id);
}
with (radial_overlay) {
    close_frame(self.id);
}

// final stats
with (player_obj) {
    var new_dmg, new_ratio;
    new_dmg = round((self.spell_dmg_total + self.wall_dmg_total + self.burn_dmg_total) * 100);
    set_stat(self.id, "damage_received", new_dmg, false);

    new_dmg = round(self.dealt_dmg_total * 100);
    set_stat(self.id, "damage_dealt", new_dmg, false);

    new_dmg = round(self.healed_dmg_total * 100);
    set_stat(self.id, "damage_healed", new_dmg, false);

    new_dmg = round(self.rewound_dmg_total * 100);
    set_stat(self.id, "damage_rewound", new_dmg, false);

    if (self.stats[? "total_actions"] > 0) {
        new_ratio = round((self.dealt_dmg_total * 10000) / self.stats[? "total_actions"]) / 100;
        set_stat(self.id, "damage_to_actions_ratio", new_ratio, false);
    }

    if (self.stats[? "spells"] > 0) {
        new_ratio = round((self.dealt_dmg_total * 10000) / self.stats[? "spells"]) / 100;
        set_stat(self.id, "damage_to_spells_ratio", new_ratio, false);
    }

    if (self.stats[? "hit_count"] > 0) {
        new_ratio = round((self.stats[? "attack_color_ratio_total"] * 100) / self.stats[? "hit_count"]);
        set_stat(self.id, "attack_color_efficiency", new_ratio, false);
    }

    if (self.stats[? "received_hits"] > 0) {
        new_ratio = round((self.stats[? "received_color_ratio_total"] * 100) / self.stats[? "received_hits"]);
        set_stat(self.id, "received_color_efficiency", new_ratio, false);
    }

    set_stat(self.id, "channeling_time", floor(self.stats[? "channeling_time"] / singleton_obj.game_speed), false);
}

add_frame(center_overlay);
var centerOverlay = center_overlay.id;

// winner
var marked_winner = noone;
self.winner = noone;

for (var playerNumber = 1; playerNumber <= self.player_count; playerNumber++) {
    player = self.players[? playerNumber];

    if (!self.is_coop) {
        set_stat(player, "percent_on_opponents_half", player.stats[? "time_on_opponents_half"] * 100 / singleton_obj.step_count, false);
    }

    if (!player.loser) {
        if (marked_winner == noone && player.winner) {
            marked_winner = player;
        }

        if (isPlayerStat(player, "score", "highest", true)) {
            self.winner = player;
            player.winner = true;
        }

        if (self.team_based) {
            if (team_defeat_count == self.team_count - 1) {
                self.winner = player;
                player.winner = true;
            }
            else {
                with (player_obj) {
                    if (self.team_number > 0 && self.team_number != player.team_number
                        && player.stats[? "score"] > self.stats[? "score"]) {
                        other.winner = player;
                        player.winner = true;
                    }
                }
            }
        }
    }
}

if (self.winner == noone) {
    self.winner = marked_winner;
}

// match end reason
if (self.winner != noone) {
    if (!self.is_coop) {
        if (instance_exists(self.winner.my_guy)) {
            instance_create(self.winner.my_guy.x, self.winner.my_guy.y, winner_effect_obj);
        }

        if (instance_exists(self.winner.my_base)) {
            instance_create(self.winner.my_base.x, self.winner.my_base.y, winner_effect_obj);
        }

        if (player_defeat_count == self.player_count - 1) {
            centerOverlay.message = "Only " + self.winner.name + " survived!";
        }
        else if (team_defeat_count == self.team_count - 1) {
            centerOverlay.message = "Only Team " + string(self.winner.team_number) + " survived!";
        }
        else {
            centerOverlay.message = self.winner.name;

            if (self.team_based && self.player_count > 2) {
                centerOverlay.message = "Team " + string(self.winner.team_number);
            }

            if (self.reached_limit_name == "score") {
                var win_score = string(self.winner.stats[? "score"]);
                centerOverlay.message += " scored " + string(win_score) + " of " + string(rule_get_state(RuleID.ScoreLimit));
            }
            else {
                centerOverlay.message += " WINS!";
            }
        }
    }
    else {
        if (self.player_count == 1) {
            centerOverlay.message = "Level complete!";
        }
        else {
            centerOverlay.message = "Level finished by " + self.winner.name + "!";
        }
    }
}
else {
    if (player_defeat_count == self.player_count) {
        centerOverlay.message = "No one survived...";
    }
    else {
        centerOverlay.message = "No one reached the goal in time.";
    }
}

// match length
if (instance_exists(self.time_window) && instance_exists(self.time_window.time)) {
    var minutes = string(self.time_window.time.total div 60);
    var seconds = string(self.time_window.time.total mod 60);

    while (string_length(minutes) < 2) {
        minutes = "0" + minutes;
    }
    while (string_length(seconds) < 2) {
        seconds = "0" + seconds;
    }

    self.stats[? "match_length"] = minutes + ":" + seconds;
}

// win message
if (centerOverlay.message == "") {
    alarm[3] = 3;
}
else if (self.reached_limit_name == "user_terminated") {
    alarm[3] = 30;
}
else {
    alarm[3] = 180;
}

self.match_finished = true;
