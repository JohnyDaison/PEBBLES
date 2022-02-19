function define_rules_DB() {
    // rules
    gamemode_mod_create("hp_death", "HP Death", "bool", true, hp_death_mod2_icon, "Losing all HP will result in instant death. (Otherwise you die only by falling off the arena.)");

    gamemode_mod_create("holographic_spawners", "Holographic Spawners", "bool", true, holo_spawners_mod2_icon, "Base Crystals can't be damaged by attacks. Respawning the Player will still damage them.");

    gamemode_mod_create("weak_terrain", "Weak Terrain", "bool", true, weak_terrain_mod3_icon, "Destructible terrain has 1/3 of normal HP.");

    gamemode_mod_create("indestr_terrain", "Indestructible Terrain", "bool", true, indestr_terrain_mod_icon, "All terrain is indestructible.");

    gamemode_mod_create("regenerate_terrain", "Regenerate Terrain", "bool", true, regenerate_terrain_mod_icon, "Destroyed terrain will reform, with a delay.");
    
    gamemode_mod_create("always_sliding", "Slippery Floor", "bool", true, always_sliding_mod_icon, "You're always sliding around.");

    gamemode_mod_create("dark_orb_energy_lock", "Dark Orb Energy lock", "bool", true, dark_orb_energy_lock_mod_icon, "Dark Orb energy will always be at 100%.");
    
    gamemode_mod_create("color_orbs_energy_lock", "Color Orb Energy lock", "bool", true, orbs_energy_lock_mod_icon, "Color Orb energy will always be at 100%.");
    
    gamemode_mod_create("orbs_energy_min_lock", "Orb Energy min-lock", "bool", true, orbs_energy_min_lock_mod_on_icon, "Orb energy will not go below 100%.");

    gamemode_mod_create("heavy_shots", "Heavy Bolts", "bool", true, heavy_shots_mod_icon, "Projectiles are heavier and their gravity applies immediately.");
    
    gamemode_mod_create("equal_colors", "Equal Colors", "bool", true, equal_colors_mod_icon, "All Colors are equal in damage.");
    
    gamemode_mod_create("base_colors_only", "Base Colors Only", "bool", true, base_colors_only_mod_icon, "No multi-Color combos.");
    
    gamemode_mod_create("shield_push", "Shield Push", "bool", true, shield_push_mod_icon, "Shield pushes away mobs and characters.");


    // game elements
    gamemode_mod_create("cannons", "Cannons", "bool", true, cannons_mod2_icon, "Base-mounted Artillery which uses extra Orbs as ammo.");

    gamemode_mod_create("turrets", "Turrets", "bool", true, turrets_mod_icon, "Terrain-mounted weaponry of various calibers.");

    gamemode_mod_create("mob_portals", "Mob Portals", "bool", true, mob_portals_mod_icon, "Portals periodically spawn groups of aggressive Mobs.");

    gamemode_mod_create("base_crystals", "Base Crystals", "bool", true, base_crystals_mod_icon, "Base Crystals provide a large Shield, which can Heal you using Shards.");

    gamemode_mod_create("dark_color", "Dark Color", "bool", true, dark_color_mod_icon, "Dark attacks and Abilities mess with space and time.");
    
    gamemode_mod_create("bad_status_effects", "Status Effects", "bool", true, bad_status_effects_mod_icon, "Every Color except Dark has a Status Effect, e.g. Slow(Green), Frozen(Blue)...");

    gamemode_mod_create("abilities", "Abilities", "bool", true, abilities_mod_icon, "Every Color has an Ability, e.g. Heal(Green), Blink(Blue)...");


    // phenomena
    gamemode_mod_create("random_item_spawner", "Random Items", "bool", true, random_item_spawner_mod_icon, "Items will spawn randomly around the arena.");

    gamemode_mod_create("snakes_on_a_plane", "Snakes", "bool", true, snakes2_mod_icon, "Snakes are allowed to exist and will spawn inside destructible blocks.");

    gamemode_mod_create("bolt_rain", "Bolt rain", "bool", true, bolt_rain_mod_icon, "Showers of stray Barrage shots will fall down periodically.");

    gamemode_mod_create("slime_mob_rain", "Slime-fall", "bool", true, slime_mob_rain_mod_icon, "Ocasionally a bunch of Slimes will from the sky.");

    gamemode_mod_create("artifacts", "Artifacts", "bool", true, artifacts_mod_icon, "Artifacts will appear.");

    gamemode_mod_create("lightning_strikes", "Lightning", "bool", true, lightning_strikes_mod2_icon, "Lightning strikes... again!");


    // tutorial
    gamemode_mod_create("tutorials", "Tutorials", "bool", true, tutorials_mod_icon, "Context-sensitive tutorials try to teach you as you play a match.");

    gamemode_mod_create("tut_guide", "Tutorial Guide", "bool", true, tut_guide_mod_icon, "NPC Guide will show and explain the game to you.");


    // number mods
    gamemode_mod_create("base_crystal_hp", "Base Crystal HP", "number", true, base_crystal_hp_mod_icon, "Starting Health of your Base");
    gamemode_number_mod_values("base_crystal_hp", 10, 1, 10, 1);
    
    gamemode_mod_create("base_crystal_shield_power", "Base Crystal Shield HP", "number", true, base_crystal_sp_mod_icon, "Strength of Base Crystal Shield");
    gamemode_number_mod_values("base_crystal_shield_power", 6, 0, 6, 1);
    
    gamemode_mod_create("guy_shield_power", "Personal Shield HP", "number", true, guy_sp_mod_icon, "Strength of Player's Shield");
    gamemode_number_mod_values("guy_shield_power", 100, 0, 150, 50);
    
    gamemode_mod_create("flag_capture", "Capture the Flag", "number", true, flag_capture_mod_icon, "Toggle Flag Holders and set score for capturing a Flag.");
    gamemode_number_mod_values("flag_capture", 60, 10, 120, 10);
    
    gamemode_mod_create("death_limit", "Death Limit", "number", true, death_limit_mod_icon, "Players won't respawn after dying X times.");
    gamemode_number_mod_values("death_limit", 3, 1, 20, 1);
    
    gamemode_mod_create("score_limit", "Score Limit", "number", true, score_limit_mod_icon, "The game will end if a player reaches X points.");
    gamemode_number_mod_values("score_limit", 200, 1, 999, 1);
    
    gamemode_mod_create("time_limit", "Time Limit", "number", true, time_limit_mod_icon, "The game will end after X minutes.");
    gamemode_number_mod_values("time_limit", 15, 1, 60, 1);
    
    gamemode_mod_create("sudden_death_start", "Sudden Death", "number", true, sudden_death_start_mod_icon, "Players won't respawn after X minutes pass.");
    gamemode_number_mod_values("sudden_death_start", 10, 1, 30, 1);
    
    gamemode_mod_create("darkness", "Darkness", "number", true, darkness_mod_icon, "Make the arena dark(er). 100 is pitch black.");
    gamemode_number_mod_values("darkness", 80, 50, 100, 1);
}