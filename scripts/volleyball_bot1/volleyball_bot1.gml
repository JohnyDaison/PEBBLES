function volleyball_bot1(near_player) {
	if(npc_active || next_phase != 0)
	{
	    // NEAR PLAYER
	    var go_to_spawner = false;

	    if(instance_exists(place_controller_obj.da_ball))
	    {
	        var da_ball = place_controller_obj.da_ball;
        
	        var hspd = da_ball.hspeed;

	        var vspd = da_ball.vspeed;
	        //var y_diff = da_ball.y - my_spawner.y;
	        //var steps_ahead = round(abs(y_diff)/abs(vspd));
        
	        var zones = get_group("zones");
	        var pl1field = group_find_member(zones, "p1_field");
	        var pl2field = group_find_member(zones, "p2_field");
	        var net = shield_generator_structure_obj.id;
        
	        var left_edge = pl1field.bbox_left;
	        var right_edge = pl2field.bbox_right;

	        var target_x = da_ball.x;
	        var target_y = da_ball.y;
	        var steps_left = 0;
	        var bottom_y = my_spawner.y - 16 - da_ball.radius;
	        var net_y = net.y - 96;
        
	        var net_diff = da_ball.y - net.y;
	        var net_ratio = clamp(net_diff/160, -2, 1);
        
	        var ball_dir = point_direction(x,y, da_ball.x, da_ball.y);
	        var horizontal_flyover = (net_diff < 1 && net_diff > -2)
	                              && (abs(da_ball.vspeed) < abs(da_ball.hspeed) && abs(da_ball.hspeed) >= 8);
                              
	        var min_ball_dir = 30;
	        var max_ball_dir = 150;
        
	        /*
	        if((net_diff < -32 + da_ball.radius && da_ball.vspeed < 12) && !horizontal_flyover) // && (!horizontal_flyover || (abs(da_ball.hspeed) < 6 && ball_dir > min_ball_dir && ball_dir < max_ball_dir))
	        {
	            bottom_y = net.y;
	        }
	        */
                
	        ds_list_of_map_destroy(predicted_ball_path);
	        predicted_ball_path = ds_list_create();
        
	        var done = false;
        
	        while(target_y < bottom_y && !done)
	        {
	            if((target_x + hspd) < (left_edge + da_ball.radius) || (target_x + hspd) > (right_edge - da_ball.radius))
	            {
	                hspd *= -1;
	            }
            
	            /*
	                && (
	                (sign(target_x - (net.x - 32 - da_ball.radius)) != sign(target_x + hspd - (net.x - 32 - da_ball.radius)))
	             || (sign(target_x - (net.x + 32 + da_ball.radius)) != sign(target_x + hspd - (net.x + 32 + da_ball.radius)))
	            )
	            */
	            if(target_y + vspd > net.y - 32 && target_x + hspd > net.x - 32 && target_x + hspd < net.x + 32)
	            {
	                hspd *= -1;   
	            }
            
	            if(target_x + hspd > net.x - 32 && target_x + hspd < net.x + 32
	            && target_y < net.y - 32 && target_y + vspd > net.y - 32)
	            {
	                var ratio = (target_x - net.x)/32;
	                hspd += ratio * abs(vspd)/2;
	                vspd += -(1-ratio) * abs(vspd);
	            }
            
	            var spd = point_distance(0,0, hspd, vspd);
	            var friction_ratio = max(0, (spd - da_ball.friction))/spd;
	            hspd *= friction_ratio;
	            vspd *= friction_ratio;
            
	            vspd += da_ball.gravity_coef;
            
	            target_x += hspd;
	            target_y += vspd;
            
	            var point = ds_map_create();
	            point[? "x"] = target_x;
	            point[? "y"] = target_y;
            
	            ds_list_add(predicted_ball_path, point);
            
	            steps_left++;
            
	            /*
	            if(horizontal_flyover)
	            {
	                if(abs(target_x-x) < 32 && y > target_y && target_y > net.y - 96)
	                {
	                    done = true;
	                }
	            }
	            */
	        }
        
	        if(sign(target_x - net.x) != sign(x - net.x))
	        {
	            if(sign(da_ball.x - net.x) != sign(x - net.x))
	            {
	                npc_destination_reached = false;
	                npc_destination_x = net.x;
	                npc_destination_y = net.y - 48;
	                npc_destination = net;
                
	                npc_waypoint_x = npc_destination_x;
	                npc_waypoint_y = npc_destination_y;
	            }
	            else
	            {
	                go_to_spawner = true;
	            }
	        }
	        else
	        {
	            npc_destination_reached = false;
	            npc_destination_x = target_x;
	            npc_destination_y = my_spawner.y;
	            npc_destination = da_ball;
        
	            // JUMPING
	            /*
	            if(y > da_ball.y + 32 && (steps_left < 30 || horizontal_flyover))
	            {
	                if((da_ball.vspeed < 12 && sign(target_x - net.x) == sign(x - target_x))
	                || (horizontal_flyover && ball_dir > min_ball_dir && ball_dir < max_ball_dir)) 
	                {
	                    npc_destination_y = target_y + 16 * net_ratio;
	                }
            
	                var x_diff = da_ball.x - x;
	                var y_diff = da_ball.y - y;
            
	                if(!airborne && (abs(da_ball.hspeed) < 4 && y_diff < -16 && y_diff > -256) && ball_dir > min_ball_dir && ball_dir < max_ball_dir)
	                {
	                    npc_destination_y = da_ball.y - 32;
	                }
	            }
	            */
            
	            if((steps_left < 30 && abs(da_ball.vspeed) > abs(da_ball.hspeed))
	            && abs(x - npc_destination_x) < 16)
	            {
	                //npc_destination_x = da_ball.x + steps_left * da_ball.hspeed;
	                if(da_ball.y < y - 16)
	                {
	                    npc_destination_y = da_ball.y;
	                }
	            }
            
        
	            if(npc_destination_y > my_spawner.y)
	            {
	                npc_destination_y = my_spawner.y;
	            }
        
	            // HORIZONTAL
	            var hor_ratio = 1 - clamp(net_ratio, 0, 0.8);
	            var hor_offset_max = 8;
        
	            if(my_player.number == 1)
	            {
	                npc_destination_x -= hor_offset_max * hor_ratio;
	            }
	            else
	            {
	                npc_destination_x += hor_offset_max * hor_ratio;
	            }
        
	            npc_waypoint_x = npc_destination_x;
	            npc_waypoint_y = npc_destination_y;
        
	            /*
	            if(da_ball.y > y - 256 || steps_left < 20)
	            {
	                if(airborne)
	                {
	                    npc_destination_y = y - 96;
	                    npc_waypoint_y = y - 96;
	                }
	                else
	                {
	                    if(da_ball.vspeed < 0) //!(!my_player.touching_ball && my_player.was_touching_ball)
	                    {
	                        npc_destination_y = y - 96;
	                        npc_waypoint_y = y - 96;
	                    }
	                }
	            }
	            */
        
	            npc_last_stuck_check = singleton_obj.step_count;
	            npc_stuck = false;
	        }
        
	    }
	    else
	    {
	        go_to_spawner = true;
	    }
    
	    if(go_to_spawner)
	    {
	        npc_destination_reached = false;
	        npc_destination_x = my_spawner.x;
	        npc_destination_y = my_spawner.y;
	        npc_destination = my_spawner;
        
	        npc_waypoint_x = npc_destination_x;
	        npc_waypoint_y = npc_destination_y;
	    }

	    npc_guy2_step();
    
	    if(vspeed >= impact_speed)
	    {
	        vspeed = impact_speed - gravity_coef * 1.1; 
	    }
    
	    if(!instance_exists(speech_popup) && y > my_spawner.y + 16)
	    {
	        speech_start("bark/oops");
	    }
	}
}
