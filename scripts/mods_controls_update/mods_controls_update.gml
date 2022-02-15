function mods_controls_update() {
    // UPDATE MODS CONTROLS
    var play_window = play_menu_window;
    var gm = DB.gamemodes[? play_window.gamemode_picker.cur_item_id];
    
    if(!is_undefined(gm))
    {
        with(play_window)
        {
            var default_mods_gm = gm[? "default_modifiers"], forced_mods_gm = gm[? "forced_modifiers"];
            var custom_mods = gmmod_customs;
            var default_map, forced_map, place, default_mods_place, forced_mods_place;
            var mod_controls = gmmod_controls;
            var mod_id, mod_control, dmod, fmod, gmmod;
        
        
            place = play_menu_window.world.places[| place_picker.cur_item];
            if(!is_undefined(place))
            {
                default_mods_place = place.default_modifiers;
                forced_mods_place = place.forced_modifiers;
            }
        

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
        
            // merge gm and place
            default_map = ds_map_create();
            ds_map_copy(default_map, default_mods_gm);
        
            if(!is_undefined(place))
            {
                dmod = ds_map_find_first(default_mods_place);
                while(!is_undefined(dmod))
                {
                    default_map[? dmod] = default_mods_place[? dmod];
            
                    dmod = ds_map_find_next(default_mods_place, dmod);
                }
            }
        
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
        
            // merge gm and place
            forced_map = ds_map_create();
            ds_map_copy(forced_map, forced_mods_gm);
        
            if(!is_undefined(place))
            {
                fmod = ds_map_find_first(forced_mods_place);
                while(!is_undefined(fmod))
                {
                    forced_map[? fmod] = forced_mods_place[? fmod];
            
                    fmod = ds_map_find_next(forced_mods_place, fmod);
                }
            }
        
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
