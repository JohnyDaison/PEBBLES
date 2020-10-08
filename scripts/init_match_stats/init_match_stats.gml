/// @description init_match_stats()
/// @function init_match_stats
/// @param stats_map
function init_match_stats() {

	var stats = self.stats;

	stats[? "match_length"] = 0;
	stats[? "artifacts_spawned_total"] = 0;
	stats[? "artifacts_destroyed_total"] = 0;
	stats[? "mobs_spawned"] = 0;
	stats[? "snakes_spawned"] = 0;
	stats[? "snakes_alive"] = 0;
	stats[? "star_cores_spawned"] = 0;

	stats[? "terrain_original_total"] = 0;
	stats[? "terrain_original_destroyable"] = 0;
	stats[? "terrain_destroyed_total"] = 0;
	stats[? "terrain_untouched_total"] = 0;

	stats[? "secrets_total"] = 0;




}
