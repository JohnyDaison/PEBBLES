function mods_controls_update() {
    // UPDATE MODS CONTROLS
    var play_window = play_menu_window;
    var gm = DB.gamemodes[? play_window.gamemode_picker.cur_item_id];
    
    if(!is_undefined(gm))
    {
        with(play_window)
        {
            var default_mods_gm = gm[? "default_rules"], forced_mods_gm = gm[? "forced_rules"];
            var custom_mods = gmmod_customs;
            var default_map, forced_map, place, preset;
            var mod_controls = gmmod_controls;
            var mod_id, mod_control, dmod, fmod, gmmod;
            
            preset = DB.rule_presets.find_preset_by_id(preset_dropdown.list_picker.cur_item_id);
            place = play_menu_window.world.places[| place_picker.cur_item];
            
            
            // reset all
            mod_id = ds_map_find_first(mod_controls);
            while(!is_undefined(mod_id))
            {
                gmmod = DB.gamemode_mods[? mod_id];
            
                if(!is_undefined(gmmod) && gmmod[? "public"])
                {
                    mod_control = mod_controls[? mod_id];
                    mod_control.reset_value();
                }
            
                mod_id = ds_map_find_next(mod_controls, mod_id);
            }
        
        
            // DEFAULTS
        
            // merge gm, preset and place
            default_map = ds_map_create();
            ds_map_copy(default_map, default_mods_gm);
            merge_rules_maps(default_map, preset, "default");
            merge_rules_maps(default_map, place, "default");
        
            // apply result
            dmod = ds_map_find_first(default_map);
        
            while(!is_undefined(dmod))
            {
                gmmod = DB.gamemode_mods[? dmod];
            
                if(!is_undefined(gmmod) && gmmod[? "public"])
                {
                    mod_control = mod_controls[? dmod];
                    mod_control.set_value(default_map[? dmod], false, false);
                }
            
                dmod = ds_map_find_next(default_map, dmod);
            }
        
            ds_map_destroy(default_map);
        
            // set default value on mod controls
            mod_id = ds_map_find_first(mod_controls);
            while(!is_undefined(mod_id))
            {   
                gmmod = DB.gamemode_mods[? mod_id];
            
                if(!is_undefined(gmmod) && gmmod[? "public"])
                {
                    mod_control = mod_controls[? mod_id];
                    mod_control.default_value = mod_control.get_value();
                }
                
                mod_id = ds_map_find_next(mod_controls, mod_id);
            }
        
        
            // CUSTOM
            mod_id = ds_map_find_first(custom_mods);
        
            while(!is_undefined(mod_id))
            {
                gmmod = DB.gamemode_mods[? mod_id];
            
                if(!is_undefined(gmmod) && gmmod[? "public"])
                {
                    mod_control = mod_controls[? mod_id];
                    mod_control.set_value(custom_mods[? mod_id], true, false);
                }
            
                mod_id = ds_map_find_next(custom_mods, mod_id);
            }
        
        
            // FORCED
        
            // merge gm, preset and place
            forced_map = ds_map_create();
            ds_map_copy(forced_map, forced_mods_gm);
            merge_rules_maps(forced_map, preset, "forced");
            merge_rules_maps(forced_map, place, "forced");
        
            // apply result
            fmod = ds_map_find_first(forced_map);
        
            while(!is_undefined(fmod))
            {
                gmmod = DB.gamemode_mods[? fmod];
            
                if(!is_undefined(gmmod) && gmmod[? "public"])
                {
                    mod_control = mod_controls[? fmod];
                    mod_control.set_value(forced_map[? fmod], false, true);
                }
            
                fmod = ds_map_find_next(forced_map, fmod);
            }
        }
    }
}
