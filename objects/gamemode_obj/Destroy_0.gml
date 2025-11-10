for (var playerNumber = -1; playerNumber <= self.player_count; playerNumber++) {
    var player = self.players[? playerNumber];

    if (!is_undefined(player)) {
        instance_destroy(player);
    }
}

ds_map_destroy(self.players);
ds_map_destroy(self.stats);
ds_map_destroy(self.score_values);

//levels
ds_map_destroy(self.level_min);
ds_map_destroy(self.level_max);
ds_map_destroy(self.level_minstart);
ds_map_destroy(self.level_maxstart);

ds_list_destroy(self.losers);

// rules
ds_map_destroy(self.rules_state);
ds_map_destroy(self.custom_rules);

if (instance_exists(self.world)) {
    instance_destroy(self.world);
}
