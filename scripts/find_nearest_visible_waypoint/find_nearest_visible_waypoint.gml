/// @param {String} type
function find_nearest_visible_waypoint(type = "move") {
    var nearest_waypoint = noone;
    var min_dist = 896;
    // 896 = 28*32 - problem is that waypoints outside active chunks still exist and can be visible even when they shouldn't be
    // solved by chunk_registering waypoints

    with (npc_waypoint_obj) {
        var waypoint = self.id;

        if (!waypoint.in_group) {
            continue;
        }

        with (other) {
            var dist = point_distance(self.x, self.y, waypoint.x, waypoint.y);

            if (dist < min_dist && npc_line_of_sight(waypoint.x, waypoint.y, type)) {
                nearest_waypoint = waypoint;
                min_dist = dist;
            }
        }
    }

    return nearest_waypoint;
}
