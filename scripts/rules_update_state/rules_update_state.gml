/// @description Computes the new state of rules based on given Game mode, Preset, Place and the custom_rules map,
/// @description then saves it to target map
/// @param {String} gamemode_id
/// @param {Struct.RulePreset} preset
/// @param {Id.Instance} place
/// @param {Id.DsMap} custom_rules
/// @param {Id.DsMap} target_map
/// @param {Bool} [reset] default=true
/// @return {Bool} success
function rules_update_state(gamemode_id, preset, place, custom_rules, target_map, reset = true) {
    var gm = DB.gamemodes[? gamemode_id];

    if(!ds_exists(target_map, ds_type_map))
    {
        return false;
    }

    if(!is_undefined(gm))
    {
        var default_rules_gm = gm[? "default_rules"], forced_rules_gm = gm[? "forced_rules"];
        var default_rules_preset, forced_rules_preset;
        var default_rules_place, forced_rules_place;
        var mod_id, gmmod, count, mod_value;
        var preset_exists = is_struct(preset);
        var place_exists = instance_exists(place);
        
        if(preset_exists)
        {
            default_rules_preset = preset.default_rules;
            forced_rules_preset = preset.forced_rules;
        }
        
        if(place_exists)
        {
            default_rules_place = place.default_rules;
            forced_rules_place = place.forced_rules;
        }
    
        count = ds_list_size(DB.gamemode_mod_list);
        
        if (reset) {
            ds_map_clear(target_map);
        }
    
        for(var i=0; i<count; i++)
        {
            mod_id = DB.gamemode_mod_list[| i];
            gmmod = DB.gamemode_rules[? mod_id];
            mod_value = undefined;
        
            // type default
            if (reset)
            {
                if(gmmod[? "type"] == "bool")
                {
                    mod_value = false;
                }
            }
        
            // game mode default
            mod_value = mod_default_value_update(gmmod, mod_value, default_rules_gm[? mod_id]);
            
            // preset default
            if(preset_exists)
            {
                mod_value = mod_default_value_update(gmmod, mod_value, default_rules_preset[? mod_id]);
            }
            
            // place default
            if(place_exists)
            {
                mod_value = mod_default_value_update(gmmod, mod_value, default_rules_place[? mod_id]);
            }
        
            // custom
            if(!is_undefined(custom_rules[? mod_id]))
            {
                mod_value = custom_rules[? mod_id];
            }
        
            // game mode forced
            mod_value = mod_default_value_update(gmmod, mod_value, forced_rules_gm[? mod_id]);
        
            // preset forced
            if(preset_exists)
            {
                mod_value = mod_default_value_update(gmmod, mod_value, forced_rules_preset[? mod_id]);
            }
            
            // place forced
            if(place_exists)
            {
                mod_value = mod_default_value_update(gmmod, mod_value, forced_rules_place[? mod_id]);
            }
        
            // write the value
            if(!is_undefined(mod_value))
            {
                target_map[? mod_id] = mod_value;
            }
        }
    
        return true;
    }

    return false;
}
