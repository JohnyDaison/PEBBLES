function levels_load_config(config) {
    if(config == "reset")
    {
        init_levels_gamemode();
    }
    else if(config == "match")
    {
        config_level_gamemode("charged_jump",       "", "", 2);
        config_level_gamemode("air_jump",           "", "", 2);
        config_level_gamemode("wall_hold",          "", "", 1);
        config_level_gamemode("wall_climb",         "", "", 2);
        config_level_gamemode("wall_jump",          "", "", 3);
        config_level_gamemode("dive_move",          "", "", 2);
    
        config_level_gamemode("guy_orbit",          "", "", 3);
        config_level_gamemode("chargeball",         "", "", 3);
        config_level_gamemode("dark_mode",          "", "", 1);
        config_level_gamemode("blast_mode",         "", "", 1);
        config_level_gamemode("barrage_mode",       "", "", 1);
        config_level_gamemode("dashwave_mode",      "", "", 1);
        config_level_gamemode("shield",             "", "", 1);
        
        config_level_gamemode("inventory",          "", "", 4);
        config_level_gamemode("colors_belt_size",   "", "", 3);
        config_level_gamemode("dark_belt_size",     "", "", 1);
        config_level_gamemode("orb_storage_size",   "", "", 99);
    
        for(var col = g_dark; col<=g_blue; col++)
        {
            var this_min, this_max;
            if(col == g_yellow)
            {
                continue;
            }
            if(col == g_dark)
            {
                this_min = level_minstart[? "dark_belt_size"];
                this_max = level_maxstart[? "dark_belt_size"];
            }
            else
            {
                this_min = level_minstart[? "colors_belt_size"];
                this_max = level_maxstart[? "colors_belt_size"];
            }
            
            config_level_gamemode("orbs"+string(col), "", "", this_min, this_max);
        }
    
        config_level_gamemode("channeling",         "", "", 1);
        config_level_gamemode("recovery",           "", "", 6);
    
        config_level_gamemode("rewind",             "", "", 1);
        config_level_gamemode("berserk",            "", "", 1);
        config_level_gamemode("heal",               "", "", 1);
        config_level_gamemode("teleport",           "", "", 1);
        config_level_gamemode("haste",              "", "", 1);
        config_level_gamemode("ubershield",         "", "", 1);
        config_level_gamemode("invisibility",       "", "", 1);
        config_level_gamemode("base_teleport",      "", "", 1);
    }
    else if(config == "tutorial")
    {
        config_level_gamemode("guy_orbit",          "", "", 1);
        config_level_gamemode("dark_mode",          "", "", 1);
        config_level_gamemode("blast_mode",         "", "", 1);
        config_level_gamemode("orb_storage_size",   "", "", 9);
        config_level_gamemode("recovery",           "", "", 6);
    }
    else if(config == "movement")
    {
        config_level_gamemode("charged_jump",       "", "", 2);
        config_level_gamemode("air_jump",           "", "", 2);
        config_level_gamemode("wall_hold",          "", "", 1);
        config_level_gamemode("wall_climb",         "", "", 2);
        config_level_gamemode("wall_jump",          "", "", 3);
        config_level_gamemode("dive_move",          "", "", 2);
    }
    else if(config == "base_colors")
    {
        config_level_gamemode("colors_belt_size",   "", "", 3);
        config_level_gamemode("orbs1",              "", "", 1);
        config_level_gamemode("orbs2",              "", "", 1);
        config_level_gamemode("orbs4",              "", "", 1);
    }
    else if(config == "full_colors")
    {
        config_level_gamemode("colors_belt_size",   "", "", 3);
        config_level_gamemode("orbs1",              "", "", 3);
        config_level_gamemode("orbs2",              "", "", 3);
        config_level_gamemode("orbs4",              "", "", 3);
    }
    else if(config == "blast_only")
    {
        config_level_gamemode("guy_orbit",          "", "", 1);
        config_level_gamemode("chargeball",         "", "", 1);
        config_level_gamemode("blast_mode",         "", "", 1);
        config_level_gamemode("orb_storage_size",   "", "", 9);
        config_level_gamemode("recovery",           "", "", 6);
    }
    else if(config == "basic_combat")
    {
        config_level_gamemode("guy_orbit",          "", "", 3);
        config_level_gamemode("chargeball",         "", "", 3);
        config_level_gamemode("dark_mode",          "", "", 1);
        config_level_gamemode("blast_mode",         "", "", 1);
        config_level_gamemode("barrage_mode",       "", "", 1);
        config_level_gamemode("dashwave_mode",      "", "", 1);
        config_level_gamemode("orb_storage_size",   "", "", 9);
        config_level_gamemode("channeling",         "", "", 1);
        config_level_gamemode("recovery",           "", "", 6);
    }
    else if(config == "shield")
    {
        config_level_gamemode("shield",             "", "", 1);
    }
    else if(config == "inventory")
    {
        config_level_gamemode("inventory",          "", "", 4);
    }
    else if(config == "dark_belt")
    {
        config_level_gamemode("dark_belt_size",     "", "", 1);
    }
    else if(config == "dark_orb")
    {
        config_level_gamemode("dark_belt_size",     "", "", 1);
        config_level_gamemode("orbs0",              "", "", 1);
    }
    else if(config == "no_dashwave")
    {
        config_level_gamemode("dashwave_mode",      "", "", 0, 0);
    }
    else if(config == "just_2orbs_start")
    {
        config_level_gamemode("guy_orbit",          "", "", "", 2);
        config_level_gamemode("chargeball",         "", "", "", 2);
    }
    else if(config == "no_attacks")
    {
        config_level_gamemode("dark_mode",          "", "", 0, 0);
        config_level_gamemode("blast_mode",         "", "", 0, 0);
        config_level_gamemode("barrage_mode",       "", "", 0, 0);
        config_level_gamemode("dashwave_mode",      "", "", 0, 0);
    }
    else if(config == "no_abilities")
    {
        config_level_gamemode("rewind",             "", "", 0, 0);
        config_level_gamemode("berserk",            "", "", 0, 0);
        config_level_gamemode("heal",               "", "", 0, 0);
        config_level_gamemode("teleport",           "", "", 0, 0);
        config_level_gamemode("haste",              "", "", 0, 0);
        config_level_gamemode("ubershield",         "", "", 0, 0);
        config_level_gamemode("invisibility",       "", "", 0, 0);
        config_level_gamemode("base_teleport",      "", "", 0, 0);
    }
    else if(config == "vortex")
    {
        config_level_gamemode("dark_mode",          "", "", 1);
        config_level_gamemode("dark_belt_size",     "", "", 1);
        config_level_gamemode("orbs0",              "", "", 1);
        config_level_gamemode("channeling",         "", "", 1);
        config_level_gamemode("chargeball",         "", "", 1);
        config_level_gamemode("guy_orbit",          "", "", 1);
    }
}
