function merge_rules_maps(target_map, source, type) {
    var source_map, gmmod;
    
    if(!is_undefined(source)) {
        if (type == "default") {
            source_map = source.default_modifiers;
        } else if (type == "forced") {
            source_map = source.forced_modifiers;
        }
        
        var mod_id = ds_map_find_first(source_map);
        while(!is_undefined(mod_id))
        {
            gmmod = DB.gamemode_mods[? mod_id];
            
            if (type == "default") {
                target_map[? mod_id] = mod_default_value_update(gmmod, target_map[? mod_id], source_map[? mod_id]);
            } else if (type == "forced") {
                target_map[? mod_id] = mod_forced_value_update(gmmod, target_map[? mod_id], source_map[? mod_id]);
            }
            
            mod_id = ds_map_find_next(source_map, mod_id);
        }
    }
}