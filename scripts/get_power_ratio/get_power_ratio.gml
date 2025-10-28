function get_power_ratio(attacker, defender) {
    if (attacker >= g_dark && attacker <= g_octarine && defender >= g_dark && defender <= g_octarine)
    {
        var result = ds_grid_get(DB.colormatrix, round(attacker), round(defender));

        if (instance_exists(gamemode_obj) && rule_get_state("equal_colors")) {
            if (result > 0) {
                result = 1;
            }
        }

        return result;
    }
}
