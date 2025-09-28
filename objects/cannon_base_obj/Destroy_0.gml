with (self.charge_ball) {
    instance_destroy();
}

with (self.my_waypoint) {
    instance_destroy();
}

if (!self.cancelled) {
    if (self.shot_color > g_dark) {
        var inst = instance_create(self.x, self.y, slot_explosion_obj);
        inst.my_guy = self.id;
        inst.my_color = self.shot_color;
        inst.my_source = self.object_index;
        inst.holographic = self.holographic;
    }
    else {
        my_sound_play(wall_crumble_sound);
    }

    var stat_str = "";
    var la_player = self.last_attacker_map[? "player"];

    if (instance_exists(la_player)) {
        if (la_player.team_number != self.my_player.team_number) {
            var score_value = gamemode_obj.score_values[? "cannon_killed"];

            increase_stat(la_player, "score", score_value, false);
            stat_str = stat_label("score", score_value, "+");
        }
    }

    battlefeed_post_destruction(self.id, self.last_attacker_map, stat_str);
}
else {
    with (platform_obj) {
        if (self.my_struct == other.id)
            instance_destroy();
    }
}

ds_map_destroy(self.orbs);
ds_map_destroy(self.orb_light);

cannon_unassign_player(self);

event_inherited();
