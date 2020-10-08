/// @description match_stats_DisplayList_init(labels, stats)
/// @function match_stats_DisplayList_init
/// @param labels
/// @param  stats
function match_stats_DisplayList_init(argument0, argument1) {
	var labels = argument0;
	var stats = argument1;

	var i=0;

	labels[| i]  = "Match length";
	stats[| i++] = "match_length";

	labels[| i]  = "";
	stats[| i++] = "";

	labels[| i]  = "Artifacts spawned";
	stats[| i++] = "artifacts_spawned_total";
	labels[| i]  = "Artifacts destroyed";
	stats[| i++] = "artifacts_destroyed_total";
	labels[| i]  = "Mobs spawned";
	stats[| i++] = "mobs_spawned";
	labels[| i]  = "Total Snakes spawned";
	stats[| i++] = "snakes_spawned";
	labels[| i]  = "Live Snakes spawned";
	stats[| i++] = "snakes_alive";
	labels[| i]  = "Star Falls";
	stats[| i++] = "star_cores_spawned";

	labels[| i]  = "";
	stats[| i++] = "";
	labels[| i]  = "TERRAIN";
	stats[| i++] = "";

	labels[| i]  = "Original total";
	stats[| i++] = "terrain_original_total";
	labels[| i]  = "Original destroyable";
	stats[| i++] = "terrain_original_destroyable";
	labels[| i]  = "Destroyed";
	stats[| i++] = "terrain_destroyed_total";
	labels[| i]  = "Untouched";
	stats[| i++] = "terrain_untouched_total";



}
