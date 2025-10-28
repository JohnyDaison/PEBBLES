function destroy_gamemodes_DB() {
    var i, count, gm_id, gm_map, mod_id, mod_map;

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

    count = ds_list_size(gamemode_mod_list);
    for(i = count-1; i >= 0; i--)
    {
        mod_id = gamemode_mod_list[| i];
        mod_map = gamemode_mods[? mod_id];
    
        ds_map_destroy(mod_map);
    }

    rule_categories.destroy();
    rule_presets.destroy();

    ds_map_destroy(gamemodes);
    ds_list_destroy(gamemode_list);

    ds_map_destroy(gamemode_mods);
    ds_list_destroy(gamemode_mod_list);
    ds_list_destroy(gamemode_mod_type_list);
}
