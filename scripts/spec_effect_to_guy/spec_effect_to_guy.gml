/// @param {Real} effect_charge
/// @param {String} effect_source one of: "damage", "signal"
/// @param {Bool} sure_hit default = false
/// @return {Bool}
function spec_effect_to_guy(effect_charge, effect_source, sure_hit = false) {
    var RuleID = global.RuleID;
    var orig_effect_charge = effect_charge;

    if (effect_charge == 0 || !is_string(effect_source)) {
        return false;
    }

    if (!ds_map_exists(DB.color_effects, other.my_color) || !rule_get_state(RuleID.NegativeStatusEffects)) {
        return false;
    }

    var effect = DB.color_effects[? other.my_color];

    if (effect_source == "damage") {
        effect_charge *= effect.damage_ratio;
    }
    else if (effect_source == "signal") {
        effect_charge *= effect.signal_ratio;
    }

    var has_protection = is_shielded(self.id) || self.protected;
    var glow = false;

    if (!instance_exists(other)) {
        return false;
    }

    if ((other.my_color == self.my_color || has_protection) && !sure_hit) {
        return false;
    }

    //randnum = random(100);
    
    var fromWall = other.object_index == wall_obj;
    var stepCount = singleton_obj.step_count;

    switch (other.my_color) {
        case g_red:
            {
                if (!fromWall || stepCount mod 3 == 0)  // 25
                {
                    if (!self.berserk || sure_hit) {
                        self.status_left[? "burn"] += effect_charge;
                        self.hum = true;
                        glow = true;
                    }
                }
            }
            break;

        case g_green:
            {
                if (!fromWall || stepCount mod 4 == 0 || stepCount mod 5 == 0)  // 40
                {
                    self.status_left[? "slow"] += effect_charge;
                    self.hum = true;
                    glow = true;
                }
            }
            break;

        case g_blue:
            {

                if (!fromWall || stepCount mod 23 == 0)   // 4
                {
                    self.status_left[? "frozen"] += effect_charge;
                    self.hum = true;
                    glow = true;
                }
            }
            break;

        case g_yellow:
            {
                if (!fromWall || stepCount mod 7 == 0)  // 25
                {
                    self.status_left[? "confusion"] += effect_charge;
                    self.hum = true;
                    glow = true;
                }
            }
            break;

        case g_magenta:
            {
                if (!fromWall || stepCount mod 5 == 0 || stepCount mod 6 == 0)  // 25
                {
                    //self.status_left[? "weakness"] += effect_charge;
                    self.status_left[? "suppressed"] += effect_charge;
                    self.hum = true;
                    glow = true;
                }
            }
            break;

        case g_cyan:
            {
                if (!fromWall || stepCount mod 3 == 0 || stepCount mod 5 == 0)  // 50
                {
                    self.status_left[? "bounce"] += effect_charge;
                    self.hum = true;
                    glow = true;
                }
            }
            break;

        case g_white:
            {
                if (!fromWall || stepCount mod 3 == 0 || stepCount mod 4 == 0)  // 50
                {
                    self.status_left[? "heavy_shots"] += effect_charge;
                    self.hum = true;
                    glow = true;
                }
            }
            break;
    }

    if (!(other.object_index == wall_obj || other.object_index == shield_obj)) {
        self.hum = false;
    }

    if (glow && other.object_index == wall_obj) {
        other.start_glow = true;
        other.strong_glow = true;
        other.energy -= orig_effect_charge * 0.01;

        self.tint = merge_colour(DB.colormap[? self.my_color], DB.colormap[? other.my_color], self.status_tint_ratio);
        self.tint_updated = false;
    }

    if (self.hum) {
        self.hum_color = other.my_color;
    }

    return true;
}
