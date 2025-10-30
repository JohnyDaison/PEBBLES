function define_rule_categories_DB(categories) {
    var RuleID = global.RuleID;
    var category;
    
    category = categories.add("Death and HP");
    array_push(category.rules, RuleID.HpDeath, RuleID.HolographicSpawners, RuleID.BaseCrystals, "base_crystal_hp", "base_crystal_shield_power", "guy_shield_power", "death_limit");
    
    category = categories.add("Important");
    array_push(category.rules, "score_limit", "time_limit", "sudden_death_start", "darkness");
    
    category = categories.add("Colors and Energy");
    array_push(category.rules, RuleID.EqualColors, RuleID.DarkColor, RuleID.BaseColorsOnly, RuleID.NegativeStatusEffects, RuleID.Abilities, RuleID.DarkOrbEnergyLock, RuleID.ColorOrbsEnergyLock, RuleID.ColorOrbsEnergyMinLock);
    
    category = categories.add("Terrain and Devices");
    array_push(category.rules, RuleID.WeakTerrain, RuleID.IndestructibleTerrain, RuleID.RegenerateTerrain, RuleID.Cannons, RuleID.Turrets, RuleID.MobPortals, "flag_capture");
    
    category = categories.add("Phenomena");
    array_push(category.rules, "random_item_spawner", "snakes_on_a_plane", "bolt_rain", "slime_mob_rain", "artifacts", "lightning_strikes");
    
    category = categories.add("Other");
    array_push(category.rules, RuleID.AlwaysSliding, RuleID.CurveBalls, RuleID.ShieldPush, "tutorials", "tut_guide");
}