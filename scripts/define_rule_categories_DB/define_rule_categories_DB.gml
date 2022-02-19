function define_rule_categories_DB(categories) {
    var category;
    
    category = categories.add("Death and HP");
    ds_list_add(category.rule_list, "hp_death", "holographic_spawners", "base_crystals", "base_crystal_hp", "base_crystal_shield_power", "guy_shield_power", "death_limit");
    
    category = categories.add("Important");
    ds_list_add(category.rule_list, "score_limit", "time_limit", "sudden_death_start", "darkness");
    
    category = categories.add("Colors and Energy");
    ds_list_add(category.rule_list, "equal_colors", "dark_color", "base_colors_only", "bad_status_effects", "abilities", "dark_orb_energy_lock", "color_orbs_energy_lock", "orbs_energy_min_lock");
    
    category = categories.add("Terrain and Devices");
    ds_list_add(category.rule_list, "weak_terrain", "indestr_terrain", "regenerate_terrain", "cannons", "turrets", "mob_portals", "flag_capture");
    
    category = categories.add("Phenomena");
    ds_list_add(category.rule_list, "random_item_spawner", "snakes_on_a_plane", "bolt_rain", "slime_mob_rain", "artifacts", "lightning_strikes");
    
    category = categories.add("Other");
    ds_list_add(category.rule_list, "always_sliding", "heavy_shots", "shield_push", "tutorials", "tut_guide");
}