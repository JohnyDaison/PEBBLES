function create_gamemodes_DB() {
    gamemode_list = ds_list_create();
    gamemodes = ds_map_create();

    gamemode_mod_list = ds_list_create();
    gamemode_mod_type_list = ds_list_create();

    gamemode_mods = ds_map_create();
    
    rule_categories = new RuleCategoriesDB();
    rule_presets = new RulePresetsDB();
    
    // RULES
    define_rules_DB();
    
    // RULE CATEGORIES (MOD CATEGORIES)
    define_rule_categories_DB(rule_categories);

    // RULE PRESETS (MOD PRESETS)
    define_rule_presets_DB(rule_presets);
    
    // GAMEMODES
    var gm, forced_mods, default_mods;

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
    forced_mods[? "base_colors_only"] = false;
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
    forced_mods[? "score_limit"] = false;
    forced_mods[? "time_limit"] = false;
    forced_mods[? "sudden_death_start"] = false;

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
    forced_mods[? "score_limit"] = false;
    forced_mods[? "time_limit"] = false;
    forced_mods[? "sudden_death_start"] = false;

    default_mods = gm[? "default_modifiers"];
    default_mods[? "dark_color"] = true;
    default_mods[? "bad_status_effects"] = true;
    default_mods[? "abilities"] = true;


    // Arena
    gm = gamemode_create("arena", "Arena", false, arena_world);
    gm[? "description"] = "Fight another player (or a bot) in various arenas.";

    gm[? "min_players"] = 2;
    gm[? "max_players"] = 4;
    gm[? "min_teams"] = 2;
    gm[? "max_teams"] = 4;
    gm[? "start_place_room"] = classic_arena;
    
    ds_list_add(gm[? "rule_presets"], "arena_novice", "arena_apprentice", "arena_arcade", "arena_standard");

    forced_mods = gm[? "forced_modifiers"];
    forced_mods[? "tut_guide"] = false;

    default_mods = gm[? "default_modifiers"];


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
    
    ds_list_add(gm[? "rule_presets"], "basic_bumping", "deadly_spiking", "court_attrition", "volley_infinite");

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
    forced_mods[? "shield_push"] = false;
    forced_mods[? "tut_guide"] = false;
    forced_mods[? "cannons"] = false;
    forced_mods[? "turrets"] = false;
    forced_mods[? "mob_portals"] = false;
    forced_mods[? "dark_color"] = false;
    forced_mods[? "bad_status_effects"] = false;
    forced_mods[? "abilities"] = false;
    forced_mods[? "tutorials"] = false;
    forced_mods[? "heavy_shots"] = false;
    forced_mods[? "equal_colors"] = true;
    forced_mods[? "base_colors_only"] = false;
    forced_mods[? "slime_mob_rain"] = false;
    forced_mods[? "artifacts"] = false;
    forced_mods[? "lightning_strikes"] = false;
    
    forced_mods[? "base_crystal_hp"] = false;
    forced_mods[? "base_crystal_shield_power"] = false;
    forced_mods[? "guy_shield_power"] = false;
    forced_mods[? "flag_capture"] = false;

    default_mods = gm[? "default_modifiers"];
    default_mods[? "score_limit"] = 10;
    
    
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

    forced_mods = gm[? "forced_modifiers"];
    forced_mods[? "hp_death"] = false;
    forced_mods[? "base_crystals"] = false;
    forced_mods[? "holographic_spawners"] = false;
    forced_mods[? "weak_terrain"] = false;
    forced_mods[? "indestr_terrain"] = false;
    forced_mods[? "regenerate_terrain"] = false;
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
    forced_mods[? "base_colors_only"] = false;
    forced_mods[? "slime_mob_rain"] = false;
    forced_mods[? "artifacts"] = false;
    forced_mods[? "lightning_strikes"] = false;
    forced_mods[? "shield_push"] = false;
    
    forced_mods[? "base_crystal_hp"] = false;
    forced_mods[? "base_crystal_shield_power"] = false;
    forced_mods[? "guy_shield_power"] = false;
    forced_mods[? "flag_capture"] = false;
    forced_mods[? "death_limit"] = false;
    forced_mods[? "score_limit"] = true;
    forced_mods[? "sudden_death_start"] = false;

    default_mods = gm[? "default_modifiers"];
    default_mods[? "weak_terrain"] = true;
    default_mods[? "regenerate_terrain"] = true;
    default_mods[? "score_limit"] = 10;


    // Base survival
    gm = gamemode_create("survival", "Base Survival", true, survival_world);
    gm[? "description"] = "Defend against infinite waves of enemies.";
    gm[? "start_script"] = gm_survival_start;
    gm[? "min_real_players"] = 1;
    gm[? "max_players"] = 1;
    gm[? "is_coop"] = true;

    forced_mods = gm[? "forced_modifiers"];
    forced_mods[? "mob_portals"] = true;
    forced_mods[? "base_crystals"] = true;
    forced_mods[? "indestr_terrain"] = false;
    forced_mods[? "regenerate_terrain"] = false;
    forced_mods[? "flag_capture"] = false;
    forced_mods[? "random_item_spawner"] = false;
    forced_mods[? "snakes_on_a_plane"] = false;
    forced_mods[? "shield_push"] = true;
    forced_mods[? "tut_guide"] = false;
    
    default_mods = gm[? "default_modifiers"];
    default_mods[? "hp_death"] = true;
    default_mods[? "turrets"] = true;
    default_mods[? "cannons"] = true;
    default_mods[? "dark_color"] = true;
    default_mods[? "bad_status_effects"] = true;
    default_mods[? "abilities"] = true;
    default_mods[? "weak_terrain"] = true;


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
    forced_mods[? "base_colors_only"] = false;
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
    forced_mods[? "score_limit"] = false;
    forced_mods[? "time_limit"] = false;
    forced_mods[? "sudden_death_start"] = false;

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
