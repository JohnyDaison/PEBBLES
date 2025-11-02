function destroy_gamemodes_DB() {
    var count = ds_list_size(self.gamemode_list);

    for (var i = count - 1; i >= 0; i--) {
        var gm_id = self.gamemode_list[| i];
        var gm_map = self.gamemodes[? gm_id];

        ds_map_destroy(gm_map[? "default_rules"]);
        ds_map_destroy(gm_map[? "forced_rules"]);
        ds_list_destroy(gm_map[? "rule_presets"]);

        ds_map_destroy(gm_map);
    }

    self.rule_presets.destroy();

    ds_map_destroy(self.gamemodes);
    ds_list_destroy(self.gamemode_list);

    ds_map_destroy(self.gamemode_rules);
    ds_list_destroy(self.gamemode_rule_list);
}
