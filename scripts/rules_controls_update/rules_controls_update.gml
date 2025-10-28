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
            var rule_id, rule_control, dRule, fRule, gmRule;
            
            preset = DB.rule_presets.find_preset_by_id(preset_dropdown.list_picker.cur_item_id);
            place = play_menu_window.world.places[| place_picker.cur_item];
            
            
            // reset all
            rule_id = ds_map_find_first(rule_controls);
            while(!is_undefined(rule_id))
            {
                gmRule = DB.gamemode_rules[? rule_id];
            
                if(!is_undefined(gmRule) && gmRule[? "public"])
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
            dRule = ds_map_find_first(default_map);
        
            while(!is_undefined(dRule))
            {
                gmRule = DB.gamemode_rules[? dRule];
            
                if(!is_undefined(gmRule) && gmRule[? "public"])
                {
                    rule_control = rule_controls[? dRule];
                    rule_control.set_value(default_map[? dRule], false, false);
                }
            
                dRule = ds_map_find_next(default_map, dRule);
            }
        
            ds_map_destroy(default_map);
        
            // set default value on mod controls
            rule_id = ds_map_find_first(rule_controls);
            while(!is_undefined(rule_id))
            {   
                gmRule = DB.gamemode_rules[? rule_id];
            
                if(!is_undefined(gmRule) && gmRule[? "public"])
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
                gmRule = DB.gamemode_rules[? rule_id];
            
                if(!is_undefined(gmRule) && gmRule[? "public"])
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
            fRule = ds_map_find_first(forced_map);
        
            while(!is_undefined(fRule))
            {
                gmRule = DB.gamemode_rules[? fRule];
            
                if(!is_undefined(gmRule) && gmRule[? "public"])
                {
                    rule_control = rule_controls[? fRule];
                    rule_control.set_value(forced_map[? fRule], false, true);
                }
            
                fRule = ds_map_find_next(forced_map, fRule);
            }
        }
    }
}
