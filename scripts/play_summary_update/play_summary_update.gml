function play_summary_update() {
    with(play_menu_window)
    {
        var gamemode_text = "", place_text = "";

        var gm = DB.gamemodes[? gamemode_picker.cur_item_id], i, count, place, mod_id, mod_control, gmmod;
    
        if(!is_undefined(gm))
        {
            var default_mods_gm = gm[? "default_modifiers"], forced_mods_gm = gm[? "forced_modifiers"], default_mods_place, forced_mods_place;
            var min_players = gm[? "min_players"], max_players = gm[? "max_players"], max_bots = max_players - gm[? "min_real_players"], min_teams = gm[? "min_teams"];
            var world = noone, place = noone;
            
            // PLAYERS
            if(min_players != max_players) {
                gamemode_text += string(min_players) + "-";
            }
            
            gamemode_text += string(max_players) + " player";
            if(max_players > 1) {
                gamemode_text += "s";
            }
        
            if(max_bots > 0) {
                gamemode_text += ", up to " + string(max_bots) + " CPU";
            }
            gamemode_text += "\n";
            
            
            // LIMITS
            var limits_text = "", gm_limits = gm[? "limits"], limit_id, limit_index;
        
            for(limit_index = 0; limit_index < DB.limit_count; limit_index++)
            {
                limit_id = DB.limit_ids[| limit_index];
        
                if(!is_undefined(gm_limits[? limit_id]))
                {
                    if(limit_id == "score")
                    {
                        limits_text += "Score to win: " + string(gm_limits[? limit_id]) + "\n";
                    }
                }
            }
        
            if(limits_text != "")
            {
                //gamemode_text += "Game ends if" + "\n";
                gamemode_text += limits_text;
            }
        
            // GAMEMODE DESCRIPTION
            gamemode_text += "\n";
            gamemode_text += " " + gm[? "description"] + "\n";
        
        
            // PLACE
            if(instance_exists(play_menu_window.world))
            {
                world = play_menu_window.world;
                place = world.places[| place_picker.cur_item];
                if(!is_undefined(place))
                {
                    var max_teams = min(gm[? "max_teams"], place.max_team_count);
                    
                    // BRONZE TIME
                    if(!is_undefined(place.times[? "bronze"]))
                    {
                        place_text += "Bronze time: " + seconds_to_time_str(place.times[? "bronze"]);
                        place_text += "\n";
                    }
                    
                    // TEAMS
                    if(min_teams != max_teams) {
                        place_text += string(min_teams) + "-";
                    }
            
                    place_text += string(max_teams) + " team";
                    if(max_teams > 1) {
                        place_text += "s";
                    }
                    place_text += "\n";
                                
                    // GRID SIZE
                    place_text += "Grid size: ";
                    place_text += string(floor( (place.width - 2*place.margin) / 32 )) + "x" + string(floor( (place.height - 2*place.margin) / 32 ));
                    place_text += "\n";
                
                    // DESCRIPTION
                    place_text += "\n";
                    place_text += " " + place.description + "\n";
                
                    default_mods_place = place.default_modifiers;
                    forced_mods_place = place.forced_modifiers;
                }
            }
        
        
            // CUSTOM MODS
            var custom_mods_text = "", default_value, customized, state_string;
    
            count = ds_list_size(DB.gamemode_mod_list);
    
            for(i=0; i<count; i++)
            {
                mod_id = DB.gamemode_mod_list[| i];
                gmmod = DB.gamemode_mods[? mod_id];
                mod_control = gmmod_controls[? mod_id];
            
                customized = false;
                state_string = "";
            
                if(is_undefined(mod_control))
                {
                    continue;
                }
            
            
                if(gmmod[? "type"] == "bool")
                {
                    default_value = false;
                }
                else if(gmmod[? "type"] == "number")
                {
                    default_value = undefined;
                }
                
                
                default_value = mod_default_value_update(gmmod, default_value, default_mods_gm[? mod_id]);
            
                if(!is_undefined(place))
                {
                    default_value = mod_default_value_update(gmmod, default_value, default_mods_place[? mod_id]);
                }
            
                default_value = mod_default_value_update(gmmod, default_value, forced_mods_gm[? mod_id]);
            
                if(!is_undefined(place))
                {
                    default_value = mod_default_value_update(gmmod, default_value, forced_mods_place[? mod_id]);
                }
                
            
                var value = mod_control.get_value();
            
                if(gmmod[? "type"] == "bool")
                {
                    if(default_value != value)
                    {
                        customized = true;
                        if(mod_control.checkbox.checked)
                        {
                            state_string = "";
                        }
                        else
                        {
                            state_string = "(Off)";
                        }
                    }
                }
                else if(gmmod[? "type"] == "number")
                {
                    var number_customized = (is_undefined(value) && (!is_undefined(default_value) && default_value != false))
                                        || (!is_undefined(value) && (is_undefined(default_value) || default_value != value));
                    if (number_customized) {
                        customized = true;
                        if(mod_control.checkbox.checked)
                        {
                            state_string = "(" + string(mod_control.get_value()) + ")";
                        }
                        else
                        {
                            state_string = "(Off)";
                        }
                    }
                }
            
            
                if(customized)
                {
                    if(custom_mods_text != "")
                            custom_mods_text += ", ";
                        
                    custom_mods_text += gmmod[? "name"] + state_string;
                }
            }
        
            if(custom_mods_text != "")
            {
                place_text += "\nCustom Rules:\n";
                place_text += " " + custom_mods_text;
                place_text += "\n";
            }
        }
    
        gamemode_description_scroll_list.load_long_text(gamemode_text, gamemode_description_list);
        level_description_scroll_list.load_long_text(place_text, place_description_list);
    
        if (custom_mods_text != "") {
            level_description_scroll_list.select_item(-1);
        }
    }
}
