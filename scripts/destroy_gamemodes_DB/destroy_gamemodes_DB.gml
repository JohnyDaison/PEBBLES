function destroy_gamemodes_DB() {
    var i, count, gm_id, gm_map, rule_id, rule_map;

    count = ds_list_size(gamemode_list);
    for(i = count-1; i >= 0; i--)
    {
        gm_id = gamemode_list[| i];
        gm_map = gamemodes[? gm_id];
    
        ds_map_destroy(gm_map[? "default_rules"]);
        ds_map_destroy(gm_map[? "forced_rules"]);
        ds_list_destroy(gm_map[? "rule_presets"]);
    
        ds_map_destroy(gm_map);
    }

    count = ds_list_size(gamemode_rule_list);
    for(i = count-1; i >= 0; i--)
    {
        rule_id = gamemode_rule_list[| i];
        rule_map = gamemode_rules[? rule_id];
    
        ds_map_destroy(rule_map);
    }

    rule_presets.destroy();

    ds_map_destroy(gamemodes);
    ds_list_destroy(gamemode_list);

    ds_map_destroy(gamemode_rules);
    ds_list_destroy(gamemode_rule_list);
    ds_list_destroy(gamemode_rule_type_list);
}
