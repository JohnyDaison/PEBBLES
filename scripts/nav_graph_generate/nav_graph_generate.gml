/// @function nav_graph_generate
/// @param [remove_redundancy]
function nav_graph_generate() {
    var show_debug = false;
    var remove_redundancy = true;

    if(argument_count > 0)
    {
        remove_redundancy = argument[0];
    }

    var wp_group = get_group("waypoints");

    if(!instance_exists(wp_group))
    {
        return;
    }

    var wp_list = wp_group.members, count = ds_list_size(wp_list);
    var offset_size = 15;
    var i, j, wp1, wp2, dist, offset, blocker, terrain, nav_cost, cost;
    var forced = false, one_way_forward = false, one_way_backward = false, redundant = false, direct = 0, indirect = 0, up_cost = 0, danger = 0;
    var wp1wall, wp2wall;
    var results = ds_list_create(), result_number = 0, result_i, result;

    // add nodes
    for(i = 0; i < count; i++)
    {
        wp1 = wp_list[| i];
        nav_graph_add_node(wp1.waypoint_id, 1);
    }

    /*
    var debug_wp1 = "blue_orb/success";
    var debug_wp2 = "blue_wall_climb/active";
    var debug_edge = false;
    */

    // add edges
    for(i = 0; i < count -1; i++)
    {
        wp1 = wp_list[| i];
        for(j = i+1; j < count; j++)
        {
            wp2 = wp_list[| j];
            dist = point_distance(wp1.x, wp1.y, wp2.x, wp2.y);
            forced = false;
            one_way_forward = false;
            one_way_backward = false;
            redundant = false;
        
            /*
            if((wp1.waypoint_id == debug_wp1 || wp2.waypoint_id == debug_wp1)
                && (wp2.waypoint_id == debug_wp2 || wp1.waypoint_id == debug_wp2))
            {
                debug_edge = true;
            }
            */
        
            // forced
            if(wp1.connect_to == wp2.waypoint_id || wp2.connect_to == wp1.waypoint_id)
            {
                forced = true;
            }
        
            // one_way
            if(wp1.one_way_connect_to == wp2.waypoint_id || wp2.one_way_connect_from == wp1.waypoint_id)
            {
                forced = true;
                one_way_forward = true;
            }
            else if(wp1.one_way_connect_from == wp2.waypoint_id || wp2.one_way_connect_to == wp1.waypoint_id)
            {
                forced = true;
                one_way_backward = true;
            }
        
            if(forced || dist < DB.npc_waypoint_connect_dist)
            {
                // primitive solutions, do better! - probably should use the npc_line_of_sight somehow, or make nav_graph_line_of_sight?
                direct = 0;
                indirect = 0;
                up_cost = 0;
                danger = 0;
            
                wp1wall = wp1.wallclimb_point || wp1.walljump_point;
                wp2wall = wp2.wallclimb_point || wp2.walljump_point;

                // direct
                blocker = false;
                offset = 0;
                blocker = blocker || collision_line(wp1.x, wp1.y, wp2.x, wp2.y, terrain_obj, false, false);
            
                // terrain
                if(!blocker)
                {
                    if(!(wp1wall || wp2wall))
                    {
                        offset = offset_size;
                        blocker = blocker || collision_line(wp1.x + offset, wp1.y + offset, wp2.x + offset, wp2.y + offset, terrain_obj, false, false);
                        if(remove_redundancy)
                        {
                            blocker = blocker || collision_line(wp1.x + offset, wp1.y - offset, wp2.x + offset, wp2.y - offset, terrain_obj, false, false);
                        }
                        offset = -offset_size;
                        blocker = blocker || collision_line(wp1.x + offset, wp1.y + offset, wp2.x + offset, wp2.y + offset, terrain_obj, false, false);
                        if(remove_redundancy)
                        {
                            blocker = blocker || collision_line(wp1.x + offset, wp1.y - offset, wp2.x + offset, wp2.y - offset, terrain_obj, false, false);
                        }
                    }
                    else if(wp1wall && wp2wall)
                    {
                        offset = offset_size;
                        if(show_debug && DB.console_mode == "debug")
                        {
                            my_console_log(wp1.waypoint_id + "-" + wp2.waypoint_id + " BOTH WALL");
                        }
                    
                        // horizontal across space
                        var blocker_across = false;
                        blocker_across = blocker_across || collision_line(wp1.x, wp1.y - offset, wp2.x, wp2.y + offset, terrain_obj, false, false);
                        blocker_across = blocker_across || collision_line(wp1.x, wp1.y + offset, wp2.x, wp2.y - offset, terrain_obj, false, false);
                        // vertical on right side of wall
                        var right_side_blocker = false;
                        right_side_blocker = right_side_blocker || collision_line(wp1.x + 1, wp1.y, wp2.x + 1, wp2.y, terrain_obj, false, false);
                        // vertical on left side of wall
                        var left_side_blocker = false;
                        left_side_blocker = left_side_blocker || collision_line(wp1.x - 1, wp1.y, wp2.x - 1, wp2.y, terrain_obj, false, false);
                    
                        if(show_debug && DB.console_mode == "debug")
                        {
                            my_console_log("BLOCKERS:: HOR: " + string(blocker_across) + " R: " + string(right_side_blocker) + " L: " + string(left_side_blocker));
                        }
                    
                        blocker = blocker || ( blocker_across && right_side_blocker && left_side_blocker);
                    }
                    else if(wp1wall)
                    {
                        offset = offset_size;
                        blocker = blocker || collision_line(wp1.x, wp1.y, wp2.x + offset, wp2.y + offset, terrain_obj, false, false);
                        offset = -offset_size;
                        blocker = blocker || collision_line(wp1.x, wp1.y, wp2.x + offset, wp2.y + offset, terrain_obj, false, false);
                    }
                    else if(wp2wall)
                    {
                        offset = offset_size;
                        blocker = blocker || collision_line(wp1.x + offset, wp1.y + offset, wp2.x, wp2.y, terrain_obj, false, false);
                        offset = -offset_size;
                        blocker = blocker || collision_line(wp1.x + offset, wp1.y + offset, wp2.x, wp2.y, terrain_obj, false, false);
                    }
                }
            
                // other waypoints
                if(!blocker && remove_redundancy)
                {
                    ds_list_clear(results);
                    result_number = collision_line_list(wp1.x, wp1.y, wp2.x, wp2.y, npc_waypoint_obj, false, false, results, false);
                    for(result_i = 0; result_i < result_number; result_i++)
                    {
                        result = results[| result_i];
                        if(result != wp1 && result != wp2 && !result.airborne)
                        {
                            if(show_debug && DB.console_mode == "debug")
                            {
                                my_console_log(wp1.waypoint_id + "-" + wp2.waypoint_id + " REDUNDANT BECAUSE: " + string(result.waypoint_id));
                            }
                            redundant = true;
                            break;
                        }
                    }
                }
            
                if(redundant && !forced)
                {
                    continue;
                }
            
                if(!blocker)
                {
                    direct = 1;
                }
            
            
                result_number = 0;
                ds_list_clear(results);
            
                // indirect
                // TODO: maybe I should only count the indirect connection going through the higher of the 2 alternative points,
                // or connect the lower point only as downward edge, not upwards.
                if(!direct && wp1.auto_adjust && wp2.auto_adjust && !wp1.airborne && !wp2.airborne)
                {
                    // indirect 1
                    blocker = false;
                    offset = 0;
                    repeat(3)
                    {
                        blocker = blocker || collision_line(wp1.x + offset, wp1.y + offset, wp1.x + offset, wp2.y + offset, terrain_obj, false, false);
                        blocker = blocker || collision_line(wp1.x + offset, wp2.y + offset, wp2.x + offset, wp2.y + offset, terrain_obj, false, false);
                    
                        if(offset == 0)
                        {
                            offset = offset_size;
                        } 
                        else if(offset == offset_size)
                        {
                            offset = -offset_size;   
                        }
                    }
            
                    if(!blocker)
                    {
                        indirect += 1;
                    
                        if(remove_redundancy)
                        {
                            result_number += collision_line_list(wp1.x, wp1.y, wp1.x, wp2.y, npc_waypoint_obj, false, false, results, false);
                            result_number += collision_line_list(wp1.x, wp2.y, wp2.x, wp2.y, npc_waypoint_obj, false, false, results, false);
                        }
                    }
            
                    // indirect 2
                    blocker = false;
                    offset = 0;
                    repeat(3)
                    {
                        blocker = blocker || collision_line(wp1.x + offset, wp1.y + offset, wp2.x + offset, wp1.y + offset, terrain_obj, false, false);
                        blocker = blocker || collision_line(wp2.x + offset, wp1.y + offset, wp2.x + offset, wp2.y + offset, terrain_obj, false, false);
                    
                        if(offset == 0)
                        {
                            offset = offset_size;
                        } 
                        else if(offset == offset_size)
                        {
                            offset = -offset_size;   
                        }
                    }
            
                    if(!blocker)
                    {
                        indirect += 1;
                    
                        if(remove_redundancy)
                        {
                            result_number += collision_line_list(wp1.x, wp1.y, wp2.x, wp1.y, npc_waypoint_obj, false, false, results, false);
                            result_number += collision_line_list(wp2.x, wp1.y, wp2.x, wp2.y, npc_waypoint_obj, false, false, results, false);
                        }
                    }
                }
            
                for(result_i = 0; result_i < result_number; result_i++)
                {
                    result = results[| result_i];
                    if(result != wp1 && result != wp2 && !result.airborne)
                    {
                        redundant = true;
                        break;
                    }
                }
            
                if(redundant && !forced)
                {
                    continue;
                }
            
                // danger from dark force fields
                blocker = false;
                blocker = blocker || collision_rectangle(wp1.x, wp1.y, wp2.x, wp2.y, black_force_field_obj, false, false);
            
                if(blocker)
                {
                    danger += 5;
                }
            
                if(remove_redundancy) // it's costly
                {
                    // danger from bottomless pits
                    offset = 0;
                    var avg_x, avg_y;
                    repeat(3)
                    {
                        offset += 0.25;
                        avg_x = lerp(wp1.x, wp2.x, offset);
                        avg_y = lerp(wp1.y, wp2.y, offset);
                
                        terrain = false;
                        terrain = terrain || collision_line(avg_x, avg_y, avg_x, room_height, terrain_obj, false, false);
                
                        if(!terrain)
                        {
                            danger += (avg_y/room_height);
                        }
                    }
                }
            
                // cost
                if(forced || (direct + indirect > 0))
                {
                    var from_wp = wp1;
                    var to_wp = wp2;
                    var y_diff;
                
                    // from -> to and to -> from
                    repeat(2)
                    {
                        if((!one_way_forward || from_wp == wp1)
                        && (!one_way_backward || from_wp == wp2))
                        {
                            if(forced || wp1wall || wp2wall || from_wp.jump_pad_point          // unless wall-climbing or jump pads are involved,
                                || (from_wp.y - to_wp.y) < DB.npc_waypoint_oneway_vert_dist)   // long vertical connections only should go down
                            {
                                cost = dist;
                
                                // indirect
                                if(!direct) {
                                    cost *= 2 - (0.25*indirect);
                                }
                    
                                // airborne
                                if(from_wp.airborne || to_wp.airborne)
                                {
                                    cost *= 2;   
                                }
                    
                                // vertical bias
                                /*
                                y_diff = to_wp.y - from_wp.y;
                                cost += max(0, -y_diff*0.8);
                                */
                    
                                nav_cost = cost;
                
                                // danger
                                if(danger > 0)
                                {
                                    cost *= (1 + danger);
                                }
                
                                // conversion
                                nav_cost = ceil(nav_cost/DB.npc_waypoint_edge_length_coef);
                                cost = ceil(cost/DB.npc_waypoint_edge_length_coef);
                    
                                nav_graph_add_edge(from_wp.waypoint_id, to_wp.waypoint_id, "jump", cost, nav_cost);                    
                            }
                        }
                
                        from_wp = wp2;
                        to_wp = wp1;
                    }
                }
            }
        }
    }

    ds_list_destroy(results);
}
