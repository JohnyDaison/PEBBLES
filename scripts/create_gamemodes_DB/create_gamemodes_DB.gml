function create_gamemodes_DB() {
    gamemode_list = ds_list_create();
    gamemodes = ds_map_create();

    gamemode_mod_list = ds_list_create();
    gamemode_mod_type_list = ds_list_create();

    gamemode_mods = ds_map_create();

    var gm, limits, forced_mods, default_mods;

    // MODS

    // rules
    gamemode_mod_create("hp_death", "HP Death", "bool", true, hp_death_mod2_icon, "Losing all HP will result in instant death. (Otherwise you die only by falling off the arena.)");

    gamemode_mod_create("holographic_spawners", "Holographic Spawners", "bool", true, holo_spawners_mod2_icon, "Base Crystals can't be damaged by attacks. Respawning the Player will still damage them.");

    gamemode_mod_create("weak_terrain", "Weak Terrain", "bool", true, weak_terrain_mod3_icon, "Destructible terrain has 1/3 of normal HP.");

    gamemode_mod_create("indestr_terrain", "Indestructible Terrain", "bool", true, indestr_terrain_mod_icon, "All terrain is indestructible.");

    gamemode_mod_create("regenerate_terrain", "Regenerate Terrain", "bool", true, regenerate_terrain_mod_icon, "Destroyed terrain will reform, with a delay.");
    
    gamemode_mod_create("always_sliding", "Slippery Floor", "bool", true, always_sliding_mod_icon, "You're always sliding around.");

    gamemode_mod_create("dark_orb_energy_lock", "Dark Orb Energy lock", "bool", true, dark_orb_energy_lock_mod_icon, "Dark Orb energy will always be at 100%.");
    
    gamemode_mod_create("color_orbs_energy_lock", "Color Orb Energy lock", "bool", true, orbs_energy_lock_mod_icon, "Color Orb energy will always be at 100%.");

    gamemode_mod_create("heavy_shots", "Heavy Bolts", "bool", true, heavy_shots_mod_icon, "Projectiles are heavier and their gravity applies immediately.");
    
    gamemode_mod_create("equal_colors", "Equal Colors", "bool", true, equal_colors_mod_icon, "All Colors are equal in damage.");
    
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
    
    gamemode_mod_create("orbs_energy_min_lock", "Orb Energy min-lock", "number", true, orbs_energy_min_lock_mod_on_icon, "Orb energy will not go below X %.");
    gamemode_number_mod_values("orbs_energy_min_lock", 100, 10, 100, 10);


    // GAMEMODES

    // Quick Training
    gm = gamemode_create("quick_tutorial", "Training", true, quick_tutorial_world_obj);
    gm[? "description"] = "Journey from Rookie to Cybermage. Optimized for one trainee. Two skilled mages can compete in a Race to the Exit.\n (This is a Tutorial mode.)";
    gm[? "start_script"] = gm_quick_tutorial_start;
    gm[? "min_real_players"] = 2;
    gm[? "max_players"] = 2;
    gm[? "is_coop"] = true;
    gm[? "is_deathmatch"] = false;

    forced_mods = gm[? "forced_modifiers"];
    forced_mods[? "turrets"] = true;
    forced_mods[? "cannons"] = false;
    forced_mods[? "mob_portals"] = true;
    forced_mods[? "snakes_on_a_plane"] = false;
    forced_mods[? "bolt_rain"] = false;
    forced_mods[? "dark_orb_energy_lock"] = false;
    forced_mods[? "color_orbs_energy_lock"] = false;
    forced_mods[? "orbs_energy_min_lock"] = false;
    forced_mods[? "heavy_shots"] = false;
    forced_mods[? "equal_colors"] = false;
    forced_mods[? "shield_push"] = true;
    forced_mods[? "hp_death"] = true;
    forced_mods[? "holographic_spawners"] = false;
    forced_mods[? "base_crystals"] = false;
    forced_mods[? "weak_terrain"] = false;
    forced_mods[? "indestr_terrain"] = false;
    forced_mods[? "regenerate_terrain"] = false;
    forced_mods[? "always_sliding"] = false;
    forced_mods[? "dark_color"] = true;
    forced_mods[? "bolt_rain"] = false;
    forced_mods[? "bad_status_effects"] = true;
    forced_mods[? "abilities"] = false;
    forced_mods[? "tutorials"] = false;
    forced_mods[? "random_item_spawner"] = false;
    forced_mods[? "slime_mob_rain"] = false;
    forced_mods[? "artifacts"] = false;
    forced_mods[? "lightning_strikes"] = false;
    
    forced_mods[? "base_crystal_hp"] = false;
    forced_mods[? "base_crystal_shield_power"] = false;
    forced_mods[? "guy_shield_power"] = false;
    forced_mods[? "flag_capture"] = false;
    forced_mods[? "death_limit"] = false;

    default_mods = gm[? "default_modifiers"];
    default_mods[? "tut_guide"] = true;


    // Pit Fight
    gm = gamemode_create("sparring", "Pit Fight", true, sparring_world);
    gm[? "description"] = "Face a series of fighters of increasing difficulty. How many can you defeat before you fall?";
    gm[? "start_script"] = gm_sparring_start;

    forced_mods = gm[? "forced_modifiers"];
    forced_mods[? "hp_death"] = true;
    forced_mods[? "base_crystals"] = false;
    forced_mods[? "tut_guide"] = false;
    forced_mods[? "slime_mob_rain"] = false;
    forced_mods[? "artifacts"] = false;
    forced_mods[? "lightning_strikes"] = false;
    forced_mods[? "shield_push"] = true;
    
    forced_mods[? "base_crystal_hp"] = false;
    forced_mods[? "base_crystal_shield_power"] = false;
    forced_mods[? "guy_shield_power"] = false;
    forced_mods[? "flag_capture"] = false;
    forced_mods[? "death_limit"] = 1;

    default_mods = gm[? "default_modifiers"];
    default_mods[? "dark_color"] = true;
    default_mods[? "bad_status_effects"] = true;
    default_mods[? "abilities"] = true;


    // Standard match  a.k.a. Full battle
    gm = gamemode_create("battle", "Standard Match", false, arena_world);
    //gm[? "description"] = "Dive into all-out warfare in this semi-tactical-action Battle mode.";
    gm[? "description"] = "Play a canonical duel match. Dive into all-out warfare in this semi-tactical battle mode.";

    gm[? "min_players"] = 2;
    gm[? "max_players"] = 4;
    gm[? "min_teams"] = 2;
    gm[? "max_teams"] = 4;
    gm[? "start_place_room"] = classic_arena;

    limits = gm[? "limits"];
    limits[? "score"] = 400;

    forced_mods = gm[? "forced_modifiers"];
    forced_mods[? "tut_guide"] = false;

    default_mods = gm[? "default_modifiers"];
    default_mods[? "turrets"] = true;
    default_mods[? "cannons"] = true;
    default_mods[? "mob_portals"] = true;
    default_mods[? "shield_push"] = true;

    default_mods[? "hp_death"] = true;
    default_mods[? "base_crystals"] = true;
    default_mods[? "dark_color"] = true;
    default_mods[? "bad_status_effects"] = true;
    default_mods[? "abilities"] = true;

    default_mods[? "snakes_on_a_plane"] = true;
    default_mods[? "slime_mob_rain"] = true;
    default_mods[? "artifacts"] = true;
    
    default_mods[? "base_crystal_hp"] = 10;
    default_mods[? "base_crystal_shield_power"] = 6;


    // Arcade match
    gm = gamemode_create("arcade", "Arcade Match", false, arena_world);
    gm[? "description"] = "Play a Versus match with Arcade rules for some simple, high-powered action.";
    gm[? "min_players"] = 2;
    gm[? "max_players"] = 4;
    gm[? "min_teams"] = 2;
    gm[? "max_teams"] = 4;
    gm[? "start_place_room"] = classic_arena;

    limits = gm[? "limits"];
    limits[? "score"] = 200;

    forced_mods = gm[? "forced_modifiers"];
    forced_mods[? "turrets"] = false;
    forced_mods[? "cannons"] = false;
    forced_mods[? "mob_portals"] = false;
    forced_mods[? "holographic_spawners"] = true;
    forced_mods[? "snakes_on_a_plane"] = false;
    forced_mods[? "tut_guide"] = false;
    forced_mods[? "shield_push"] = true;
    forced_mods[? "base_crystal_shield_power"] = false;
    forced_mods[? "orbs_energy_min_lock"] = true;
    
    default_mods = gm[? "default_modifiers"];
    default_mods[? "random_item_spawner"] = true;
    default_mods[? "base_crystals"] = true;
    default_mods[? "weak_terrain"] = true;
    default_mods[? "dark_orb_energy_lock"] = true;
    default_mods[? "equal_colors"] = true;
    default_mods[? "dark_color"] = true;
    default_mods[? "bad_status_effects"] = true;
    default_mods[? "abilities"] = true;
    default_mods[? "artifacts"] = true;
    
    default_mods[? "base_crystal_hp"] = 7;


    /*
    // Simple match
    gm = gamemode_create("simple", "Modern Match", false, arena_world);
    gm[? "description"] = "Play a Versus match with Modern rules, without new elements.";
    gm[? "min_players"] = 2;
    gm[? "max_players"] = 2;
    gm[? "start_place_room"] = closed_quarters_arena;

    limits = gm[? "limits"];
    limits[? "score"] = 200;

    forced_mods = gm[? "forced_modifiers"];
    forced_mods[? "turrets"] = false;
    forced_mods[? "cannons"] = false;
    forced_mods[? "mob_portals"] = false;
    forced_mods[? "snakes_on_a_plane"] = false;
    forced_mods[? "tut_guide"] = false;

    default_mods = gm[? "default_modifiers"];
    default_mods[? "base_crystals"] = true;
    default_mods[? "hp_death"] = true;
    default_mods[? "artifacts"] = true;
    
    default_mods[? "base_crystal_hp"] = 5;
    default_mods[? "base_crystal_shield_power"] = 2;
    */


    // Tower climb
    gm = gamemode_create("towerclimb", "Tower Climbing", true, towerclimb_world);
    gm[? "description"] = "Race to the top, trickery allowed.";
    gm[? "start_script"] = gm_towerclimb_start;
    gm[? "min_players"] = 2;
    gm[? "min_real_players"] = 2;
    gm[? "max_players"] = 2;
    gm[? "min_teams"] = 2;
    gm[? "max_teams"] = 2;
    gm[? "is_coop"] = false;

    forced_mods = gm[? "forced_modifiers"];
    forced_mods[? "base_crystals"] = false;
    forced_mods[? "tut_guide"] = false;
    forced_mods[? "shield_push"] = true;
    
    forced_mods[? "base_crystal_hp"] = false;
    forced_mods[? "base_crystal_shield_power"] = false;
    forced_mods[? "flag_capture"] = false;

    default_mods = gm[? "default_modifiers"];
    default_mods[? "turrets"] = true;
    default_mods[? "cannons"] = true;
    default_mods[? "snakes_on_a_plane"] = false;
    default_mods[? "hp_death"] = true;
    default_mods[? "dark_color"] = true;
    default_mods[? "bad_status_effects"] = true;
    default_mods[? "abilities"] = true;


    // Volleyball
    gm = gamemode_create("volleyball", "Volleyball", false, volleyball_world);
    gm[? "description"] = "Try a popular mini-game. Mind the holes in the court, though.";
    gm[? "base_level_config"] = "tutorial";
    gm[? "start_script"] = gm_volleyball_start;
    gm[? "min_players"] = 2;
    gm[? "max_players"] = 4;
    gm[? "min_teams"] = 2;
    gm[? "max_teams"] = 2;
    gm[? "is_deathmatch"] = false;
    gm[? "team_based"] = true;

    limits = gm[? "limits"];
    limits[? "score"] = 10;

    forced_mods = gm[? "forced_modifiers"];
    forced_mods[? "hp_death"] = false;
    forced_mods[? "base_crystals"] = false;
    forced_mods[? "holographic_spawners"] = false;
    forced_mods[? "random_item_spawner"] = false;
    forced_mods[? "snakes_on_a_plane"] = false;
    forced_mods[? "bolt_rain"] = false;
    forced_mods[? "dark_orb_energy_lock"] = false;
    forced_mods[? "color_orbs_energy_lock"] = false;
    forced_mods[? "orbs_energy_min_lock"] = false;
    forced_mods[? "shield_push"] = true;
    forced_mods[? "tut_guide"] = false;
    forced_mods[? "cannons"] = false;
    forced_mods[? "turrets"] = false;
    forced_mods[? "mob_portals"] = false;
    forced_mods[? "dark_color"] = false;
    forced_mods[? "bad_status_effects"] = false;
    forced_mods[? "abilities"] = false;
    forced_mods[? "tutorials"] = false;
    forced_mods[? "heavy_shots"] = false;
    forced_mods[? "equal_colors"] = false;
    forced_mods[? "slime_mob_rain"] = false;
    forced_mods[? "artifacts"] = false;
    forced_mods[? "lightning_strikes"] = false;
    
    forced_mods[? "base_crystal_hp"] = false;
    forced_mods[? "base_crystal_shield_power"] = false;
    forced_mods[? "guy_shield_power"] = false;
    forced_mods[? "flag_capture"] = false;

    default_mods = gm[? "default_modifiers"];
    default_mods[? "weak_terrain"] = true;
    default_mods[? "regenerate_terrain"] = true;
    default_mods[? "death_limit"] = true;
    
    
    // Hoopball
    gm = gamemode_create("hoopball", "Hoopball", false, hoopball_world);
    gm[? "description"] = "Another ball sport.";
    gm[? "base_level_config"] = "";
    gm[? "start_script"] = gm_hoopball_start;
    gm[? "min_players"] = 2;
    gm[? "max_players"] = 4;
    gm[? "min_teams"] = 2;
    gm[? "max_teams"] = 2;
    gm[? "is_deathmatch"] = false;
    gm[? "team_based"] = true;

    limits = gm[? "limits"];
    limits[? "score"] = 10;

    forced_mods = gm[? "forced_modifiers"];
    forced_mods[? "hp_death"] = false;
    forced_mods[? "base_crystals"] = false;
    forced_mods[? "holographic_spawners"] = false;
    forced_mods[? "random_item_spawner"] = false;
    forced_mods[? "snakes_on_a_plane"] = false;
    forced_mods[? "bolt_rain"] = false;
    forced_mods[? "dark_color"] = false;
    forced_mods[? "dark_orb_energy_lock"] = false;
    forced_mods[? "color_orbs_energy_lock"] = false;
    forced_mods[? "orbs_energy_min_lock"] = false;
    forced_mods[? "tut_guide"] = false;
    forced_mods[? "cannons"] = false;
    forced_mods[? "turrets"] = false;
    forced_mods[? "mob_portals"] = false;
    forced_mods[? "bad_status_effects"] = false;
    forced_mods[? "abilities"] = false;
    forced_mods[? "tutorials"] = false;
    forced_mods[? "heavy_shots"] = false;
    forced_mods[? "equal_colors"] = false;
    forced_mods[? "slime_mob_rain"] = false;
    forced_mods[? "artifacts"] = false;
    forced_mods[? "lightning_strikes"] = false;
    forced_mods[? "shield_push"] = false;
    
    forced_mods[? "base_crystal_hp"] = false;
    forced_mods[? "base_crystal_shield_power"] = false;
    forced_mods[? "guy_shield_power"] = false;
    forced_mods[? "flag_capture"] = false;
    forced_mods[? "death_limit"] = false;

    default_mods = gm[? "default_modifiers"];
    default_mods[? "weak_terrain"] = true;
    default_mods[? "regenerate_terrain"] = true;


    /*
    // Base survival
    gm = gamemode_create("survival", "Base Survival", true, survival_world);
    gm[? "description"] = "Defend against infinite waves of enemies.";
    gm[? "start_script"] = gm_survival_start;
    gm[? "min_real_players"] = 0;
    gm[? "max_players"] = 1;
    gm[? "is_coop"] = true;

    forced_mods = gm[? "forced_modifiers"];
    forced_mods[? "mob_portals"] = true;
    forced_mods[? "base_crystals"] = true;
    forced_mods[? "tut_guide"] = false;
    
    default_mods = gm[? "default_modifiers"];
    default_mods[? "hp_death"] = true;
    default_mods[? "turrets"] = true;
    default_mods[? "cannons"] = true;
    default_mods[? "dark_color"] = true;
    default_mods[? "bad_status_effects"] = true;
    default_mods[? "abilities"] = true;
    */


    // Old Training
    gm = gamemode_create("training", "Challenge", true, world_1_obj);
    //gm[? "description"] = "This was originally supposed to be the tutorial-as-campaign, but it's way too hard for tutorial. Does have some art.";
    gm[? "description"] = "Experimental levels for experienced players! These were originally supposed to be a part of the tutorial. They're way too hard, but have some art.";
    gm[? "start_script"] = gm_tutorial_start;
    gm[? "min_real_players"] = 2;
    gm[? "max_players"] = 2;
    gm[? "is_coop"] = true;
    gm[? "is_deathmatch"] = false;

    forced_mods = gm[? "forced_modifiers"];
    forced_mods[? "turrets"] = true;
    forced_mods[? "cannons"] = true;
    forced_mods[? "mob_portals"] = true;
    forced_mods[? "snakes_on_a_plane"] = false;
    forced_mods[? "dark_orb_energy_lock"] = false;
    forced_mods[? "color_orbs_energy_lock"] = false;
    forced_mods[? "orbs_energy_min_lock"] = false;
    forced_mods[? "heavy_shots"] = false;
    forced_mods[? "equal_colors"] = false;
    forced_mods[? "shield_push"] = true;
    forced_mods[? "hp_death"] = true;
    forced_mods[? "holographic_spawners"] = false;
    forced_mods[? "base_crystals"] = false;
    forced_mods[? "weak_terrain"] = false;
    forced_mods[? "indestr_terrain"] = false;
    forced_mods[? "regenerate_terrain"] = false;
    forced_mods[? "always_sliding"] = false;
    forced_mods[? "dark_color"] = true;
    forced_mods[? "bolt_rain"] = false;
    forced_mods[? "bad_status_effects"] = true;
    forced_mods[? "abilities"] = true;
    forced_mods[? "tutorials"] = false;
    forced_mods[? "random_item_spawner"] = false;
    forced_mods[? "slime_mob_rain"] = false;
    forced_mods[? "artifacts"] = false;
    forced_mods[? "lightning_strikes"] = false;
    
    forced_mods[? "base_crystal_hp"] = false;
    forced_mods[? "base_crystal_shield_power"] = false;
    forced_mods[? "guy_shield_power"] = false;
    forced_mods[? "flag_capture"] = false;
    forced_mods[? "death_limit"] = false;

    default_mods = gm[? "default_modifiers"];
    default_mods[? "tut_guide"] = true;


    // Loop world
    gm = gamemode_create("loop_world", "Loop world", true, loop_world_obj);
    gm[? "description"] = "Not linear!";
    gm[? "min_real_players"] = 0;
    gm[? "max_players"] = 1;
    gm[? "start_place_room"] = room_empty_base;
    gm[? "is_coop"] = true;
    
    forced_mods = gm[? "forced_modifiers"];
    forced_mods[? "tut_guide"] = false;
    
    default_mods = gm[? "default_modifiers"];
    default_mods[? "shield_push"] = true;


    // Test mode
    gm = gamemode_create("test_mode", "Extras", true, test_world_obj);
    gm[? "description"] = "Testing worlds, sandbox levels and other crazy stuff. If X collides with Y, how much does it break?";
    gm[? "min_real_players"] = 0;
    gm[? "max_players"] = 2;
    gm[? "max_teams"] = 2;
    gm[? "is_coop"] = false;
    
    forced_mods = gm[? "forced_modifiers"];
    forced_mods[? "tut_guide"] = false;

    default_mods = gm[? "default_modifiers"];
    default_mods[? "shield_push"] = true;
    default_mods[? "dark_color"] = true;
    default_mods[? "bad_status_effects"] = true;
    default_mods[? "abilities"] = true;

    /*
    // Roguelike
    gm = gamemode_create("roguelike", "Roguelike", true, roguelike_world);
    gm[? "description"] = "Randomly generated world, Extremely experimental";
    gm[? "start_script"] = gm_roguelike_start;
    gm[? "min_real_players"] = 0;
    gm[? "max_players"] = 1;

    forced_mods = gm[? "forced_modifiers"];
    forced_mods[? "turrets"] = true;
    forced_mods[? "cannons"] = true;
    forced_mods[? "mob_portals"] = true;
    forced_mods[? "hp_death"] = true;
    */
}
