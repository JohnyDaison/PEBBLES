/// @description  HANDLE STREAKS
killstreak = ds_map_find_value(stats,"killstreak");
if(killstreak > ds_map_find_value(stats,"best_killstreak"))
    ds_map_replace(stats,"best_killstreak",killstreak);
    
deathstreak = ds_map_find_value(stats,"deathstreak");
if(deathstreak > ds_map_find_value(stats,"best_deathstreak"))
    ds_map_replace(stats,"best_deathstreak",deathstreak);
    
spellstreak = ds_map_find_value(stats,"spellstreak");
if(spellstreak > ds_map_find_value(stats,"best_spellstreak"))
    ds_map_replace(stats,"best_spellstreak",spellstreak);
    
abilitystreak = ds_map_find_value(stats,"abilitystreak");
if(abilitystreak > ds_map_find_value(stats,"best_abilitystreak"))
    ds_map_replace(stats,"best_abilitystreak",abilitystreak);
    
combo = ds_map_find_value(stats,"combo");
if(combo > ds_map_find_value(stats,"best_combo"))
    ds_map_replace(stats,"best_combo",combo);

