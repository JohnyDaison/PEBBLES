/// @description init_levels_DB()
/// @function init_levels_DB
function init_levels_DB() {
    // comments are classic start values
    // the types should be done differently - e.g. movement, defence, offence, capacity
    var dark_max = 1;
    var color_max = 3;
    var col;

    // Movement
    define_level_DB("charged_jump", "movement",             "Charged Jump", 0, 3); //2
    define_level_DB("air_jump", "movement",                 "Air Jump", 0, 3); //2
    define_level_DB("wall_hold", "movement",                "Wall Hold", 0, 1); //1
    define_level_DB("wall_climb", "movement",               "Wall Climb", 0, 2); //2
    define_level_DB("wall_jump", "movement",                "Wall Jump", 0, 3); //3
    define_level_DB("dive_move", "movement",                "Dive", 0, 3); //2

    // Storage
    define_level_DB("inventory", "capacity",                "Inventory size", 0, 4); //4
    define_level_DB("colors_belt_size", "capacity",         "Color belt size", 0, color_max); //3
    define_level_DB("dark_belt_size", "capacity",           "Dark belt size", 0, dark_max); //1
    define_level_DB("orb_storage_size", "capacity",         "Orb storage size", 0, 99); //99

    // Orbs
    define_level_DB("orbs0", "orbs",                        "Orbs 0", 0, dark_max); //1

    for(col = g_red; col<=g_blue; col++)
    {
        if(col == g_yellow)
            continue;
        
        define_level_DB("orbs"+string(col), "orbs",         "Orbs "+string(col), 0, color_max); //3
    }

    // Combat
    define_level_DB("guy_orbit", "capacity",                "Color combo", 0, 3); //3
    define_level_DB("chargeball", "equipment",              "Catalyst", 0, 3); //3
    define_level_DB("dark_mode", "attack",                  "Dark mode", 0, 3); //1 or 2?
    define_level_DB("blast_mode", "attack",                 "Blast mode", 0, 3); //1 or 2?
    define_level_DB("barrage_mode", "attack",               "Barrage mode", 0, 3); //1 or 2?
    define_level_DB("dashwave_mode", "attack",              "Dash-Wave mode", 0, 3); //1 or 2?
    define_level_DB("shield", "equipment",                  "Shield", 0, 1); //1

    define_level_DB("channeling", "skill",                  "Channeling", 0, 3); //2
    //secondary mode skill?

    define_level_DB("recovery", "skill",                    "Recovery", 0, 9); //6
    // speeds up getting out of lost_control? how?
    // or prolongs protection after getting up?

    // Abilities
    define_level_DB("rewind", "ability",                    "Rewind", 0, 2); //1
    define_level_DB("berserk", "ability",                   "Berserk", 0, 2); //1
    define_level_DB("heal", "ability",                      "Heal", 0, 2); //1
    define_level_DB("teleport", "ability",                  "Blink", 0, 2); //1
    define_level_DB("haste", "ability",                     "Haste", 0, 2); //1
    define_level_DB("ubershield", "ability",                "Ubershield", 0, 2); //1
    define_level_DB("invisibility", "ability",              "Invisibility", 0, 2); //1
    define_level_DB("base_teleport", "ability",             "Teleport", 0, 2); //1
}
