function define_rule_presets_DB(presets) {
    var preset, forced_mods, default_mods;
    
    // VOLLEYBALL
    
    preset = presets.add("basic_bumping", "Basic Bumping");
    
    forced_mods = preset.forced_modifiers;
    forced_mods[? "weak_terrain"] = false;
    forced_mods[? "indestr_terrain"] = true;
    forced_mods[? "regenerate_terrain"] = false;
    forced_mods[? "death_limit"] = false;
    forced_mods[? "score_limit"] = true;
    forced_mods[? "sudden_death_start"] = false;

    
    preset = presets.add("deadly_spiking", "Deadly Spiking");
    
    forced_mods = preset.forced_modifiers;
    forced_mods[? "indestr_terrain"] = false;

    default_mods = preset.default_modifiers;
    default_mods[? "weak_terrain"] = true;
    default_mods[? "regenerate_terrain"] = true;
    default_mods[? "death_limit"] = true;
    default_mods[? "score_limit"] = true;
    
    
    preset = presets.add("court_attrition", "Court Attrition");
    
    forced_mods = preset.forced_modifiers;
    forced_mods[? "indestr_terrain"] = false;
    forced_mods[? "regenerate_terrain"] = false;
    forced_mods[? "death_limit"] = true;

    default_mods = preset.default_modifiers;
    default_mods[? "weak_terrain"] = false;
    default_mods[? "death_limit"] = 5;
    default_mods[? "score_limit"] = true;
    
    
    preset = presets.add("volley_infinite", "Infinite Game");
    
    forced_mods = preset.forced_modifiers;
    forced_mods[? "regenerate_terrain"] = true;

    default_mods = preset.default_modifiers;
    default_mods[? "death_limit"] = false;
    default_mods[? "score_limit"] = false;
}