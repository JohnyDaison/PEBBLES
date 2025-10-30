function define_rule_categories_DB(categories) {
    var RuleID = self.RuleID_DynEnum.dynEnum;
    var category;
    
    category = categories.add("Death and HP");
    array_push(category.rules, RuleID.HpDeath, RuleID.HolographicSpawners, "base_crystals", "base_crystal_hp", "base_crystal_shield_power", "guy_shield_power", "death_limit");
    
    category = categories.add("Important");
    array_push(category.rules, "score_limit", "time_limit", "sudden_death_start", "darkness");
    
    category = categories.add("Colors and Energy");
    array_push(category.rules, "equal_colors", "dark_color", "base_colors_only", "bad_status_effects", "abilities", "dark_orb_energy_lock", "color_orbs_energy_lock", "orbs_energy_min_lock");
    
    category = categories.add("Terrain and Devices");
    array_push(category.rules, RuleID.WeakTerrain, RuleID.IndestructibleTerrain, RuleID.RegenerateTerrain, "cannons", "turrets", "mob_portals", "flag_capture");
    
    category = categories.add("Phenomena");
    array_push(category.rules, "random_item_spawner", "snakes_on_a_plane", "bolt_rain", "slime_mob_rain", "artifacts", "lightning_strikes");
    
    category = categories.add("Other");
    array_push(category.rules, RuleID.AlwaysSliding, "curve_balls", "shield_push", "tutorials", "tut_guide");
}