/// @param player
function player_levels_give_hack(argument0) {
	var env = argument0;
	level_set(env, "charged_jump", 2);
	level_set(env, "air_jump", 2);
	level_set(env, "wall_hold", 1);
	level_set(env, "wall_climb", 2);
	level_set(env, "wall_jump", 3);

	level_set(env, "guy_orbit", 3);
	level_set(env, "chargeball", 3);
	level_set(env, "dark_mode", 1);
	level_set(env, "blast_mode", 1);
	level_set(env, "barrage_mode", 1);
	level_set(env, "dashwave_mode", 1);
	level_set(env, "shield", 1);
    
	level_set(env, "colors_belt_size", 3);
	level_set(env, "black_belt_size", 1);

	level_set(env, "orbs0", 1);
	level_set(env, "orbs1", 3);
	level_set(env, "orbs2", 3);
	level_set(env, "orbs4", 3);

	level_set(env, "channeling", 1);
	level_set(env, "recovery", 6);
    
	level_set(env, "rewind", 1);
	level_set(env, "berserk", 1);
	level_set(env, "heal", 1);
	level_set(env, "teleport", 1);
	level_set(env, "haste", 1);
	level_set(env, "ubershield", 1);
	level_set(env, "invisibility", 1);
	level_set(env, "base_teleport", 1);


}
