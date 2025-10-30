function define_rule_presets_DB(presets) {
    var preset, forced_rules, default_rules;
    var RuleID = global.RuleID;
    
    // VOLLEYBALL
    
    preset = presets.add("basic_bumping", "Basic Bumping");
    
    forced_rules = preset.forced_rules;
    forced_rules[? RuleID.WeakTerrain] = false;
    forced_rules[? RuleID.IndestructibleTerrain] = true;
    forced_rules[? RuleID.RegenerateTerrain] = false;
    forced_rules[? "death_limit"] = false;
    forced_rules[? "score_limit"] = true;
    forced_rules[? "sudden_death_start"] = false;

    
    preset = presets.add("deadly_spiking", "Deadly Spiking");
    
    forced_rules = preset.forced_rules;
    forced_rules[? RuleID.IndestructibleTerrain] = false;
    forced_rules[? RuleID.RegenerateTerrain] = true;

    default_rules = preset.default_rules;
    default_rules[? RuleID.WeakTerrain] = true;
    
    
    preset = presets.add("court_attrition", "Court Attrition");
    
    forced_rules = preset.forced_rules;
    forced_rules[? RuleID.IndestructibleTerrain] = false;
    forced_rules[? RuleID.RegenerateTerrain] = false;
    forced_rules[? "death_limit"] = true;

    default_rules = preset.default_rules;
    default_rules[? "death_limit"] = 5;
    
    
    preset = presets.add("volley_infinite", "Infinite Game");
    
    forced_rules = preset.forced_rules;
    forced_rules[? RuleID.RegenerateTerrain] = true;

    default_rules = preset.default_rules;
    default_rules[? "score_limit"] = false;
    
    
    // ARENA
    
    preset = presets.add("arena_novice", "Novice");
    
    forced_rules = preset.forced_rules;
    forced_rules[? RuleID.HpDeath] = false;
    forced_rules[? RuleID.HolographicSpawners] = true;
    forced_rules[? RuleID.BaseCrystals] = true;
    forced_rules[? RuleID.EqualColors] = true;
    forced_rules[? RuleID.DarkColor] = false;
    forced_rules[? RuleID.BaseColorsOnly] = true;
    forced_rules[? RuleID.DarkOrbEnergyLock] = false;
    forced_rules[? RuleID.ColorOrbsEnergyLock] = true;
    forced_rules[? RuleID.ColorOrbsEnergyMinLock] = false;
    forced_rules[? RuleID.NegativeStatusEffects] = false;
    forced_rules[? RuleID.Abilities] = false;
    forced_rules[? RuleID.Turrets] = false;
    forced_rules[? RuleID.Cannons] = false;
    forced_rules[? RuleID.MobPortals] = false;
    forced_rules[? RuleID.Snakes] = false;
    forced_rules[? RuleID.RandomItemSpawner] = false;
    forced_rules[? RuleID.BoltRain] = false;
    forced_rules[? RuleID.SlimeMobRain] = false;
    forced_rules[? RuleID.Artifacts] = false;
    forced_rules[? RuleID.LightningStrikes] = false;
    forced_rules[? "base_crystal_hp"] = true;
    forced_rules[? "base_crystal_shield_power"] = false;
    forced_rules[? "guy_shield_power"] = false;
    forced_rules[? "death_limit"] = false;
    forced_rules[? RuleID.AlwaysSliding] = false;
    forced_rules[? RuleID.CurveBalls] = false;
    forced_rules[? "flag_capture"] = false;

    default_rules = preset.default_rules;
    default_rules[? "base_crystal_hp"] = 5;
    default_rules[? "score_limit"] = 200;
    default_rules[? RuleID.ShieldPush] = true;
    
    
    preset = presets.add("arena_apprentice", "Apprentice");
    
    forced_rules = preset.forced_rules;
    forced_rules[? "guy_shield_power"] = false;
    forced_rules[? "death_limit"] = false;
    forced_rules[? RuleID.DarkOrbEnergyLock] = false;
    forced_rules[? RuleID.NegativeStatusEffects] = false;
    forced_rules[? RuleID.Turrets] = false;
    forced_rules[? RuleID.Cannons] = false;
    forced_rules[? RuleID.MobPortals] = false;
    forced_rules[? RuleID.Snakes] = false;
    forced_rules[? RuleID.BoltRain] = false;
    forced_rules[? RuleID.SlimeMobRain] = false;
    forced_rules[? RuleID.LightningStrikes] = false;
    forced_rules[? RuleID.AlwaysSliding] = false;
    forced_rules[? RuleID.CurveBalls] = false;

    default_rules = preset.default_rules;
    default_rules[? RuleID.BaseCrystals] = true;
    default_rules[? RuleID.HpDeath] = true;
    default_rules[? RuleID.EqualColors] = true;
    default_rules[? RuleID.BaseColorsOnly] = true;
    default_rules[? RuleID.ColorOrbsEnergyMinLock] = true;
    default_rules[? RuleID.Artifacts] = true;
    default_rules[? RuleID.ShieldPush] = true;
    
    default_rules[? "base_crystal_hp"] = 5;
    default_rules[? "base_crystal_shield_power"] = 2;
    default_rules[? "score_limit"] = 200;
    
    
    preset = presets.add("arena_arcade", "Arcade");
    
    forced_rules = preset.forced_rules;
    forced_rules[? RuleID.Turrets] = false;
    forced_rules[? RuleID.Cannons] = false;
    forced_rules[? RuleID.MobPortals] = false;
    forced_rules[? RuleID.HolographicSpawners] = true;
    forced_rules[? RuleID.Snakes] = false;
    forced_rules[? RuleID.ShieldPush] = true;
    forced_rules[? "base_crystal_shield_power"] = false;
    forced_rules[? RuleID.ColorOrbsEnergyMinLock] = true;

    default_rules = preset.default_rules;
    default_rules[? RuleID.RandomItemSpawner] = true;
    default_rules[? RuleID.BaseCrystals] = true;
    default_rules[? RuleID.WeakTerrain] = true;
    default_rules[? RuleID.DarkOrbEnergyLock] = true;
    default_rules[? RuleID.EqualColors] = true;
    default_rules[? RuleID.DarkColor] = true;
    default_rules[? RuleID.NegativeStatusEffects] = true;
    default_rules[? RuleID.Abilities] = true;
    default_rules[? RuleID.Artifacts] = true;
    
    default_rules[? "base_crystal_hp"] = 7;
    default_rules[? "score_limit"] = 200;
    
    
    preset = presets.add("arena_standard", "Pandemonium");
    
    default_rules = preset.default_rules;
    default_rules[? RuleID.Turrets] = true;
    default_rules[? RuleID.Cannons] = true;
    default_rules[? RuleID.MobPortals] = true;
    default_rules[? RuleID.ShieldPush] = true;

    default_rules[? RuleID.HpDeath] = true;
    default_rules[? RuleID.BaseCrystals] = true;
    default_rules[? RuleID.DarkColor] = true;
    default_rules[? RuleID.NegativeStatusEffects] = true;
    default_rules[? RuleID.Abilities] = true;

    default_rules[? RuleID.Snakes] = true;
    default_rules[? RuleID.SlimeMobRain] = true;
    default_rules[? RuleID.Artifacts] = true;
    
    default_rules[? "base_crystal_hp"] = true;
    default_rules[? "base_crystal_shield_power"] = true;
    default_rules[? "score_limit"] = 400;
}