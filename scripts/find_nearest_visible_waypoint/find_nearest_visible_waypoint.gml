/// @description find_nearest_visible_waypoint([type])
/// @function find_nearest_visible_waypoint
/// @param [type]
function find_nearest_visible_waypoint() {
	var type = "move";

	if(argument_count > 0)
	{
	    type = argument[0];
	}

	var nearest_waypoint = noone;
	var waypoint, dist, min_dist = 896;
	// 896 = 28*32 - problem is that waypoints outside active chunks still exist and can be visible even when they shouldn't be
	// solved by chunk_registering waypoints

	with(npc_waypoint_obj)
	{    
	    waypoint = id;
	    with(other)
	    {
	        if(waypoint.in_group)
	        {
	            dist = point_distance(x,y, waypoint.x, waypoint.y);
        
	            if(dist < min_dist && npc_line_of_sight(waypoint.x, waypoint.y, type))
	            {
	                nearest_waypoint = waypoint;
	                min_dist = dist;
	            }
	        }
	    }
	}

	return nearest_waypoint;


}
