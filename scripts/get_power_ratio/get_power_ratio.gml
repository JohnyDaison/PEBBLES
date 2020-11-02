/// @description get_power_ratio(attacker, defender)
/// @function get_power_ratio
/// @param attacker
/// @param defender
function get_power_ratio(attacker, defender) {
	if(attacker >= g_black && attacker <= g_octarine && defender >= g_black && defender <= g_octarine)
	{
	    var result = ds_grid_get(DB.colormatrix, round(attacker), round(defender));

        if(instance_exists(gamemode_obj)) {
            if(mod_get_state("equal_colors")) {
                if (result > 0) {
                    result = 0.75;
                }
            }
        }

        return result;
    }
}
