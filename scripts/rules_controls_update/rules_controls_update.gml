function rules_controls_update() {
    // UPDATE RULES CONTROLS
    var play_window = play_menu_window;
    var gm = DB.gamemodes[? play_window.gamemode_picker.cur_item_id];
    
    if(!is_undefined(gm))
    {
        with(play_window)
        {
            var default_rules_gm = gm[? "default_rules"], forced_rules_gm = gm[? "forced_rules"];
            var custom_rules = gmrule_customs;
            var default_map, forced_map, place, preset;
            var rule_controls = gmrule_controls;
            var rule_id, rule_control, dmod, fmod, gmmod;
            
            preset = DB.rule_presets.find_preset_by_id(preset_dropdown.list_picker.cur_item_id);
            place = play_menu_window.world.places[| place_picker.cur_item];
            
            
            // reset all
            rule_id = ds_map_find_first(rule_controls);
            while(!is_undefined(rule_id))
            {
                gmmod = DB.gamemode_rules[? rule_id];
            
                if(!is_undefined(gmmod) && gmmod[? "public"])
                {
                    rule_control = rule_controls[? rule_id];
                    rule_control.reset_value();
                }
            
                rule_id = ds_map_find_next(rule_controls, rule_id);
            }
        
        
            // DEFAULTS
        
            // merge gm, preset and place
            default_map = ds_map_create();
            ds_map_copy(default_map, default_rules_gm);
            merge_rules_maps(default_map, preset, "default");
            merge_rules_maps(default_map, place, "default");
        
            // apply result
            dmod = ds_map_find_first(default_map);
        
            while(!is_undefined(dmod))
            {
                gmmod = DB.gamemode_rules[? dmod];
            
                if(!is_undefined(gmmod) && gmmod[? "public"])
                {
                    rule_control = rule_controls[? dmod];
                    rule_control.set_value(default_map[? dmod], false, false);
                }
            
                dmod = ds_map_find_next(default_map, dmod);
            }
        
            ds_map_destroy(default_map);
        
            // set default value on mod controls
            rule_id = ds_map_find_first(rule_controls);
            while(!is_undefined(rule_id))
            {   
                gmmod = DB.gamemode_rules[? rule_id];
            
                if(!is_undefined(gmmod) && gmmod[? "public"])
                {
                    rule_control = rule_controls[? rule_id];
                    rule_control.default_value = rule_control.get_value();
                }
                
                rule_id = ds_map_find_next(rule_controls, rule_id);
            }
        
        
            // CUSTOM
            rule_id = ds_map_find_first(custom_rules);
        
            while(!is_undefined(rule_id))
            {
                gmmod = DB.gamemode_rules[? rule_id];
            
                if(!is_undefined(gmmod) && gmmod[? "public"])
                {
                    rule_control = rule_controls[? rule_id];
                    rule_control.set_value(custom_rules[? rule_id], true, false);
                }
            
                rule_id = ds_map_find_next(custom_rules, rule_id);
            }
        
        
            // FORCED
        
            // merge gm, preset and place
            forced_map = ds_map_create();
            ds_map_copy(forced_map, forced_rules_gm);
            merge_rules_maps(forced_map, preset, "forced");
            merge_rules_maps(forced_map, place, "forced");
        
            // apply result
            fmod = ds_map_find_first(forced_map);
        
            while(!is_undefined(fmod))
            {
                gmmod = DB.gamemode_rules[? fmod];
            
                if(!is_undefined(gmmod) && gmmod[? "public"])
                {
                    rule_control = rule_controls[? fmod];
                    rule_control.set_value(forced_map[? fmod], false, true);
                }
            
                fmod = ds_map_find_next(forced_map, fmod);
            }
        }
    }
}
