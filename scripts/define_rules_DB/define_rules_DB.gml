enum RuleType {
    Bool,
    Number
}

function define_rules_DB() {
    self.RuleID_DynEnum = new DynamicEnum();
    self.convertedRules = [ 
        "HpDeath",
    ];
    
    // rules
    gamemode_rule_create("HpDeath", "HP Death", RuleType.Bool, true, hp_death_mod2_icon, "Losing all HP will result in instant death. (Otherwise you die only by falling off the arena.)");

    gamemode_rule_create("holographic_spawners", "Holographic Spawners", RuleType.Bool, true, holo_spawners_mod2_icon, "Base Crystals can't be damaged by attacks. Respawning the Player will still damage them.");

    gamemode_rule_create("weak_terrain", "Weak Terrain", RuleType.Bool, true, weak_terrain_mod3_icon, "Destructible terrain has 1/3 of normal HP.");

    gamemode_rule_create("indestr_terrain", "Indestructible Terrain", RuleType.Bool, true, indestr_terrain_mod_icon, "All terrain is indestructible.");

    gamemode_rule_create("regenerate_terrain", "Regenerate Terrain", RuleType.Bool, true, regenerate_terrain_mod_icon, "Destroyed terrain will reform, with a delay.");
    
    gamemode_rule_create("always_sliding", "Slippery Floor", RuleType.Bool, true, always_sliding_mod_icon, "You're always sliding around.");

    gamemode_rule_create("dark_orb_energy_lock", "Dark Orb Energy lock", RuleType.Bool, true, dark_orb_energy_lock_mod_icon, "Dark Orb energy will always be at 100%.");
    
    gamemode_rule_create("color_orbs_energy_lock", "Color Orb Energy lock", RuleType.Bool, true, orbs_energy_lock_mod_icon, "Color Orb energy will always be at 100%.");
    
    gamemode_rule_create("orbs_energy_min_lock", "Orb Energy min-lock", RuleType.Bool, true, orbs_energy_min_lock_mod_on_icon, "Orb energy will not go below 100%.");

    gamemode_rule_create("curve_balls", "Curve Balls", RuleType.Bool, true, heavy_shots_mod_icon, "Projectiles are heavier and their gravity applies immediately.");
    
    gamemode_rule_create("equal_colors", "Equal Colors", RuleType.Bool, true, equal_colors_mod_icon, "All Colors are equal in damage.");
    
    gamemode_rule_create("base_colors_only", "Base Colors Only", RuleType.Bool, true, base_colors_only_mod_icon, "No multi-Color combos.");
    
    gamemode_rule_create("shield_push", "Shield Push", RuleType.Bool, true, shield_push_mod_icon, "Shield pushes away mobs and characters.");


    // game elements
    gamemode_rule_create("cannons", "Cannons", RuleType.Bool, true, cannons_mod2_icon, "Base-mounted Artillery which uses extra Orbs as ammo.");

    gamemode_rule_create("turrets", "Turrets", RuleType.Bool, true, turrets_mod_icon, "Terrain-mounted weaponry of various calibers.");

    gamemode_rule_create("mob_portals", "Mob Portals", RuleType.Bool, true, mob_portals_mod_icon, "Portals periodically spawn groups of aggressive Mobs.");

    gamemode_rule_create("base_crystals", "Base Crystals", RuleType.Bool, true, base_crystals_mod_icon, "Base Crystals provide a large Shield, which can Heal you using Shards.");

    gamemode_rule_create("dark_color", "Dark Color", RuleType.Bool, true, dark_color_mod_icon, "Dark attacks and Abilities mess with space and time.");
    
    gamemode_rule_create("bad_status_effects", "Status Effects", RuleType.Bool, true, bad_status_effects_mod_icon, "Every Color except Dark has a Status Effect, e.g. Slow(Green), Frozen(Blue)...");

    gamemode_rule_create("abilities", "Abilities", RuleType.Bool, true, abilities_mod_icon, "Every Color has an Ability, e.g. Heal(Green), Blink(Blue)...");


    // phenomena
    gamemode_rule_create("random_item_spawner", "Random Items", RuleType.Bool, true, random_item_spawner_mod_icon, "Items will spawn randomly around the arena.");

    gamemode_rule_create("snakes_on_a_plane", "Snakes", RuleType.Bool, true, snakes2_mod_icon, "Snakes are allowed to exist and will spawn inside destructible blocks.");

    gamemode_rule_create("bolt_rain", "Bolt rain", RuleType.Bool, true, bolt_rain_mod_icon, "Showers of stray Barrage shots will fall down periodically.");

    gamemode_rule_create("slime_mob_rain", "Slime-fall", RuleType.Bool, true, slime_mob_rain_mod_icon, "Ocasionally a bunch of Slimes will from the sky.");

    gamemode_rule_create("artifacts", "Artifacts", RuleType.Bool, true, artifacts_mod_icon, "Artifacts will appear.");

    gamemode_rule_create("lightning_strikes", "Lightning", RuleType.Bool, true, lightning_strikes_mod2_icon, "Lightning strikes... again!");


    // tutorial
    gamemode_rule_create("tutorials", "Tutorials", RuleType.Bool, true, tutorials_mod_icon, "Context-sensitive tutorials try to teach you as you play a match.");

    gamemode_rule_create("tut_guide", "Tutorial Guide", RuleType.Bool, true, tut_guide_mod_icon, "NPC Guide will show and explain the game to you.");


    // number rules
    gamemode_rule_create("base_crystal_hp", "Base Crystal HP", RuleType.Number, true, base_crystal_hp_mod_icon, "Starting Health of your Base");
    gamemode_number_rule_values("base_crystal_hp", 10, 1, 10, 1);
    
    gamemode_rule_create("base_crystal_shield_power", "Base Crystal Shield HP", RuleType.Number, true, base_crystal_sp_mod_icon, "Strength of Base Crystal Shield");
    gamemode_number_rule_values("base_crystal_shield_power", 6, 0, 6, 1);
    
    gamemode_rule_create("guy_shield_power", "Personal Shield HP", RuleType.Number, true, guy_sp_mod_icon, "Strength of Player's Shield");
    gamemode_number_rule_values("guy_shield_power", 100, 0, 150, 50);
    
    gamemode_rule_create("flag_capture", "Capture the Flag", RuleType.Number, true, flag_capture_mod_icon, "Toggle Flag Holders and set score for capturing a Flag.");
    gamemode_number_rule_values("flag_capture", 60, 10, 120, 10);
    
    gamemode_rule_create("death_limit", "Death Limit", RuleType.Number, true, death_limit_mod_icon, "Players won't respawn after dying X times.");
    gamemode_number_rule_values("death_limit", 3, 1, 20, 1);
    
    gamemode_rule_create("score_limit", "Score Limit", RuleType.Number, true, score_limit_mod_icon, "The game will end if a player reaches X points.");
    gamemode_number_rule_values("score_limit", 200, 1, 999, 1);
    
    gamemode_rule_create("time_limit", "Time Limit", RuleType.Number, true, time_limit_mod_icon, "The game will end after X minutes.");
    gamemode_number_rule_values("time_limit", 15, 1, 60, 1);
    
    gamemode_rule_create("sudden_death_start", "Sudden Death", RuleType.Number, true, sudden_death_start_mod_icon, "Players won't respawn after X minutes pass.");
    gamemode_number_rule_values("sudden_death_start", 10, 1, 30, 1);
    
    gamemode_rule_create("darkness", "Darkness", RuleType.Number, true, darkness_mod_icon, "Make the arena dark(er). 100 is pitch black.");
    gamemode_number_rule_values("darkness", 80, 50, 100, 1);
}