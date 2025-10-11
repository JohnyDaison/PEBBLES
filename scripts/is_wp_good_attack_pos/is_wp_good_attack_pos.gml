/// @self basic_bot
/// @param {Id.Instance} waypoint
/// @param {Real} wp_dist_to_target
/// @param {Real} my_dist_to_target
function is_wp_good_attack_pos(waypoint, wp_dist_to_target, my_dist_to_target) {
    if (!instance_exists(waypoint)) {
        return false;
    }

    var acrobaticsWaypoint = waypoint.airborne || waypoint.wallclimb_point || waypoint.walljump_point || waypoint.dive_point;
    var isNear = wp_dist_to_target < (my_dist_to_target + 160);

    return (!acrobaticsWaypoint && isNear && npc_line_of_sight(waypoint.x, waypoint.y, "move"));
}
