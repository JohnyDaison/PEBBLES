/// @description mods_update_state(gamemode_id, preset, place, custom_mods, target_map)
/// @function mods_update_state
/// @param {string} gamemode_id
/// @param {struct} preset
/// @param {instance} place
/// @param {ds_map} custom_map
/// @param {ds_map} target_map
/// @param {bool} [reset] default=true
function mods_update_state() {
    var gamemode_id = argument[0];
    var preset = argument[1];
    var place = argument[2];
    var custom_mods = argument[3];
    var target_map = argument[4];
    var reset = true;
    if (argument_count > 5)
    {
        reset = argument[5];
    }

    var gm = DB.gamemodes[? gamemode_id];

    if(!ds_exists(target_map, ds_type_map))
    {
        return false;
    }

    if(!is_undefined(gm))
    {
        var default_mods_gm = gm[? "default_modifiers"], forced_mods_gm = gm[? "forced_modifiers"];
        var preset, default_mods_preset, forced_mods_preset;
        var place, default_mods_place, forced_mods_place;
        var mod_id, gmmod, count, mod_value;
        var preset_exists = is_struct(preset);
        var place_exists = instance_exists(place);
        
        if(preset_exists)
        {
            default_mods_preset = preset.default_modifiers;
            forced_mods_preset = preset.forced_modifiers;
        }
        
        if(place_exists)
        {
            default_mods_place = place.default_modifiers;
            forced_mods_place = place.forced_modifiers;
        }
    
        count = ds_list_size(DB.gamemode_mod_list);
        
        if (reset) {
            ds_map_clear(target_map);
        }
    
        for(var i=0; i<count; i++)
        {
            mod_id = DB.gamemode_mod_list[| i];
            gmmod = DB.gamemode_mods[? mod_id];
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
            mod_value = mod_default_value_update(gmmod, mod_value, default_mods_gm[? mod_id]);
            
            // preset default
            if(preset_exists)
            {
                mod_value = mod_default_value_update(gmmod, mod_value, default_mods_preset[? mod_id]);
            }
            
            // place default
            if(place_exists)
            {
                mod_value = mod_default_value_update(gmmod, mod_value, default_mods_place[? mod_id]);
            }
        
            // custom
            if(!is_undefined(custom_mods[? mod_id]))
            {
                mod_value = custom_mods[? mod_id];
            }
        
            // game mode forced
            mod_value = mod_default_value_update(gmmod, mod_value, forced_mods_gm[? mod_id]);
         
            // preset default
            if(preset_exists)
            {
                mod_value = mod_default_value_update(gmmod, mod_value, forced_mods_preset[? mod_id]);
            }
            
            // place forced
            if(place_exists)
            {
                mod_value = mod_default_value_update(gmmod, mod_value, forced_mods_place[? mod_id]);
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
