function merge_rules_maps(target_map, source, type) {
    var source_map, gmmod;
    
    if(!is_undefined(source)) {
        if (type == "default") {
            source_map = source.default_rules;
        } else if (type == "forced") {
            source_map = source.forced_rules;
        }
        
        var rule_id = ds_map_find_first(source_map);
        while(!is_undefined(rule_id))
        {
            gmmod = DB.gamemode_rules[? rule_id];
            
            if (type == "default") {
                target_map[? rule_id] = rule_default_value_update(gmmod, target_map[? rule_id], source_map[? rule_id]);
            } else if (type == "forced") {
                target_map[? rule_id] = rule_forced_value_update(gmmod, target_map[? rule_id], source_map[? rule_id]);
            }
            
            rule_id = ds_map_find_next(source_map, rule_id);
        }
    }
}