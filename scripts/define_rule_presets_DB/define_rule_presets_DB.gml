function define_rule_presets_DB(presets) {
    var preset, forced_rules, default_rules;
    
    // VOLLEYBALL
    
    preset = presets.add("basic_bumping", "Basic Bumping");
    
    forced_rules = preset.forced_modifiers;
    forced_rules[? "weak_terrain"] = false;
    forced_rules[? "indestr_terrain"] = true;
    forced_rules[? "regenerate_terrain"] = false;
    forced_rules[? "death_limit"] = false;
    forced_rules[? "score_limit"] = true;
    forced_rules[? "sudden_death_start"] = false;

    
    preset = presets.add("deadly_spiking", "Deadly Spiking");
    
    forced_rules = preset.forced_modifiers;
    forced_rules[? "indestr_terrain"] = false;
    forced_rules[? "regenerate_terrain"] = true;

    default_rules = preset.default_modifiers;
    default_rules[? "weak_terrain"] = true;
    
    
    preset = presets.add("court_attrition", "Court Attrition");
    
    forced_rules = preset.forced_modifiers;
    forced_rules[? "indestr_terrain"] = false;
    forced_rules[? "regenerate_terrain"] = false;
    forced_rules[? "death_limit"] = true;

    default_rules = preset.default_modifiers;
    default_rules[? "death_limit"] = 5;
    
    
    preset = presets.add("volley_infinite", "Infinite Game");
    
    forced_rules = preset.forced_modifiers;
    forced_rules[? "regenerate_terrain"] = true;

    default_rules = preset.default_modifiers;
    default_rules[? "score_limit"] = false;
    
    
    // ARENA
    
    preset = presets.add("arena_novice", "Novice");
    
    forced_rules = preset.forced_modifiers;
    forced_rules[? "hp_death"] = false;
    forced_rules[? "holographic_spawners"] = true;
    forced_rules[? "base_crystals"] = true;
    forced_rules[? "equal_colors"] = true;
    forced_rules[? "dark_color"] = false;
    forced_rules[? "base_colors_only"] = true;
    forced_rules[? "dark_orb_energy_lock"] = false;
    forced_rules[? "color_orbs_energy_lock"] = true;
    forced_rules[? "orbs_energy_min_lock"] = false;
    forced_rules[? "bad_status_effects"] = false;
    forced_rules[? "abilities"] = false;
    forced_rules[? "turrets"] = false;
    forced_rules[? "cannons"] = false;
    forced_rules[? "mob_portals"] = false;
    forced_rules[? "snakes_on_a_plane"] = false;
    forced_rules[? "random_item_spawner"] = false;
    forced_rules[? "bolt_rain"] = false;
    forced_rules[? "slime_mob_rain"] = false;
    forced_rules[? "artifacts"] = false;
    forced_rules[? "lightning_strikes"] = false;
    forced_rules[? "base_crystal_hp"] = true;
    forced_rules[? "base_crystal_shield_power"] = false;
    forced_rules[? "guy_shield_power"] = false;
    forced_rules[? "death_limit"] = false;
    forced_rules[? "always_sliding"] = false;
    forced_rules[? "heavy_shots"] = false;
    forced_rules[? "flag_capture"] = false;

    default_rules = preset.default_modifiers;
    default_rules[? "base_crystal_hp"] = 5;
    default_rules[? "score_limit"] = 200;
    default_rules[? "shield_push"] = true;
    
    
    preset = presets.add("arena_apprentice", "Apprentice");
    
    forced_rules = preset.forced_modifiers;
    forced_rules[? "guy_shield_power"] = false;
    forced_rules[? "death_limit"] = false;
    forced_rules[? "dark_orb_energy_lock"] = false;
    forced_rules[? "bad_status_effects"] = false;
    forced_rules[? "turrets"] = false;
    forced_rules[? "cannons"] = false;
    forced_rules[? "mob_portals"] = false;
    forced_rules[? "snakes_on_a_plane"] = false;
    forced_rules[? "bolt_rain"] = false;
    forced_rules[? "slime_mob_rain"] = false;
    forced_rules[? "lightning_strikes"] = false;
    forced_rules[? "always_sliding"] = false;
    forced_rules[? "heavy_shots"] = false;

    default_rules = preset.default_modifiers;
    default_rules[? "base_crystals"] = true;
    default_rules[? "hp_death"] = true;
    default_rules[? "equal_colors"] = true;
    default_rules[? "base_colors_only"] = true;
    default_rules[? "orbs_energy_min_lock"] = true;
    default_rules[? "artifacts"] = true;
    default_rules[? "shield_push"] = true;
    
    default_rules[? "base_crystal_hp"] = 5;
    default_rules[? "base_crystal_shield_power"] = 2;
    default_rules[? "score_limit"] = 200;
    
    
    preset = presets.add("arena_arcade", "Arcade");
    
    forced_rules = preset.forced_modifiers;
    forced_rules[? "turrets"] = false;
    forced_rules[? "cannons"] = false;
    forced_rules[? "mob_portals"] = false;
    forced_rules[? "holographic_spawners"] = true;
    forced_rules[? "snakes_on_a_plane"] = false;
    forced_rules[? "shield_push"] = true;
    forced_rules[? "base_crystal_shield_power"] = false;
    forced_rules[? "orbs_energy_min_lock"] = true;

    default_rules = preset.default_modifiers;
    default_rules[? "random_item_spawner"] = true;
    default_rules[? "base_crystals"] = true;
    default_rules[? "weak_terrain"] = true;
    default_rules[? "dark_orb_energy_lock"] = true;
    default_rules[? "equal_colors"] = true;
    default_rules[? "dark_color"] = true;
    default_rules[? "bad_status_effects"] = true;
    default_rules[? "abilities"] = true;
    default_rules[? "artifacts"] = true;
    
    default_rules[? "base_crystal_hp"] = 7;
    default_rules[? "score_limit"] = 200;
    
    
    preset = presets.add("arena_standard", "Pandemonium");
    
    default_rules = preset.default_modifiers;
    default_rules[? "turrets"] = true;
    default_rules[? "cannons"] = true;
    default_rules[? "mob_portals"] = true;
    default_rules[? "shield_push"] = true;

    default_rules[? "hp_death"] = true;
    default_rules[? "base_crystals"] = true;
    default_rules[? "dark_color"] = true;
    default_rules[? "bad_status_effects"] = true;
    default_rules[? "abilities"] = true;

    default_rules[? "snakes_on_a_plane"] = true;
    default_rules[? "slime_mob_rain"] = true;
    default_rules[? "artifacts"] = true;
    
    default_rules[? "base_crystal_hp"] = true;
    default_rules[? "base_crystal_shield_power"] = true;
    default_rules[? "score_limit"] = 400;
}