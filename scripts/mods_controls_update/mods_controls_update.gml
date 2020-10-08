function mods_controls_update() {
	// UPDATE MODS CONTROLS
	var gm_pane = play_menu_window.gamemode_pane;
	var gm = DB.gamemodes[? gm_pane.gamemode_picker.cur_item_id];
    
	if(!is_undefined(gm))
	{
	    with(gm_pane)
	    {
	        var default_mods_gm = gm[? "default_modifiers"], forced_mods_gm = gm[? "forced_modifiers"];
	        var custom_mods = gm_pane.gmmod_customs;
	        var default_map, forced_map, place, default_mods_place, forced_mods_place;
	        var mod_controls = gmmod_controls;
	        var mod_id, mod_but, dmod, fmod, gmmod;
        
        
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
	                if(gmmod[? "type"] == "bool" || gmmod[? "type"] == "ban")
	                {
	                    mod_but = mod_controls[? mod_id];
                    
	                    with(mod_but)
	                    {
	                        locked = false;
	                        gui_checkbox_script(false);
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
	                if(gmmod[? "type"] == "bool" || gmmod[? "type"] == "ban")
	                {
	                    mod_but = mod_controls[? dmod];
                    
	                    with(mod_but)
	                    {
	                        gui_checkbox_script(default_map[? dmod]);
	                    }
	                }
	            }
            
	            dmod = ds_map_find_next(default_map, dmod);
	        }
        
	        ds_map_destroy(default_map);
        
        
	        // CUSTOM
	        mod_id = ds_map_find_first(custom_mods);
        
	        while(!is_undefined(mod_id))
	        {
	            gmmod = DB.gamemode_mods[? mod_id];
            
	            if(!is_undefined(gmmod) && gmmod[? "public"])
	            {
	                if(gmmod[? "type"] == "bool" || gmmod[? "type"] == "ban")
	                {
	                    mod_but = mod_controls[? mod_id];
	                    with(mod_but)
	                    {
	                        gui_checkbox_script(custom_mods[? mod_id]);
	                    }
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
	                if(gmmod[? "type"] == "bool" || gmmod[? "type"] == "ban")
	                {
	                    mod_but = mod_controls[? fmod];
                    
	                    with(mod_but)
	                    {
	                        locked = true;
	                        gui_checkbox_script(forced_map[? fmod]);
	                    }
	                }
	            }
            
	            fmod = ds_map_find_next(forced_map, fmod);
	        }
	    }
	}


}
