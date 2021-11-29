function play_summary_update() {
    var pane = play_menu_window.gamemode_pane;

    with(pane)
    {
        var new_text = "";

        var gm = DB.gamemodes[? gamemode_picker.cur_item_id], i, count, place, mod_id, mod_control, gmmod;
    
        if(!is_undefined(gm))
        {
            var default_mods_gm = gm[? "default_modifiers"], forced_mods_gm = gm[? "forced_modifiers"], default_mods_place, forced_mods_place;
            var min_players = gm[? "min_players"], max_players = gm[? "max_players"], max_bots = max_players - gm[? "min_real_players"];
            var world = noone, place = noone;

            // GAMEMODE NAME
            new_text += "= " + gm[? "name"] + " =\n";
        
            // GAMEMODE DESCRIPTION
            new_text += "\n";
            new_text += " " + gm[? "description"] + "\n";
        
            // PLAYERS
            new_text += "\n";
            if(min_players != max_players) {
                new_text += string(min_players) + "-";
            }
            
            new_text += string(max_players) + " player";
            if(max_players > 1) {
                new_text += "s";
            }
        
            if(max_bots > 0) {
                new_text += ", up to " + string(max_bots) + " CPU";
            }
            new_text += "\n";
        
        
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
                //new_text += "Game ends if" + "\n";
                new_text += limits_text;
            }

            new_text += "\n";
        
        
            // PLACE
            if(instance_exists(play_menu_window.world))
            {
                world = play_menu_window.world;
                place = world.places[| place_picker.cur_item];
                if(!is_undefined(place))
                {
                    // NAME
                    new_text += "= " + place.name + " =\n"; // "" + world.name + " - " + 
                
                
                    // DESCRIPTION
                    new_text += "\n";
                    new_text += " " + place.description + "\n";
                    new_text += "\n";
                        
                    // BRONZE TIME
                    if(!is_undefined(place.times[? "bronze"]))
                    {
                        new_text += "Bronze time: " + seconds_to_time_str(place.times[? "bronze"]);
                        new_text += "\n";
                    }
                                
                    // GRID SIZE
                    new_text += "Grid size: ";
                    new_text += string(floor( (place.width - 2*place.margin) / 32 )) + "x" + string(floor( (place.height - 2*place.margin) / 32 ));
                    new_text += "\n";
                
                    new_text += "\n";

                
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
            
            
                if(!is_undefined(default_mods_gm[? mod_id]))
                {
                    default_value = default_mods_gm[? mod_id];
                }
            
                if(!is_undefined(place) && !is_undefined(default_mods_place[? mod_id]))
                {
                    default_value = default_mods_place[? mod_id];
                }
            
                if(!is_undefined(forced_mods_gm[? mod_id]))
                {
                    default_value = forced_mods_gm[? mod_id];
                }
            
                if(!is_undefined(place) && !is_undefined(forced_mods_place[? mod_id]))
                {
                    default_value = forced_mods_place[? mod_id];
                }
            
                var value = mod_control.get_value();
            
                if(gmmod[? "type"] == "bool")
                {
                    if(default_value != value)
                    {
                        customized = true;
                        if(mod_control.checked)
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
                new_text += "Custom Mods:\n";
                new_text += " " + custom_mods_text;
                new_text += "\n";
            }
        }
    
        var max_line_length = 36, line, line_length, new_line, chi, line_break_delay = 0, do_delay;
    
        string_explode(new_text,"\n",summary_list);
    
        count = ds_list_size(summary_list);
    
        for(i=0; i<count; i++)
        {
            line = summary_list[| i];
            line_length = string_length(line);
            new_line = "";
        
            while(line_length > max_line_length)
            {
                line_break_delay = 0;
                for(chi = line_length; chi >= 1; chi--)
                {
                    if(string_char_at(line, chi) == " ")
                    {
                        do_delay = (string_char_at(line, chi-2) == " " || string_char_at(line, chi-3) == " " || string_char_at(line, chi-4) == " ");
                        if(do_delay)
                        {
                            line_break_delay++;
                        }
                    
                        if(!do_delay || line_break_delay > 3)
                        {
                            new_line = string_copy(line, chi, line_length-chi+1) + new_line;
                            line = string_copy(line, 1, chi-1);
                            break;
                        }
                    }
                }
            
                line_length = string_length(line);
            }
        
            if(new_line != "")
            {
                //new_line = string_delete(new_line, 1, 1);
                summary_list[| i] = line;
                ds_list_insert(summary_list, i+1, new_line);
                count++;
            }
        }
    
        if(count < summary_list_picker.max_items)
        {
            repeat(summary_list_picker.max_items - count)
            {
                ds_list_add(summary_list, "");
            }
        }
    
        gui_list_picker_items_reset(summary_list_picker, "text", summary_list);
    
        if (custom_mods_text != "") {
            summary_list_picker.select_item_by_index(-1);
        }
    }
}
