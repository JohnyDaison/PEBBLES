function spec_effect_to_guy() {
    var effect_charge,orig_effect_charge,sure_hit,has_protection,glow;

    effect_charge = argument0;
    orig_effect_charge = effect_charge;
    effect_source = argument1;
    sure_hit = false;

    if(effect_charge != 0 && is_string(effect_source))
    {
        if(argument_count > 2)
        {
            sure_hit = argument[2];
        }
    
        /*
        if(other.my_color <= g_dark || other.my_color >= g_white)
        {
            return false;
        }
        */
        if(!ds_map_exists(DB.color_effects, other.my_color) || !rule_get_state("bad_status_effects"))
        {
            return false;
        }
        var effect = DB.color_effects[? other.my_color];
    
        if(effect_source == "damage")
        {
            effect_charge *= effect.damage_ratio;
        }
        else if(effect_source == "signal")
        {
            effect_charge *= effect.signal_ratio;
        }
    
        has_protection = is_shielded(id) || protected;

        glow = false;
    
        if(instance_exists(other))
        {
            if((other.my_color == my_color || has_protection) && !sure_hit)
            {
                return false;
            }
        
            //randnum = random(100);
        
            switch(other.my_color)
            {
                case g_red:
                {
                    if(other.object_index != wall_obj || singleton_obj.step_count mod 3 == 0)  // 25
                    {
                        if(!self.berserk || sure_hit)
                        {
                            status_left[? "burn"] += effect_charge;
                            hum = true;
                            glow = true;
                        }
                    }
                }
                break;
            
                case g_green:
                {
                    if(other.object_index != wall_obj || singleton_obj.step_count mod 4 == 0 || singleton_obj.step_count mod 5 == 0)  // 40
                    {
                        status_left[? "slow"] += effect_charge;
                        hum = true;
                        glow = true;   
                    }
                }
                break;
            
                case g_blue:
                {
                
                    if(other.object_index != wall_obj || singleton_obj.step_count mod 23 == 0)   // 4
                    {
                        status_left[? "frozen"] += effect_charge;
                        hum = true;
                        glow = true;    
                    }
                }
                break;
            
                case g_yellow:
                {
                    if(other.object_index != wall_obj || singleton_obj.step_count mod 7 == 0)  // 25
                    {
                        status_left[? "confusion"] += effect_charge;
                        hum = true;
                        glow = true;
                    }
                }
                break;
            
                case g_magenta:
                {
                    if(other.object_index != wall_obj || singleton_obj.step_count mod 5 == 0 || singleton_obj.step_count mod 6 == 0)  // 25
                    {
                        //status_left[? "weakness"] += effect_charge;
                        status_left[? "suppressed"] += effect_charge;
                        hum = true;
                        glow = true;    
                    }
                }
                break;
            
                case g_cyan:
                {
                    if(other.object_index != wall_obj || singleton_obj.step_count mod 3 == 0 || singleton_obj.step_count mod 5 == 0)  // 50
                    {
                        status_left[? "bounce"] += effect_charge;
                        hum = true;
                        glow = true;
                    }
                }
                break;
            
                case g_white:
                {
                    if(other.object_index != wall_obj || singleton_obj.step_count mod 3 == 0 || singleton_obj.step_count mod 4 == 0)  // 50
                    {
                        status_left[? "heavy_shots"] += effect_charge;
                        hum = true;
                        glow = true;
                    }
                }
                break;
            }
        
            if(!(other.object_index == wall_obj || other.object_index == shield_obj))
            {
                hum = false;
            }
            if(glow && other.object_index == wall_obj)
            {
                other.start_glow = true;
                other.strong_glow = true;
                other.energy -= orig_effect_charge*0.01;
            
                self.tint = merge_colour(DB.colormap[? my_color], DB.colormap[? other.my_color], status_tint_ratio);
                self.tint_updated = false;
            
            }
        
            if(hum)
            {
                hum_color = other.my_color;
            }
        }
    }
}
