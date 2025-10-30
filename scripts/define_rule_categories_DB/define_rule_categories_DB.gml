function define_rule_categories_DB(categories) {
    var RuleID = global.RuleID;
    var category;
    
    category = categories.add("Death and HP");
    array_push(category.rules, RuleID.HpDeath, RuleID.HolographicSpawners, RuleID.BaseCrystals, RuleID.BaseCrystalHP, RuleID.BaseCrystalShieldHP, RuleID.PersonalShieldHP, RuleID.DeathLimit);
    
    category = categories.add("Important");
    array_push(category.rules, RuleID.ScoreLimit, RuleID.TimeLimit, RuleID.SuddenDeathStart, RuleID.DarknessLevel);
    
    category = categories.add("Colors and Energy");
    array_push(category.rules, RuleID.EqualColors, RuleID.DarkColor, RuleID.BaseColorsOnly, RuleID.NegativeStatusEffects, RuleID.Abilities, RuleID.DarkOrbEnergyLock, RuleID.ColorOrbsEnergyLock, RuleID.ColorOrbsEnergyMinLock);
    
    category = categories.add("Terrain and Devices");
    array_push(category.rules, RuleID.WeakTerrain, RuleID.IndestructibleTerrain, RuleID.RegenerateTerrain, RuleID.Cannons, RuleID.Turrets, RuleID.MobPortals, RuleID.FlagCaptureScore);
    
    category = categories.add("Phenomena");
    array_push(category.rules, RuleID.RandomItemSpawner, RuleID.Snakes, RuleID.BoltRain, RuleID.SlimeMobRain, RuleID.Artifacts, RuleID.LightningStrikes);
    
    category = categories.add("Other");
    array_push(category.rules, RuleID.AlwaysSliding, RuleID.CurveBalls, RuleID.ShieldPush, RuleID.TutorialOverlay, RuleID.TutorialGuide);
}