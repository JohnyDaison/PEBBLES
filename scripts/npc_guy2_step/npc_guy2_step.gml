function npc_guy2_step() {
	looking_up = false;
	looking_down = false;
	/*
	desired_aim_dir = 0;
	desired_aim_dist = 0;
	*/
	hor_dir_held = false;

	var vertical_waypoint_angle_range = 30;
	var waypoint_reset_delay = 420;
	var storey_height = 256;
	var facing_wall = false, jump_is_charged = false, near_edge = false, has_charged_jump = false, is_blocked = false, can_land = false, can_land_on_feet = false;
	var wp_y_range = 16;
	if(channeling)
	{
	    wp_y_range = 32;
	}
	var dest_x_range = npc_waypoint_idle_range;
	if(!object_is_child(npc_destination, npc_waypoint_obj))
	{
	    dest_x_range = 16;    
	}

	var at_waypoint = false;
	var at_destination = abs((x - npc_destination_x)) < dest_x_range && abs(y - npc_destination_y) < wp_y_range;

	nearest_waypoint = instance_nearest(x,y, npc_waypoint_obj);
	var nearest_wp_id = "";
	var nearest_wp_distance = -1;
	var at_nearest_waypoint = false;
	var near_point_exists = false;
	var near_fullstop_point = false;
	var fullstopped_on_point = false;
	var touching_nearest_wp = false;

	if(instance_exists(nearest_waypoint))
	{
	    nearest_wp_id = get_group_key(nearest_waypoint, get_group("waypoints"));
	    nearest_wp_distance = point_distance(x,y, nearest_waypoint.x, nearest_waypoint.y);
	    at_nearest_waypoint = abs((x - nearest_waypoint.x)) < npc_waypoint_idle_range && abs(y - nearest_waypoint.y) < wp_y_range;
    
	    near_point_exists = true;
	    near_fullstop_point = near_point_exists && nearest_waypoint.fullstop_point;
	    fullstopped_on_point = speed == 0 && abs((x - npc_waypoint_x)) < max_walking_speed;
    
	    if(nearest_waypoint.flyby_point)
	    {
	        at_nearest_waypoint = abs((x - nearest_waypoint.x)) < npc_waypoint_flyby_range && abs(y - nearest_waypoint.y) < npc_waypoint_flyby_range;
	    }
	}

	touching_nearest_wp = nearest_wp_distance != -1 && (nearest_wp_distance < npc_waypoint_idle_range || at_nearest_waypoint);


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
	    if(object_is_child(npc_destination, npc_waypoint_obj))
	    {
	        npc_destination_x = npc_destination.x;
	        npc_destination_y = npc_destination.y;   
	    }
    
	    // CANCEL DESTINATION MODE
	    if(destination_mode)
	    {
	        var dest_changed = npc_destination != npc_last_destination;
	        var move_los = npc_line_of_sight(npc_destination_x, npc_destination_y, "move");
        
	        if(dest_changed || npc_stuck || !move_los)
	        {
	            // my_console_log("INTERRUPT DEST MODE");
	            // my_console_log("DEST CHANGED: " + string(dest_changed) + " STUCK: " + string(npc_stuck) + " LOS: " + string(move_los));
	            destination_mode = false;
	            npc_last_waypoint = "";
	            npc_waypoint = "";
	        }
	    }
    
	    // UPDATE CURRENT WAYPOINT
	    if((npc_waypoint_reached || (npc_waypoint == "" && !destination_mode))
	    && (npc_last_waypoint != npc_final_waypoint))
	    {
	        if(npc_last_waypoint == "" && instance_exists(nearest_waypoint))
	        {
	            npc_waypoint = get_group_key(nearest_waypoint, get_group("waypoints"));
	            if(is_undefined(npc_waypoint))
	            {
	                npc_waypoint = "";   
	            }
	            npc_last_waypoint = npc_waypoint;
	            npc_last_waypoint_obj = nearest_waypoint;
	            npc_waypoint_x = nearest_waypoint.x;
	            npc_waypoint_y = nearest_waypoint.y;
	            destination_mode = false;
	            ds_list_clear(current_path); // clear current_path
	            // my_console_log("FIRST WP: " + npc_waypoint);
	            status_str += " GOTO FIRST " + npc_waypoint;
	        }
	        else if(npc_last_waypoint != "")
	        {
	            var path;
	            if(step_count - npc_last_find_path >= npc_find_path_wait_time)
	            {
	                status_str += " LAST: " + npc_last_waypoint + " FINAL: " + npc_final_waypoint;
	                path = nav_graph_find_path(npc_last_waypoint, npc_final_waypoint);
	                // my_console_log("nav_graph_find_path " + string(step_count));
	                npc_last_find_path = step_count;
                
	                npc_waypoint = path[| 0];
	                ds_list_copy(current_path, path); // update current_path
	                ds_list_destroy(path);
	            }
            
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
	                // my_console_log("GOTO WP: " + npc_waypoint);
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
    
	    // UPDATE CURRENT WAYPOINT'S LOCATION
	    if(!destination_mode)
	    {
	        var waypoint = group_find_member(get_group("waypoints"), npc_waypoint);
            
	        if(is_undefined(npc_waypoint))
	        {
	            npc_waypoint = "undefined";
	        }
            
	        if(!is_undefined(waypoint))
	        {
	            npc_waypoint_x = waypoint.x;
	            npc_waypoint_y = waypoint.y;
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

	    // UPDATE DESTINATION'S LOCATION
	    if(destination_mode)
	    {
	        npc_waypoint_x = npc_destination_x;
	        npc_waypoint_y = npc_destination_y;   
	    }
    
	    // COMPUTE BUNCH OF STUFF ABOUT THE WAYPOINT / DESIRED POSITION
	    var waypoint_dist = point_distance(x, y, npc_waypoint_x, npc_waypoint_y);
	    var waypoint_dir = point_direction(x, y, npc_waypoint_x, npc_waypoint_y);
	    cannot_see_waypoint = !npc_line_of_sight(npc_waypoint_x, npc_waypoint_y, "move");
	    var in_waypoint_column = abs((x - npc_waypoint_x)) < npc_waypoint_jump_range;
	    var above_waypoint = in_waypoint_column && (y - npc_waypoint_y) < -16;
	    at_waypoint = abs((x - npc_waypoint_x)) < npc_waypoint_idle_range && abs(y - npc_waypoint_y) < wp_y_range;
    
	    if(instance_exists(nearest_waypoint))
	    {
	        if(nearest_waypoint.waypoint_id == npc_waypoint)
	        {
	            at_waypoint = at_nearest_waypoint;
	        }
	    }
    
	    var waypoint_hdist = npc_waypoint_x - x;
	    var waypoint_is_above = waypoint_dist > npc_waypoint_idle_range && 
	        ( (waypoint_dir > 90 - vertical_waypoint_angle_range && waypoint_dir < 90 + vertical_waypoint_angle_range)
	            || (y - npc_waypoint_y) > storey_height);
	    var waypoint_is_below = waypoint_dist > npc_waypoint_idle_range && 
	        ( (waypoint_dir > 270 - vertical_waypoint_angle_range && waypoint_dir < 270 + vertical_waypoint_angle_range)
	            || (npc_waypoint_y - y) > storey_height);
    
	    var landing_distance = 48, temp_ter;

	    // RELEVANT TERRAIN/WALKABLE INSTANCES
	    next_body_terrain = instance_place(((x div 32) + facing) *32 +15, floor(y)+24, terrain_obj);
	    if(!instance_exists(next_body_terrain))
	    {
	        next_body_terrain = instance_place(((x div 32) + facing) *32 +15, floor(y)+24, platform_obj);
	    }
    
	    blocking_terrain = instance_place(x + facing + hspeed, floor(y)-4, terrain_obj);
    
	    if(airborne)
	    {
	        if(!instance_exists(landing_terrain))
	        {
	            temp_ter = instance_place(x + facing + lengthdir_x(landing_distance, direction), y + lengthdir_y(landing_distance, direction), terrain_obj);
            
	            if(instance_exists(temp_ter))
	            {
	                landing_terrain = temp_ter;
	            }
	        }
        
	        if(!instance_exists(landing_terrain) || abs(hspeed) < 6)
	        {
	            temp_ter = instance_place(x + facing + hspeed, y + 15, terrain_obj);
            
	            if(instance_exists(temp_ter))
	            {
	                landing_terrain = temp_ter;
	            }
	        }
    
	        if(!instance_exists(landing_terrain))
	        {
	            temp_ter = instance_place(x + facing + lengthdir_x(landing_distance, direction), y + lengthdir_y(landing_distance, direction), platform_obj);
            
	            if(instance_exists(temp_ter))
	            {
	                landing_terrain = temp_ter;
	            }
	        }
    
	        if(!instance_exists(landing_terrain) || abs(hspeed) < 6)
	        {
	            temp_ter = instance_place(x + facing + hspeed, y + 15, platform_obj);
            
	            if(instance_exists(temp_ter))
	            {
	                landing_terrain = temp_ter;
	            }
	        }
	    }
    
    
	    // RUN TO WAYPOINT
	    if(!holding_wall && abs(waypoint_hdist) > max_walking_speed)
	    {
	        set_guy_facing(sign(waypoint_hdist))
	        wanna_run = true;
	    }
	    else if(abs(waypoint_hdist) < max_walking_speed && abs(hspeed) < max_walking_speed)
	    {
	        wanna_run = false;
	    }
    
	    // this replaced waypoint_dist in jump_is_charged
	    //var max_axis_dist = max(abs(waypoint_hdist), abs(npc_waypoint_y - y));
    
	    // COMPUTE MORE CLEVER STUFF
	    facing_wall = place_meeting(x+facing, y, terrain_obj);
	    jump_is_charged = (self.jumping_charge >= ( min(1, waypoint_dist/npc_jump_dist) * jumping_max_charge ));
	    is_blocked = instance_exists(blocking_terrain);
    
	    if(airborne)
	    {
	        can_land = instance_exists(landing_terrain);
	        if(can_land)
	        {
	            var xx = landing_terrain.x;
	            //var yy = landing_terrain.y;
	            var yy = landing_terrain.bbox_top;
	            if(landing_terrain.obj_center_offset)
	            {
	                xx += lengthdir_x(landing_terrain.obj_center_dist, landing_terrain.obj_center_angle + landing_terrain.image_angle);
	                //yy += lengthdir_y(landing_terrain.obj_center_dist, landing_terrain.obj_center_angle + landing_terrain.image_angle);
	            }
	            can_land_on_feet = (y < yy) && (abs(x-xx) < 15 || abs(x-xx) < abs(y-yy));
	        }
	    }
    
    
    
	    // BEHAVIOURS
	    npc_wanna_rest = false;
	    npc_wanna_walljump = false;
    
	    // HOLDING WALL BEHAVIOUR
	    if(holding_wall && ((!at_waypoint && !above_waypoint) || (instance_exists(nearest_waypoint) && (nearest_waypoint.wallclimb_point || nearest_waypoint.walljump_point))))
	    {
	        wanna_run = true;
        
	        if(at_nearest_waypoint && (instance_exists(nearest_waypoint) && (nearest_waypoint.wallclimb_point || nearest_waypoint.walljump_point)))
	        {
	            if(nearest_waypoint.walljump_point)
	            {
	                npc_wanna_walljump = true;
	            }
            
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
	                    set_guy_facing(!facing_right);
	                }
	            }
	            if((singleton_obj.step_count - npc_wallhold_start) > npc_wallhold_time)
	            {   
	                wanna_jump = true;
	            }
	        }
        
	        if(npc_stuck)
	        {
	            var at_climbable_corner = facing_wall && !place_meeting(x,y-24,terrain_obj) && !place_meeting(x+facing*16,y-56,terrain_obj);
	            wanna_jump = at_climbable_corner;
	        }
	    }
	    // SEATED BEHAVIOUR
	    else if(seated)
	    {
	        if(at_nearest_waypoint && nearest_waypoint.cannon_point)
	        {
	            wanna_jump = !jumping_charge;
	        }
	    }
	    // GROUND BEHAVIOUR
	    else if(!airborne)
	    {
	        npc_wanna_jump = false;
            
	        underfeet_terrain = instance_place(x, y+1, terrain_obj);
	        if(!instance_exists(underfeet_terrain))
	        {
	            underfeet_terrain = instance_place(x, y+1, platform_obj);
	        }
	        if(!instance_exists(underfeet_terrain))
	        {
	            underfeet_terrain = instance_place(x, y+1, one_way_pass_obj);
	        }
    
        
	        near_edge = !instance_exists(next_body_terrain);
	        has_charged_jump = has_level(id, "charged_jump", 2);
        
	        var at_takeoff = near_edge && ( abs((x mod 32) - 15) > (15-abs(hspeed)) && sign((x mod 32) - 15) == facing );
	        var at_chargestart = at_takeoff;
	        //var edge_x = ((x div 32) + facing) *32;
        
	        if(has_charged_jump)
	        {
	            // this needs to be based on current hspeed and time-to-full-jump-charge, not constant
	            var x_offset = 96 * facing; // * abs(hspeed/running_maxspeed) * facing
	            //var x_offset = hspeed/running_maxspeed * 96; // * abs(hspeed/running_maxspeed) * facing
	            /*
	            if(abs(x_offset) > 0 && abs(x_offset) < 32)
	            {
	                x_offset = sign(x_offset) * 32;
	            }
	            */
	            //x_offset = sign(x_offset) * (abs(x_offset) div 32) * 32;
            
	            var takeoff_ter_x = ((x + x_offset) div 32) * 32;
            
	            next_takeoff_terrain = instance_place(takeoff_ter_x + 15, floor(y)+24, terrain_obj);
	            if(!instance_exists(next_takeoff_terrain))
	            {
	                next_takeoff_terrain = instance_place(takeoff_ter_x + 15, floor(y)+24, platform_obj);
	            }
	            at_chargestart = !instance_exists(next_takeoff_terrain);
	            //edge_x = takeoff_ter_x;
	        }
        
	        if(waypoint_is_above)
	        {
	            /*
	            if(cannot_see_waypoint)
	            {
	                set_guy_facing(!sign(waypoint_hdist));
	            }
	            */
	            npc_wanna_jump = true;
	        }
        
	        if(is_blocked
	        || (at_chargestart && !waypoint_is_below))
	        {
	            npc_wanna_jump = true;
	        }
        
	        if(at_nearest_waypoint && (instance_exists(nearest_waypoint) && nearest_waypoint.jump_pad_point))
	        {
	            npc_wanna_jump = false;
	        }
    
	        if(!at_waypoint && !above_waypoint)
	        {
	            if(npc_wanna_jump)
	            {
	                wanna_run = !facing_wall && !waypoint_is_above && abs(waypoint_hdist) > max_walking_speed;
                
	                if(!wanna_jump)
	                {
	                    wanna_jump = true;
	                    have_jumped = false;
	                }
                
	                if(jump_is_charged && (hspeed != 0 || charging || casting || sprite_index == my_skin[? "guy_crouch"]))
	                {
	                    wanna_jump = false;
	                }
	            }
	        }
	        else
	        {
	            wanna_jump = false;
	        }
        
        
	        var can_jump_through = false;
        
	        if(!can_jump_through) {
	            if(object_is_child(underfeet_terrain, structure_obj) && underfeet_terrain.walkable) {
	                can_jump_through = true;
	            }
	        }
        
	        if(above_waypoint && can_jump_through)
	        {
	            looking_down = true;
	            wanna_jump = true;
	        }
        
        
	        // START BREAKING EARLY (DUPLICATED ??)
	        if(!npc_wanna_jump && sign(waypoint_hdist) == sign(hspeed) && abs(waypoint_hdist) < (sqr(abs(hspeed)) / (2*(running_power*0.4 + friction))) )
	        {
	            set_guy_facing(!sign(waypoint_hdist));
	            wanna_run = true;
	        }
        
	        if(npc_stuck)
	        {
	            if(!npc_unstuck_done)
	            {
	                //wanna_jump = !wanna_jump;
	                //set_guy_facing(!facing_right);
	                npc_unstuck_done = true;
	            }
            
	            if((singleton_obj.step_count - npc_last_stuck_check) < npc_stuck_check_delay/2)
	            {
	                set_guy_facing(!npc_stuck_facing_right);
	                //wanna_run = !npc_stuck_wanna_run;
	            }
	            wanna_jump = !wanna_jump;
	            wanna_run = true;
	        }
	    }
	    // AIRBORNE/OTHER BEHAVIOUR
	    else
	    {
	        if(!at_waypoint && !above_waypoint)
	        {
	            // AM I FALLING AND IS IT A PROBLEM?
	            if(vspeed > gravity && (is_blocked 
	                || (!waypoint_is_below && (!can_land || !can_land_on_feet || waypoint_is_above))))
	            {
                
	                // WALL LANDING
	                if(can_land && !can_land_on_feet)
	                {
	                    // RESET COMBAT SCRIPT TO ABLE TO CLIMB
	                    wanna_cast = false;
	                    wanna_channel = false;
	                    if(bot_type == "arena_bot")
	                    {
	                        phase = 0;
	                    }
	                }
                
	                // JUMP FURIOUSLY
	                wanna_jump = !have_jumped && (!instance_exists(nearest_waypoint) || !nearest_waypoint.dive_point);
                
	                // CLING TO WALL
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
	            // WALLCLIMB/WALLJUMP WAYPOINT
	            if(at_waypoint && facing_wall && !holding_wall && (instance_exists(nearest_waypoint) && (nearest_waypoint.wallclimb_point || nearest_waypoint.walljump_point)))
	            {
	                wanna_jump = true;
	            }
	            else
	            {
	                wanna_jump = false;
	            }
	        }
        
	        // DIVE WAYPOINT
	        if(instance_exists(npc_last_waypoint_obj) && instance_exists(nearest_waypoint) && npc_last_waypoint_obj == nearest_waypoint && nearest_waypoint.dive_point)
	        {
	            looking_down = true;
	            wanna_jump = true;
	            doublejump_count = max(doublejump_count, max_doublejumps - 1);
	        }
        
	        // START BREAKING EARLY (HAS DUPLICATE)
	        if(!wanna_jump && abs(hspeed) > max_walking_speed && sign(waypoint_hdist) == sign(hspeed)
	        && abs(waypoint_hdist) < ( sqr(abs(hspeed)) / ( 2*(running_power * 0.4 + friction) ) ) )
	        {       
	            set_guy_facing(!sign(waypoint_hdist));
	            wanna_run = true;
	        }
                
	        // LEAVE SPAWN
	        if(at_nearest_waypoint && nearest_waypoint.spawn_point)
	        {
	            if(protected && locked)
	            {
	                wanna_run = true;   
	            }
	        }
	    }
    
    
	    // ARRIVE AT WAYPOINT
	    fullstopped_on_point = (speed == 0 && abs((x - npc_waypoint_x)) < max_walking_speed);
    
	    if(at_waypoint && !npc_waypoint_reached
	    && ( !( near_point_exists && (nearest_waypoint.wallclimb_point || nearest_waypoint.walljump_point) ) // either not a wall point
	        || holding_wall )) // or is a wall point and guy is holding wall
	    {
	        if(( ( !near_fullstop_point && speed <= max_walking_speed ) // on normal waypoint slow down to walk
	                || (near_fullstop_point && fullstopped_on_point) ) // on fullstop point stop
	            || ( npc_waypoint != npc_final_waypoint && (!airborne || holding_wall) ) // if it's not final wp, being on ground is enough, don't need to slow down
	            || ( near_point_exists && (nearest_waypoint.spawn_point || nearest_waypoint.airborne) )) // spawn and airborne points have no conditions
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
	    }
     
	    // ARRIVE AT DESTINATION
	    if(at_destination)
	    {
	        var stable = true;
	        if(npc_destination.object_index == npc_waypoint_obj)
	        {
	            stable = !airborne && speed < max_walking_speed;
	        }

	        if(stable && !npc_destination_reached)
	        {
	            npc_destination_reached = true;
	            npc_last_destination_x = npc_destination_x;
	            npc_last_destination_y = npc_destination_y;
	            destination_mode = false;
	            // my_console_log("DEST REACHED");
	            status_str += " DEST OK";
	        }
	    }
    
	    npc_last_destination = npc_destination;
	}


	// REST AND CHECK DESTINATION
	if(npc_destination_reached)
	{
	    wanna_run = false;
	    wanna_jump = false;
	    npc_wanna_rest = true;
	    npc_stuck = false;
	    npc_stuck_x = x;
	    npc_stuck_y = y;
	    npc_unstuck_done = true;
	    npc_last_stuck_check = singleton_obj.step_count;

	    if(!at_destination)
	    {
	        if(!instance_exists(npc_destination) && npc_destination != noone)
	        {
	            npc_destination = noone;
	        }   
        
	        npc_destination_reached = false;
	    }
	}

	/*
	if(status_str != "" && DB.console_mode == "debug")
	{
	    speech_instant(status_str);
	}
	*/


	// CHECK VISIBILITY OF NEAREST WAYPOINT
	if(instance_exists(nearest_waypoint))
	{
	    if(nearest_wp_id != npc_waypoint && nearest_wp_id != npc_last_waypoint
	    && (touching_nearest_wp
	        || (cannot_see_waypoint && ((npc_last_waypoint == npc_waypoint) || taking_too_long))
	    ))
	    {
	        var cannot_see_nearest = !npc_line_of_sight(nearest_waypoint.x, nearest_waypoint.y, "move");
    
	        // UPDATE NEAREST
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
	            /*
	            if(status_str != "" && DB.console_mode == "debug")
	            {
	                speech_instant(status_str);
	            }
	            */
            
	        }    
    
	        // UPDATE CURRENT AND LAST
	        if(!cannot_see_nearest)
	        {
	            status_str = "";
	            var wp_group = get_group("waypoints");
	            nearest_wp_id = get_group_key(nearest_waypoint, wp_group);
            
	            if(is_undefined(nearest_wp_id))
	            {
	                show_debug_message("Bad waypoint? " + string(nearest_waypoint) + " Waypoints group is broken? " + string(wp_group));
	                nearest_wp_id = "";
	                // bad, shouldn't happen, probably
	            }
    
	            // CAN'T SEE CURRENT, GOING TO NEAREST
	            if(cannot_see_waypoint)
	            {
	                status_str += " CAN'T SEE " + npc_waypoint;

	                npc_waypoint_x = nearest_waypoint.x;
	                npc_waypoint_y = nearest_waypoint.y;
	                npc_waypoint = nearest_wp_id;
        
	                status_str += ", GOING TO " + npc_waypoint;
	                /*
	                if(status_str != "" && DB.console_mode == "debug")
	                {
	                    speech_instant(status_str);
	                }
	                */
	            }
	            // I CAN SEE IT, SO I BASICALLY GOT THERE...
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
    
	            // SET LAST WAYPOINT TO NEAREST
	            npc_last_waypoint = nearest_wp_id;
	            npc_last_waypoint_obj = nearest_waypoint;
	            status_str += " " + npc_last_waypoint + " IS NOW LAST";
            
	            /*
	            if(status_str != "" && DB.console_mode == "debug")
	            {
	                speech_instant(status_str);
	            }
	            */
	        }
	    }
	}


	// CONFUSION counter
	if(status_left[? "confusion"] > 0)
	{
	    if(status_start[? "confusion"] != -1 && (step_count - status_start[? "confusion"]) > npc_confusion_start_delay)
	    {
	        npc_counter_confusion = true;
	        npc_counter_confusion_start = step_count;
	    }
	}
	else if(npc_counter_confusion)
	{
	    if(npc_counter_confusion_start != -1 && (step_count - npc_counter_confusion_start) > npc_confusion_stop_delay)
	    {
	        npc_counter_confusion = false;
	        npc_counter_confusion_start = -1;
	    }
	}


	// FINALIZE LEFT/RIGHT MOVEMENT
	if(wanna_run)
	{
	    hor_dir_held = true;

	    if(!holding_wall && npc_counter_confusion)
	    {
	        set_guy_facing(!facing_right);
	    }
	}


	// STUCK DETECTION
	if((singleton_obj.step_count - npc_last_stuck_check) > npc_stuck_check_delay)
	{
	    var was_stuck = npc_stuck;
	    npc_last_stuck_check = singleton_obj.step_count;
    
	    npc_stuck = !at_waypoint && !at_destination && !channeling && abs(x - npc_stuck_x) <= npc_stuck_dist && abs(y - npc_stuck_y) <= npc_stuck_dist;
    
	    if(!was_stuck && npc_stuck) {
	        npc_stuck_start = singleton_obj.step_count;
	    }
    
	    npc_stuck_x = x;
	    npc_stuck_y = y;
	    npc_stuck_wanna_run = wanna_run;
	    npc_stuck_facing_right = facing_right;
    
	    npc_unstuck_done = !npc_stuck;
    
	    /*
	    if(!npc_stuck)
	    {
	        npc_unstuck_done = false;
	    }
	    */
    
	    /*
	    if(npc_stuck && nearest_wp_distance > 64 && instance_exists(place_controller_obj) && place_controller_obj.auto_generate_nav_graph)
	    {
	        var wp_x = floor(x/32) * 32 + 16;
	        var wp_y = round(y/32) * 32;
	        var wp = instance_create(wp_x, wp_y, npc_waypoint_obj);
	        wp.airborne = true;
        
	        place_controller_obj.generate_nav_graph = true;
	        place_controller_obj.alarm[2] = 2;
	    }*/
	}

	// DONT MOVE WHEN BLACK PROJECTILE RETURNS
	if(place_meeting(x,y, black_projectile_obj) && black_projectile_obj.my_guy == id)
	{
	    wanna_run = false;
	    hor_dir_held = false;
	    wanna_jump = false;
	    npc_wanna_rest = true;
	}



}
