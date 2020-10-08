/// @description is_wp_good_attack_pos(waypoint, wp_dist_to_target, my_dist_to_target)
/// @function is_wp_good_attack_pos
/// @param waypoint
/// @param wp_dist_to_target
/// @param my_dist_to_target
function is_wp_good_attack_pos() {

	var wp = argument[0];
	var wp_dist_to_target = argument[1];
	var my_dist_to_target = argument[2];

	return (instance_exists(wp) && !(wp.airborne || wp.wallclimb_point || wp.walljump_point || wp.dive_point)
	        && wp_dist_to_target < (my_dist_to_target + 160)
	        && npc_line_of_sight(wp.x, wp.y, "move"));


}
