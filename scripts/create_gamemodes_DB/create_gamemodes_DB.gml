function create_gamemodes_DB() {
    gamemode_list = ds_list_create();
    gamemodes = ds_map_create();

    gamemode_rule_list = ds_list_create();

    gamemode_rules = ds_map_create();
    
    rule_categories = new RuleCategoriesDB();
    rule_presets = new RulePresetsDB();
    
    // RULES
    define_rules_DB();
    
    // RULE CATEGORIES (MOD CATEGORIES)
    define_rule_categories_DB(rule_categories);

    // RULE PRESETS (MOD PRESETS)
    define_rule_presets_DB(rule_presets);
    
    // GAMEMODES
    var gm, forced_rules, default_rules;
    var RuleID = global.RuleID;

    // Quick Training
    gm = gamemode_create("quick_tutorial", "Training", true, quick_tutorial_world_obj);
    gm[? "description"] = "Journey from Rookie to Cybermage. Optimized for one trainee. Two skilled mages can compete in a Race to the Exit.\n (This is a Tutorial mode.)";
    gm[? "start_script"] = gm_quick_tutorial_start;
    gm[? "min_real_players"] = 2;
    gm[? "max_players"] = 2;
    gm[? "is_coop"] = true;
    gm[? "is_deathmatch"] = false;

    forced_rules = gm[? "forced_rules"];
    forced_rules[? RuleID.Turrets] = true;
    forced_rules[? RuleID.Cannons] = false;
    forced_rules[? RuleID.MobPortals] = true;
    forced_rules[? RuleID.Snakes] = false;
    forced_rules[? RuleID.BoltRain] = false;
    forced_rules[? RuleID.DarkOrbEnergyLock] = false;
    forced_rules[? RuleID.ColorOrbsEnergyLock] = false;
    forced_rules[? RuleID.ColorOrbsEnergyMinLock] = false;
    forced_rules[? RuleID.CurveBalls] = false;
    forced_rules[? RuleID.EqualColors] = false;
    forced_rules[? RuleID.BaseColorsOnly] = false;
    forced_rules[? RuleID.ShieldPush] = true;
    forced_rules[? RuleID.HpDeath] = true;
    forced_rules[? RuleID.HolographicSpawners] = false;
    forced_rules[? RuleID.BaseCrystals] = false;
    forced_rules[? RuleID.WeakTerrain] = false;
    forced_rules[? RuleID.IndestructibleTerrain] = false;
    forced_rules[? RuleID.RegenerateTerrain] = false;
    forced_rules[? RuleID.AlwaysSliding] = false;
    forced_rules[? RuleID.DarkColor] = true;
    forced_rules[? RuleID.BoltRain] = false;
    forced_rules[? RuleID.NegativeStatusEffects] = true;
    forced_rules[? RuleID.Abilities] = false;
    forced_rules[? RuleID.TutorialOverlay] = false;
    forced_rules[? RuleID.RandomItemSpawner] = false;
    forced_rules[? RuleID.SlimeMobRain] = false;
    forced_rules[? RuleID.Artifacts] = false;
    forced_rules[? RuleID.LightningStrikes] = false;
    
    forced_rules[? RuleID.BaseCrystalHP] = false;
    forced_rules[? RuleID.BaseCrystalShieldHP] = false;
    forced_rules[? RuleID.PersonalShieldHP] = false;
    forced_rules[? RuleID.FlagCaptureScore] = false;
    forced_rules[? RuleID.DeathLimit] = false;
    forced_rules[? RuleID.ScoreLimit] = false;
    forced_rules[? RuleID.TimeLimit] = false;
    forced_rules[? RuleID.SuddenDeathStart] = false;

    default_rules = gm[? "default_rules"];
    default_rules[? RuleID.TutorialGuide] = true;


    // Pit Fight
    gm = gamemode_create("sparring", "Pit Fight", true, sparring_world);
    gm[? "description"] = "Face a series of fighters of increasing difficulty. How many can you defeat before you fall?";
    gm[? "start_script"] = gm_sparring_start;

    forced_rules = gm[? "forced_rules"];
    forced_rules[? RuleID.HpDeath] = true;
    forced_rules[? RuleID.BaseCrystals] = false;
    forced_rules[? RuleID.TutorialGuide] = false;
    forced_rules[? RuleID.SlimeMobRain] = false;
    forced_rules[? RuleID.Artifacts] = false;
    forced_rules[? RuleID.LightningStrikes] = false;
    forced_rules[? RuleID.ShieldPush] = true;
    
    forced_rules[? RuleID.BaseCrystalHP] = false;
    forced_rules[? RuleID.BaseCrystalShieldHP] = false;
    forced_rules[? RuleID.PersonalShieldHP] = false;
    forced_rules[? RuleID.FlagCaptureScore] = false;
    forced_rules[? RuleID.DeathLimit] = 1;
    forced_rules[? RuleID.ScoreLimit] = false;
    forced_rules[? RuleID.TimeLimit] = false;
    forced_rules[? RuleID.SuddenDeathStart] = false;

    default_rules = gm[? "default_rules"];
    default_rules[? RuleID.DarkColor] = true;
    default_rules[? RuleID.NegativeStatusEffects] = true;
    default_rules[? RuleID.Abilities] = true;


    // Arena
    gm = gamemode_create("arena", "Arena", false, arena_world);
    gm[? "description"] = "Fight another player (or a bot) in various arenas.";

    gm[? "min_players"] = 2;
    gm[? "max_players"] = 4;
    gm[? "min_teams"] = 2;
    gm[? "max_teams"] = 4;
    gm[? "start_place_room"] = classic_arena;
    
    ds_list_add(gm[? "rule_presets"], "arena_novice", "arena_apprentice", "arena_arcade", "arena_standard");

    forced_rules = gm[? "forced_rules"];
    forced_rules[? RuleID.TutorialGuide] = false;

    default_rules = gm[? "default_rules"];


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

    forced_rules = gm[? "forced_rules"];
    forced_rules[? RuleID.BaseCrystals] = false;
    forced_rules[? RuleID.TutorialGuide] = false;
    forced_rules[? RuleID.ShieldPush] = true;
    
    forced_rules[? RuleID.BaseCrystalHP] = false;
    forced_rules[? RuleID.BaseCrystalShieldHP] = false;
    forced_rules[? RuleID.FlagCaptureScore] = false;

    default_rules = gm[? "default_rules"];
    default_rules[? RuleID.Turrets] = true;
    default_rules[? RuleID.Cannons] = true;
    default_rules[? RuleID.Snakes] = false;
    default_rules[? RuleID.HpDeath] = true;
    default_rules[? RuleID.DarkColor] = true;
    default_rules[? RuleID.NegativeStatusEffects] = true;
    default_rules[? RuleID.Abilities] = true;


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

    forced_rules = gm[? "forced_rules"];
    forced_rules[? RuleID.HpDeath] = false;
    forced_rules[? RuleID.BaseCrystals] = false;
    forced_rules[? RuleID.HolographicSpawners] = false;
    forced_rules[? RuleID.RandomItemSpawner] = false;
    forced_rules[? RuleID.Snakes] = false;
    forced_rules[? RuleID.BoltRain] = false;
    forced_rules[? RuleID.DarkOrbEnergyLock] = false;
    forced_rules[? RuleID.ColorOrbsEnergyLock] = false;
    forced_rules[? RuleID.ColorOrbsEnergyMinLock] = false;
    forced_rules[? RuleID.ShieldPush] = false;
    forced_rules[? RuleID.TutorialGuide] = false;
    forced_rules[? RuleID.Cannons] = false;
    forced_rules[? RuleID.Turrets] = false;
    forced_rules[? RuleID.MobPortals] = false;
    forced_rules[? RuleID.DarkColor] = false;
    forced_rules[? RuleID.NegativeStatusEffects] = false;
    forced_rules[? RuleID.Abilities] = false;
    forced_rules[? RuleID.TutorialOverlay] = false;
    forced_rules[? RuleID.CurveBalls] = false;
    forced_rules[? RuleID.EqualColors] = true;
    forced_rules[? RuleID.BaseColorsOnly] = false;
    forced_rules[? RuleID.SlimeMobRain] = false;
    forced_rules[? RuleID.Artifacts] = false;
    forced_rules[? RuleID.LightningStrikes] = false;
    
    forced_rules[? RuleID.BaseCrystalHP] = false;
    forced_rules[? RuleID.BaseCrystalShieldHP] = false;
    forced_rules[? RuleID.PersonalShieldHP] = false;
    forced_rules[? RuleID.FlagCaptureScore] = false;

    default_rules = gm[? "default_rules"];
    default_rules[? RuleID.ScoreLimit] = 10;
    
    
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

    forced_rules = gm[? "forced_rules"];
    forced_rules[? RuleID.HpDeath] = false;
    forced_rules[? RuleID.BaseCrystals] = false;
    forced_rules[? RuleID.HolographicSpawners] = false;
    forced_rules[? RuleID.WeakTerrain] = false;
    forced_rules[? RuleID.IndestructibleTerrain] = false;
    forced_rules[? RuleID.RegenerateTerrain] = false;
    forced_rules[? RuleID.RandomItemSpawner] = false;
    forced_rules[? RuleID.Snakes] = false;
    forced_rules[? RuleID.BoltRain] = false;
    forced_rules[? RuleID.DarkColor] = false;
    forced_rules[? RuleID.DarkOrbEnergyLock] = false;
    forced_rules[? RuleID.ColorOrbsEnergyLock] = false;
    forced_rules[? RuleID.ColorOrbsEnergyMinLock] = false;
    forced_rules[? RuleID.TutorialGuide] = false;
    forced_rules[? RuleID.Cannons] = false;
    forced_rules[? RuleID.Turrets] = false;
    forced_rules[? RuleID.MobPortals] = false;
    forced_rules[? RuleID.NegativeStatusEffects] = false;
    forced_rules[? RuleID.Abilities] = false;
    forced_rules[? RuleID.TutorialOverlay] = false;
    forced_rules[? RuleID.CurveBalls] = false;
    forced_rules[? RuleID.EqualColors] = false;
    forced_rules[? RuleID.BaseColorsOnly] = false;
    forced_rules[? RuleID.SlimeMobRain] = false;
    forced_rules[? RuleID.Artifacts] = false;
    forced_rules[? RuleID.LightningStrikes] = false;
    forced_rules[? RuleID.ShieldPush] = false;
    
    forced_rules[? RuleID.BaseCrystalHP] = false;
    forced_rules[? RuleID.BaseCrystalShieldHP] = false;
    forced_rules[? RuleID.PersonalShieldHP] = false;
    forced_rules[? RuleID.FlagCaptureScore] = false;
    forced_rules[? RuleID.DeathLimit] = false;
    forced_rules[? RuleID.ScoreLimit] = true;
    forced_rules[? RuleID.SuddenDeathStart] = false;

    default_rules = gm[? "default_rules"];
    default_rules[? RuleID.WeakTerrain] = true;
    default_rules[? RuleID.RegenerateTerrain] = true;
    default_rules[? RuleID.ScoreLimit] = 10;


    // Base survival
    gm = gamemode_create("survival", "Base Survival", true, survival_world);
    gm[? "description"] = "Defend against infinite waves of enemies.";
    gm[? "start_script"] = gm_survival_start;
    gm[? "min_real_players"] = 1;
    gm[? "max_players"] = 1;
    gm[? "is_coop"] = true;

    forced_rules = gm[? "forced_rules"];
    forced_rules[? RuleID.MobPortals] = true;
    forced_rules[? RuleID.BaseCrystals] = true;
    forced_rules[? RuleID.IndestructibleTerrain] = false;
    forced_rules[? RuleID.RegenerateTerrain] = false;
    forced_rules[? RuleID.FlagCaptureScore] = false;
    forced_rules[? RuleID.RandomItemSpawner] = false;
    forced_rules[? RuleID.Snakes] = false;
    forced_rules[? RuleID.ShieldPush] = true;
    forced_rules[? RuleID.TutorialGuide] = false;
    
    default_rules = gm[? "default_rules"];
    default_rules[? RuleID.HpDeath] = true;
    default_rules[? RuleID.Turrets] = true;
    default_rules[? RuleID.Cannons] = true;
    default_rules[? RuleID.DarkColor] = true;
    default_rules[? RuleID.NegativeStatusEffects] = true;
    default_rules[? RuleID.Abilities] = true;
    default_rules[? RuleID.WeakTerrain] = true;


    // Old Training
    gm = gamemode_create("training", "Challenge", true, world_1_obj);
    //gm[? "description"] = "This was originally supposed to be the tutorial-as-campaign, but it's way too hard for tutorial. Does have some art.";
    gm[? "description"] = "Experimental levels for experienced players! These were originally supposed to be a part of the tutorial. They're way too hard, but have some art.";
    gm[? "start_script"] = gm_tutorial_start;
    gm[? "min_real_players"] = 2;
    gm[? "max_players"] = 2;
    gm[? "is_coop"] = true;
    gm[? "is_deathmatch"] = false;

    forced_rules = gm[? "forced_rules"];
    forced_rules[? RuleID.Turrets] = true;
    forced_rules[? RuleID.Cannons] = true;
    forced_rules[? RuleID.MobPortals] = true;
    forced_rules[? RuleID.Snakes] = false;
    forced_rules[? RuleID.DarkOrbEnergyLock] = false;
    forced_rules[? RuleID.ColorOrbsEnergyLock] = false;
    forced_rules[? RuleID.ColorOrbsEnergyMinLock] = false;
    forced_rules[? RuleID.CurveBalls] = false;
    forced_rules[? RuleID.EqualColors] = false;
    forced_rules[? RuleID.BaseColorsOnly] = false;
    forced_rules[? RuleID.ShieldPush] = true;
    forced_rules[? RuleID.HpDeath] = true;
    forced_rules[? RuleID.HolographicSpawners] = false;
    forced_rules[? RuleID.BaseCrystals] = false;
    forced_rules[? RuleID.WeakTerrain] = false;
    forced_rules[? RuleID.IndestructibleTerrain] = false;
    forced_rules[? RuleID.RegenerateTerrain] = false;
    forced_rules[? RuleID.AlwaysSliding] = false;
    forced_rules[? RuleID.DarkColor] = true;
    forced_rules[? RuleID.BoltRain] = false;
    forced_rules[? RuleID.NegativeStatusEffects] = true;
    forced_rules[? RuleID.Abilities] = true;
    forced_rules[? RuleID.TutorialOverlay] = false;
    forced_rules[? RuleID.RandomItemSpawner] = false;
    forced_rules[? RuleID.SlimeMobRain] = false;
    forced_rules[? RuleID.Artifacts] = false;
    forced_rules[? RuleID.LightningStrikes] = false;
    
    forced_rules[? RuleID.BaseCrystalHP] = false;
    forced_rules[? RuleID.BaseCrystalShieldHP] = false;
    forced_rules[? RuleID.PersonalShieldHP] = false;
    forced_rules[? RuleID.FlagCaptureScore] = false;
    forced_rules[? RuleID.DeathLimit] = false;
    forced_rules[? RuleID.ScoreLimit] = false;
    forced_rules[? RuleID.TimeLimit] = false;
    forced_rules[? RuleID.SuddenDeathStart] = false;

    default_rules = gm[? "default_rules"];
    default_rules[? RuleID.TutorialGuide] = true;


    // Loop world
    gm = gamemode_create("loop_world", "Loop world", true, loop_world_obj);
    gm[? "description"] = "Not linear!";
    gm[? "min_real_players"] = 0;
    gm[? "max_players"] = 1;
    gm[? "start_place_room"] = room_empty_base;
    gm[? "is_coop"] = true;
    
    forced_rules = gm[? "forced_rules"];
    forced_rules[? RuleID.TutorialGuide] = false;
    
    default_rules = gm[? "default_rules"];
    default_rules[? RuleID.ShieldPush] = true;


    // Test mode
    gm = gamemode_create("test_mode", "Extras", true, test_world_obj);
    gm[? "description"] = "Testing worlds, sandbox levels and other crazy stuff. If X collides with Y, how much does it break?";
    gm[? "min_real_players"] = 0;
    gm[? "max_players"] = 2;
    gm[? "max_teams"] = 2;
    gm[? "is_coop"] = false;
    
    forced_rules = gm[? "forced_rules"];
    forced_rules[? RuleID.TutorialGuide] = false;

    default_rules = gm[? "default_rules"];
    default_rules[? RuleID.ShieldPush] = true;
    default_rules[? RuleID.DarkColor] = true;
    default_rules[? RuleID.NegativeStatusEffects] = true;
    default_rules[? RuleID.Abilities] = true;

    /*
    // Roguelike
    gm = gamemode_create("roguelike", "Roguelike", true, roguelike_world);
    gm[? "description"] = "Randomly generated world, Extremely experimental";
    gm[? "start_script"] = gm_roguelike_start;
    gm[? "min_real_players"] = 0;
    gm[? "max_players"] = 1;

    forced_rules = gm[? "forced_rules"];
    forced_rules[? RuleID.Turrets] = true;
    forced_rules[? RuleID.Cannons] = true;
    forced_rules[? RuleID.MobPortals] = true;
    forced_rules[? RuleID.HpDeath] = true;
    */
}
