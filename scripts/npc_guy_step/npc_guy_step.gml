function npc_guy_step(argument0) {
	var near_player_guy = argument0;

	looking_up = false;
	looking_down = false;
	desired_aim_dir = 0;
	desired_aim_dist = 0;
	hor_dir_held = false;

	var vertical_waypoint_angle_range = 30;
	var waypoint_reset_delay = 420;
	var storey_height = 256;
	var facing_wall = false, jump_is_charged = false, near_edge = false, has_charged_jump = false, is_blocked = false, can_land = false;

	var at_waypoint = abs((x - npc_waypoint_x)) < npc_waypoint_idle_range && abs(y - npc_waypoint_y) < 16;
	var at_destination = abs((x - npc_destination_x)) < npc_waypoint_idle_range && abs(y - npc_destination_y) < 16;
	nearest_waypoint = instance_nearest(x,y, npc_waypoint_obj);
	var nearest_wp_id = "";
	var nearest_wp_distance = -1;
	var at_nearest_waypoint = false;

	if(instance_exists(nearest_waypoint))
	{
	    nearest_wp_id = get_group_key(nearest_waypoint, get_group("waypoints"));
	    nearest_wp_distance = point_distance(x,y, nearest_waypoint.x, nearest_waypoint.y);
	    at_nearest_waypoint = abs((x - nearest_waypoint.x)) < npc_waypoint_idle_range && abs(y - nearest_waypoint.y) < 16;
	}

	var touching_nearest_wp = nearest_wp_distance != -1 && nearest_wp_distance < npc_waypoint_idle_range;
	var taking_too_long = (singleton_obj.step_count - last_waypoint_change) > waypoint_reset_delay;

	cannot_see_waypoint = false;
	var status_str = "";

	underfeet_terrain = noone;
	next_body_terrain = noone;
	blocking_terrain = noone;
	next_takeoff_terrain = noone;
	landing_terrain = noone;

	// FOLLOW WAYPOINTS
	if(!npc_destination_reached && instance_exists(npc_destination))
	{
	    if((npc_waypoint_reached || npc_waypoint == "")
	    && (npc_last_waypoint != npc_final_waypoint))
	    {
	        if(npc_last_waypoint == "" && instance_exists(nearest_waypoint))
	        {
	            npc_waypoint = get_group_key(nearest_waypoint, get_group("waypoints"));
	            npc_last_waypoint = npc_waypoint;
	            npc_last_waypoint_obj = nearest_waypoint;
	            npc_waypoint_x = nearest_waypoint.x;
	            npc_waypoint_y = nearest_waypoint.y;
	            destination_mode = false;
	            status_str += " GOTO FIRST " + npc_waypoint;
	        }
	        else if(npc_last_waypoint != "")
	        {
	            var path = nav_graph_find_path(npc_last_waypoint, npc_final_waypoint);
	            npc_waypoint = path[| 0];
	            ds_list_copy(current_path, path); // update current_path
	            ds_list_destroy(path);
            
	            var waypoint = group_find_member(get_group("waypoints"), npc_waypoint);
            
	            if(is_undefined(npc_waypoint))
	            {
	                npc_waypoint = "undefined";
	            }
            
	            if(!is_undefined(waypoint))
	            {
	                npc_waypoint_x = waypoint.x;
	                npc_waypoint_y = waypoint.y;
	                destination_mode = false;
	                status_str += " GOTO " + npc_waypoint;
	            }
	            else
	            {
	                if(!destination_mode)
	                {
	                    status_str += " ERROR " + npc_waypoint;
	                    npc_waypoint_x = npc_destination_x;
	                    npc_waypoint_y = npc_destination_y;
	                    destination_mode = true;
	                    status_str += " DESTMODE ON";
	                }
	                npc_waypoint = "";
	            }
	        }

	        last_waypoint_change = singleton_obj.step_count;
	        npc_waypoint_reached = false;
	    }
    
	    var waypoint_dist = point_distance(x, y, npc_waypoint_x, npc_waypoint_y);
	    var waypoint_dir = point_direction(x, y, npc_waypoint_x, npc_waypoint_y);
	    cannot_see_waypoint = !npc_line_of_sight(npc_waypoint_x, npc_waypoint_y, "move");
	    var in_waypoint_column = abs((x - npc_waypoint_x)) < npc_waypoint_jump_range;
	    var above_waypoint = in_waypoint_column && y - npc_waypoint_y < -16;
	    at_waypoint = abs((x - npc_waypoint_x)) < npc_waypoint_idle_range && abs(y - npc_waypoint_y) < 16;
    
	    var waypoint_hdist = npc_waypoint_x - x;
	    var waypoint_is_above = waypoint_dist > npc_waypoint_idle_range && 
	        ( (waypoint_dir > 90 - vertical_waypoint_angle_range && waypoint_dir < 90 + vertical_waypoint_angle_range)
	            || (y - npc_waypoint_y) > storey_height);
	    var waypoint_is_below = waypoint_dist > npc_waypoint_idle_range && 
	        ( (waypoint_dir > 270 - vertical_waypoint_angle_range && waypoint_dir < 270 + vertical_waypoint_angle_range)
	            || (npc_waypoint_y - y) > storey_height);
    
	    var landing_distance = 48;

	    next_body_terrain = instance_place(((x div 32) + facing) *32 +15, floor(y)+24, terrain_obj);
	    if(!instance_exists(next_body_terrain))
	    {
	        next_body_terrain = instance_place(((x div 32) + facing) *32 +15, floor(y)+24, platform_obj);
	    }
    
	    blocking_terrain = instance_place(x + facing + hspeed, floor(y)-4, terrain_obj);
    
	    landing_terrain = instance_place(x + facing + lengthdir_x(landing_distance, direction), y + lengthdir_y(landing_distance, direction), terrain_obj);
	    if(!instance_exists(landing_terrain))
	    {
	        landing_terrain = instance_place(x + facing + lengthdir_x(landing_distance, direction), y + lengthdir_y(landing_distance, direction), platform_obj);
	    }
    
    
	    if(!holding_wall && abs(waypoint_hdist) > max_walking_speed)
	    {
	        facing_right = !!sign(waypoint_hdist);
	        wanna_run = true;
	    }
	    else if(abs(waypoint_hdist) < max_walking_speed && abs(hspeed) < max_walking_speed)
	    {
	        wanna_run = false;
	    }
	    npc_wanna_rest = false;
	    npc_wanna_walljump = false;
    
	    facing_wall = place_meeting(x+facing, y, terrain_obj);
	    jump_is_charged = self.jumping_charge == jumping_max_charge;
	    is_blocked = instance_exists(blocking_terrain);
	    can_land = instance_exists(landing_terrain);

    
	    if(holding_wall && ((!at_waypoint && !above_waypoint) || nearest_waypoint.walljump_point))
	    {
	        wanna_run = true;
        
	        if(at_nearest_waypoint && nearest_waypoint.walljump_point)
	        {
	            npc_wanna_walljump = true;
	            if(facing_wall && (singleton_obj.step_count - npc_wallhold_start) > npc_wallhold_time)
	            {
	                have_jumped = true;
	            }
	        }
        
	        if(have_jumped)
	        {
	            wanna_jump = false;
	            have_jumped = false;   
            
	            npc_resting = true;
	            npc_wallhold_start = singleton_obj.step_count;
	            //npc_wanna_walljump = irandom(1);
	        }
	        else
	        {
	            if(npc_wanna_walljump && (singleton_obj.step_count - npc_wallhold_start) > npc_wallturn_time)
	            { 
	                if(facing_wall)
	                {
	                    facing_right = !facing_right;
	                }
	            }
	            if((singleton_obj.step_count - npc_wallhold_start) > npc_wallhold_time)
	            {   
	                wanna_jump = true;
	            }
	        }
        
	        if(npc_stuck)
	        {
	            var at_corner = facing_wall && !place_meeting(x,y-24,terrain_obj) && !place_meeting(x+facing*16,y-56,terrain_obj);
	            wanna_jump = at_corner;
	        }
	    }
	    else if(!airborne)
	    {
	        npc_wanna_jump = false;
            
	        underfeet_terrain = instance_place(x, y+1, terrain_obj);
	        if(!instance_exists(underfeet_terrain))
	        {
	            underfeet_terrain = instance_place(x, y+1, platform_obj);
	        }
    
        
	        near_edge = !instance_exists(next_body_terrain);
	        has_charged_jump = has_level(id, "charged_jump", 1);
        
	        var at_takeoff = near_edge && ( abs((x mod 32) - 15) > (15-abs(hspeed)) && sign((x mod 32) - 15) == facing );
	        var at_chargestart = at_takeoff;
	        var edge_x = ((x div 32) + facing) *32;
        
	        if(has_charged_jump)
	        {
	            // this needs to be based on current hspeed and time-to-full-jump-charge, not constant
	            next_takeoff_terrain = instance_place(((x div 32) + 3*facing) *32 +15, floor(y)+24, terrain_obj);
	            if(!instance_exists(next_takeoff_terrain))
	            {
	                next_takeoff_terrain = instance_place(((x div 32) + 3*facing) *32 +15, floor(y)+24, platform_obj);
	            }
	            at_chargestart = !instance_exists(next_takeoff_terrain);
	            edge_x = ((x div 32) + 3*facing) *32;
	        }
        
	        if(waypoint_is_above)
	        {
	            /*
	            if(cannot_see_waypoint)
	            {
	                facing_right = !sign(waypoint_hdist);
	            }
	            */
	            npc_wanna_jump = true;
	        }
        
	        if(is_blocked
	        || (at_chargestart && !waypoint_is_below))
	        {
	            npc_wanna_jump = true;
	        }
        
	        if(at_nearest_waypoint && nearest_waypoint.jump_pad_point)
	        {
	            npc_wanna_jump = false;
	        }
    
	        if(!at_waypoint && !above_waypoint)
	        {
	            if(npc_wanna_jump)
	            {
	                wanna_run = !facing_wall && abs(waypoint_hdist) > max_walking_speed;
                
	                if(!wanna_jump)
	                {
	                    wanna_jump = true;
	                    have_jumped = false;
	                }
	                else if(jump_is_charged && (hspeed != 0 || sprite_index == my_skin[? "guy_crouch"]))
	                {
	                    wanna_jump = false;
	                }
	            }
	        }
	        else
	        {
	            wanna_jump = false;
	        }
        
	        if(object_is_child(underfeet_terrain, platform_obj) && above_waypoint)
	        {
	            looking_down = true;
	            wanna_jump = true;
	        }
        
	        if(!npc_wanna_jump && sign(waypoint_hdist) == sign(hspeed) && abs(waypoint_hdist) < (sqr(abs(hspeed)) / (2*(running_power*0.4 + friction))) )
	        {
	            facing_right = !sign(waypoint_hdist);
	            wanna_run = true;
	        }
	    }
	    else
	    {
	        if(!at_waypoint && !above_waypoint)
	        {
	            if(vspeed > gravity && (is_blocked 
	                || (!waypoint_is_below && (!can_land || waypoint_is_above))))
	            {
	                wanna_jump = !wanna_jump;
	                if(facing_wall && doublejump_count >= max_doublejumps - 1)
	                {
	                    wanna_run = true;   
	                }
	            }
	            else
	            {
	                wanna_jump = false;
	            }
	        }
	        else
	        {
	            if(at_waypoint && facing_wall && nearest_waypoint.walljump_point && !holding_wall)
	            {
	                wanna_jump = true;                
	            }
	            else
	            {
	                wanna_jump = false;
	            }
	        }
        
	        if(!wanna_jump && sign(waypoint_hdist) == sign(hspeed) && abs(waypoint_hdist) < (sqr(abs(hspeed)) / (2*(running_power*0.4 + friction))) )
	        {       
	            facing_right = !sign(waypoint_hdist);
	            wanna_run = true;
	        }
	    }
    
	    /*
	    if(cannot_see_waypoint)
	    {
	        // This is not good, needs the navigation graph
	        if(!airborne && in_waypoint_column)
	        {
	            var dir = sign(npc_waypoint_x - x);
            
	            var xx = npc_waypoint_x - dir*256;
            
	            var near_terrain = instance_nearest(xx, npc_waypoint_y + 32, terrain_obj);
            
	            if(instance_exists(near_terrain))
	            {
	                npc_waypoint_x = near_terrain.x + 16;
	                npc_waypoint_y = near_terrain.y - 32;
	            }
	        }
	    }
	    */
    
	    if(at_waypoint && !npc_waypoint_reached && (!nearest_waypoint.walljump_point || holding_wall)
	    && (speed <= max_walking_speed 
	        || (npc_waypoint != npc_final_waypoint && (!airborne || holding_wall))))
	    {
	        /*
	        npc_waypoint = npc_destination;
	        */

	        npc_waypoint_reached = true;
	        status_str += " WP OK";
	        npc_last_waypoint = npc_waypoint;
	        npc_last_waypoint_obj = nearest_waypoint;
        
	        if(npc_waypoint == npc_final_waypoint || npc_waypoint == "")
	        {
	            npc_waypoint_x = npc_destination_x;
	            npc_waypoint_y = npc_destination_y;
	            destination_mode = true;
	            status_str += " DESTMODE ON";
	        }        
	    } 
        
	    if(at_destination)
	    {
	        if(!airborne && !npc_destination_reached && speed < max_walking_speed)
	        {
	            npc_destination_reached = true;
	            npc_last_destination_x = npc_destination_x;
	            npc_last_destination_y = npc_destination_y;
	            destination_mode = false;
	            status_str += " DEST OK";
	        }
	    }
	}

	if(npc_destination_reached)
	{
	    wanna_run = false;
	    wanna_jump = false;
	    npc_wanna_rest = true;
    
	    // look at nearest guy
	    if(instance_exists(near_player_guy))
	    {
	        facing_right = (near_player_guy.x - x) > 0;
	    }
    
	    if(instance_exists(npc_destination))
	    {
	        if(!at_destination)
	        {
	            npc_destination_reached = false;
	        }
	    }
	}
	/*
	if(status_str != "")
	{
	    speech_instant(status_str);
	}
	*/

	if(instance_exists(nearest_waypoint))
	{
	    if(nearest_wp_id != npc_waypoint && nearest_wp_id != npc_last_waypoint
	    && (touching_nearest_wp
	        || (cannot_see_waypoint && ((npc_last_waypoint == npc_waypoint) || taking_too_long))
	    ))
	    {
	        var cannot_see_nearest = !npc_line_of_sight(nearest_waypoint.x, nearest_waypoint.y, "move");
    
	        if(cannot_see_nearest)
	        {
	            status_str = "";
        
	            status_str += " CAN'T SEE NEAREST";
	            nearest_waypoint = find_nearest_visible_waypoint();
	            if(instance_exists(nearest_waypoint))
	            {
	                cannot_see_nearest = false;
	                status_str += " - NEW NEAREST FOUND";
	            }
        
	            //speech_instant(status_str);
	        }    
    
	        if(!cannot_see_nearest)
	        {
	            status_str = "";
	            var wp_group = get_group("waypoints");
	            nearest_wp_id = get_group_key(nearest_waypoint, wp_group);
    
	            if(is_undefined(nearest_wp_id))
	            {
	                show_debug_message("Bad waypoint? " + string(nearest_waypoint) + " Waypoints group is broken? " + string(wp_group));
	                // bad, shouldn't happen, probably
	            }
            
	            if(cannot_see_waypoint)
	            {
	                status_str += " CAN'T SEE " + npc_waypoint;

	                npc_waypoint_x = nearest_waypoint.x;
	                npc_waypoint_y = nearest_waypoint.y;
	                npc_waypoint = nearest_wp_id;
        
	                status_str += ", GOING TO " + npc_waypoint;

	                //speech_instant(status_str);
	            }
	            else
	            {
	                npc_waypoint_reached = true;
	            }
    
	            status_str = "";
    
	            if(taking_too_long)
	            {
	                status_str += " TAKING TOO LONG, ";
	            }
	            else if(touching_nearest_wp)
	            {
	                status_str += " TOUCHED ";
	            }
    
	            npc_last_waypoint = nearest_wp_id;
	            npc_last_waypoint_obj = nearest_waypoint;
	            status_str += " " + npc_last_waypoint + " IS NOW LAST";
    
	            //speech_instant(status_str);
	        }
	    }
	}

	if(wanna_run)
	{
	    hor_dir_held = true;
	}

	if((singleton_obj.step_count - npc_last_stuck_check) > npc_stuck_check_delay)
	{
	    npc_last_stuck_check = singleton_obj.step_count;
    
	    npc_stuck = !at_waypoint && !at_destination && abs(x - npc_stuck_x) <= npc_stuck_dist && abs(y - npc_stuck_y) <= npc_stuck_dist;
    
	    npc_stuck_x = x;
	    npc_stuck_y = y;
	}


}
