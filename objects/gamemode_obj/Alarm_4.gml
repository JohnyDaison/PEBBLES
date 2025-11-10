/// @description END OF LEVEL/MATCH
close_frame(center_overlay);
instance_destroy(place_controller_obj);

do_room_cleanup();

self.game_ended = true;

if (!self.is_campaign) {
    goto_summary();
    exit;
}

var cur_index = ds_list_find_index(self.world.places, self.world.current_place);
var next = noone;

if (self.world.next_place != noone) {
    next = self.world.next_place;
} else {
    next = self.world.places[| cur_index + 1];
}

// here I could add values of current stats to values of tournament_stats

if (self.reached_limit_name != "user_terminated" && next != noone && instance_exists(next)) {
    self.world.current_place = next.id;
    self.world.next_place = noone;
    self.arena_name = next.name;
    self.single_cam = self.world.current_place.single_cam;
    self.limit_reached = false;
    self.match_finished = false;
    self.shown_welcome = false;
    self.closed_welcome = false;
    self.created_gui = false;
    self.match_started = false;

    self.winner = noone;
    self.loser = noone;
    ds_list_clear(self.losers);
    self.time_window = noone;
    self.battlefeed = noone;

    init_match_stats();

    rules_update_state(self.mode, self.rule_preset, self.world.current_place, self.custom_rules, self.rules_state);

    room_goto(next.room_id);
}
else {
    if (self.is_coop) {
        goto_playmenu();
    }
    else {
        goto_summary();
    }
}
