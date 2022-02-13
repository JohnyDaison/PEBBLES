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
                    
                    mod_control.bg_color = mod_control.default_bg_color;
                    
                    if(gmmod[? "type"] == "bool")
                    {
                        with(mod_control.checkbox)
                        {
                            locked = false;
                            gui_checkbox_script(false);
                        }
                    } 
                    else if(gmmod[? "type"] == "number")
                    {
                        with(mod_control)
                        {
                            with(checkbox) {
                                locked = false;
                                gui_checkbox_script(false);
                            }
                            
                            number_input.locked = true;
                            number_input.set_value(gmmod[? "default_value"], true);
                        }
                    }
                    
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
                    
                    if(gmmod[? "type"] == "bool")
                    {
                        with(mod_control.checkbox)
                        {
                            gui_checkbox_script(default_map[? dmod]);
                        }
                    }
                    else if(gmmod[? "type"] == "number")
                    {
                        with(mod_control)
                        {
                            var default_value = default_map[? dmod];
                            var value_is_number = is_number(default_value);
                            
                            with(checkbox) {
                                if (is_bool(default_value)) {
                                    gui_checkbox_script(default_value);
                                } else {
                                    gui_checkbox_script(true);
                                }
                            }
                            
                            if (value_is_number) {
                                number_input.set_value(default_value, true);
                            }
                            if (checkbox.checked) {
                                number_input.locked = false;
                            }
                        }
                    }
                }
            
                dmod = ds_map_find_next(default_map, dmod);
            }
        
            ds_map_destroy(default_map);
        
            // set default value on number mod controls
            mod_id = ds_map_find_first(mod_controls);
            while(!is_undefined(mod_id))
            {   
                gmmod = DB.gamemode_mods[? mod_id];
            
                if(!is_undefined(gmmod) && gmmod[? "public"])
                {
                    mod_control = mod_controls[? mod_id];
                    
                    with(mod_control) {
                        self.default_value = self.get_value();
                    }
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
                    
                    if(gmmod[? "type"] == "bool")
                    {
                        with(mod_control.checkbox)
                        {
                            gui_checkbox_script(custom_mods[? mod_id]);
                        }
                    }
                    else if(gmmod[? "type"] == "number")
                    {
                        with(mod_control)
                        {
                            var custom_value = custom_mods[? mod_id];
                            var value_is_number = is_number(custom_value);
                            
                            with(checkbox) {
                                if (is_bool(custom_value)) {
                                    gui_checkbox_script(custom_value);
                                } else {
                                    gui_checkbox_script(true);
                                }
                            }
                            
                            if (value_is_number) {
                                number_input.set_value(custom_value, true);
                            }
                            if (checkbox.checked) {
                                number_input.locked = false;
                            }
                        }
                    }
                    
                    if (mod_control.get_value() != mod_control.default_value) {
                        mod_control.bg_color = mod_control.customized_bg_color;
                    }
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
        
            fmod = ds_map_find_first(forced_map);
        
            while(!is_undefined(fmod))
            {
                gmmod = DB.gamemode_mods[? fmod];
            
                if(!is_undefined(gmmod) && gmmod[? "public"])
                {
                    mod_control = mod_controls[? fmod];
                    
                    if(gmmod[? "type"] == "bool")
                    {
                        with(mod_control.checkbox)
                        {
                            locked = true;
                            gui_checkbox_script(forced_map[? fmod]);
                        }
                        
                        mod_control.bg_color = mod_control.default_bg_color;
                    }
                    else if(gmmod[? "type"] == "number")
                    {
                        with(mod_control)
                        {
                            var forced_value = forced_map[? fmod];
                            var value_is_number = is_number(forced_value);
                            
                            with(checkbox) {
                                locked = true;
                                if (is_bool(forced_value)) {
                                    gui_checkbox_script(forced_value);
                                } else {
                                    gui_checkbox_script(true);
                                }
                            }
                            
                            if (is_bool(forced_value)) {
                                if (!forced_value || (forced_value && get_value() == gmmod[? "default_value"])) {
                                    bg_color = default_bg_color;
                                }
                            }
                            
                            if (value_is_number) {
                                number_input.set_value(forced_value, true);
                                bg_color = default_bg_color;
                            }
                            if (value_is_number || forced_value == false) {
                                number_input.locked = true;
                            }
                        }
                    }
                }
            
                fmod = ds_map_find_next(forced_map, fmod);
            }
        }
    }
}
